terraform {
  required_version = ">=0.12, <0.13"
}

# create launch configuration for ASG
resource "aws_launch_configuration" "example" {
  image_id        = "ami-0c1a7f89451184c8b"
  instance_type   = var.instance_type
  security_groups = [aws_security_group.example-sg.id]
  user_data       = var.user_data

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
    from_port   = var.server_port
    to_port     = var.server_port
    protocol    = "tcp"
    cidr_blocks = local.all_ips
  }
}

# create an auto-scaling group
resource "aws_autoscaling_group" "example" {
  name                 = "${var.cluster_name}-${aws_launch_configuration.example.name}"
  launch_configuration = aws_launch_configuration.example.name
  vpc_zone_identifier  = var.subnet_ids
  target_group_arns    = var.target_group_arns
  health_check_type    = var.health_check_type
  min_size             = var.min_size
  max_size             = var.max_size

  # wait for atlest this many instances to pass health checks before considering ASG deployment complete
  min_elb_capacity = var.min_size

  # When replacing this ASG, create the replacement first, and only delete the
  # original after
  lifecycle {
    create_before_destroy = true
  }

  tag {
    key                 = "Name"
    value               = "${var.cluster_name}-asg"
    propagate_at_launch = true
  }

  # create a dynamic values for the tagging 
  dynamic "tag" {
    for_each = var.custom_tags

    content {
      key                 = tag.key
      value               = tag.value
      propagate_at_launch = true
    }
  }
}

locals {
  all_ips = ["0.0.0.0/0"]
}