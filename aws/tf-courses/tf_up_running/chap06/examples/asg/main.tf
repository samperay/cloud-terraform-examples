
terraform {
  required_version = ">= 0.12, < 0.13"
}

provider "aws" {
  region = "ap-south-1"
  # Allow any 2.x version of the AWS provider
  version = "~> 2.0"
}

module "asg" {
  source = "../../modules/cluster/asg"
  cluster_name = var.cluster_name
  ami           = "ami-0c1a7f89451184c8b"
  instance_type = "t2.micro"
  min_size           = 1
  max_size           = 1
  enable_autoscaling = false
  subnet_ids         = data.aws_subnet_ids.default.ids
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnet_ids" "default" {
  vpc_id = data.aws_vpc.default.id
}