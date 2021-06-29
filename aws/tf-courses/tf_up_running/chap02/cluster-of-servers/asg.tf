# README

# -  Create the terraform requirements for the code
# -  Create the launch configurations 
# -  Get details from the VPC which requires for ASG for HA
# -  Create autoscaling group that refers to launch configurations 
# -  Create security group for EC2 in the launch configurations
# -  Create Load Balancer
# -  Create security groups for the Load Balancer
# -  Create listeners 
# -  Create target groups
# -  Create listener rules

terraform {
  required_version = ">=0.12, <0.13"
}

provider "aws" {
  region = "ap-south-1"
  version = "~> 3.0"
}

# create launch configuration for ASG
resource "aws_launch_configuration" "example" {
  image_id = "ami-0c1a7f89451184c8b"
  instance_type = "t2.micro"
  security_groups = [aws_security_group.example-sg.id]

  user_data = <<-EOF
          #!/bin/bash
          echo "Hello World" > index.html
          nohup busybox httpd -f -p ${var.server_port} &
          EOF

  # launch configs are immutable, so if you change anything in the configs, terraform won't be able to delete 
  # older resources as ASG is referring to it. so we will create lifecyclem which creates newer instances 
  # and once they are up and running, it will be deleting the older instances by keeping the defaults min values

  lifecycle {
    create_before_destroy = true
  }
}

# Create security group 
resource "aws_security_group" "example-sg" {
  name = var.sg_name

  ingress {
    from_port = var.server_port
    to_port = var.server_port 
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  } 
}

# Find default vpc
data "aws_vpc" "default" {
  default = true
}

# get subnet details from defaut vpc
data "aws_subnet_ids" "default" {
  vpc_id = data.aws_vpc.default.id
}

# create an auto-scaling group
resource "aws_autoscaling_group" "example" {
  launch_configuration = aws_launch_configuration.example.name
  vpc_zone_identifier = data.aws_subnet_ids.default.ids
  target_group_arns = [aws_lb_target_group.asg.arn]
  health_check_type = "ELB"
  min_size = 3
  max_size = 4

  tag {
    key = "Name"
    value = "terraform-asg-example"
    propagate_at_launch = true 
  }
}

# create a security group for ALB 
resource "aws_security_group" "alb" {
  name = "terraform-example-alb"

  ingress {
    cidr_blocks = [ "0.0.0.0/0" ]
    description = "Inbound Security ALB"
    from_port = 80
    protocol = "tcp"
    to_port = 80
  }

  egress {
    cidr_blocks = [ "0.0.0.0/0" ]
    description = "outbound security ALB"
    from_port = 0
    protocol = "-1"
    to_port = 0
  }
}

# Deploying the Load Balancer
resource "aws_lb" "example" {
  name = "terraform-asg-example"
  load_balancer_type = "application"
  subnets = data.aws_subnet_ids.default.ids
  security_groups = [aws_security_group.alb.id]
}

# create listeners 
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.example.arn
  port = 80 
  protocol = "HTTP"

  default_action {
    type = "fixed-response"
    
    fixed_response {
      content_type = "text/plain"
      message_body = "404: page not found"
      status_code = 404
    }
  }
}

# create a target group 
resource "aws_lb_target_group" "asg" {
  name = "terraform-asg-example"
  port = var.server_port
  protocol = "HTTP"
  vpc_id = data.aws_subnet_ids.default.id

  health_check {
    path = "/"
    protocol = "HTTP"
    matcher = "200"
    interval = 15
    timeout = 3 
    healthy_threshold = 2 
    unhealthy_threshold = 2 
  }
}

# creatin listener rule 
resource "aws_lb_listener_rule" "asg" {
  listener_arn = aws_lb_listener.http.arn
  priority = 100

  condition {
    path_pattern {
      values = ["*"]
    }
  }

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.asg.arn
  }
}