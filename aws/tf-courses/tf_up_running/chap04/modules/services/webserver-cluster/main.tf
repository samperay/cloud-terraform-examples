terraform {
  required_version = ">=0.12, <0.13"
}

# create launch configuration for ASG
resource "aws_launch_configuration" "example" {
  image_id = "ami-0c1a7f89451184c8b"
  instance_type = var.instance_type
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
    cidr_blocks = local.all_ips
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
  min_size = var.min_size
  max_size = var.max_size

  tag {
    key = "Name"
    value = "${var.cluster_name}-asg"
    propagate_at_launch = true 
  }
}

# create a security group for ALB 
resource "aws_security_group" "alb" {
  name = "${var.cluster_name}-alb"
}

# different resource groups for the rules are always required else you might have routing rules conflict
# and overwrite eachother

resource "aws_security_group_rule" "allow_http_inbound" {
  type              = "ingress"
  security_group_id = aws_security_group.alb.id

  from_port   = local.http_port
  to_port     = local.http_port
  protocol    = local.tcp_protocol
  cidr_blocks = local.all_ips
}

resource "aws_security_group_rule" "allow_all_outbound" {
  type              = "egress"
  security_group_id = aws_security_group.alb.id

  from_port   = local.any_port
  to_port     = local.any_port
  protocol    = local.any_protocol
  cidr_blocks = local.all_ips
}

# Deploying the Load Balancer
resource "aws_lb" "example" {
  name = "${var.cluster_name}-alb"
  load_balancer_type = "application"
  subnets = data.aws_subnet_ids.default.ids
  security_groups = [aws_security_group.alb.id]
}

# create listeners 
resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.example.arn
  port = local.http_port 
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
  name = "${var.cluster_name}-alb-tg"
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

# few of the values are constant (e.g http, cidr, from_port, to_port), these values are hardcoded in multiple places 
# making code to be difficult to read and maintain. 

# Now code is read easily and maintained.

locals {
  http_port    = 80
  any_port     = 0
  any_protocol = "-1"
  tcp_protocol = "tcp"
  all_ips      = ["0.0.0.0/0"]
}