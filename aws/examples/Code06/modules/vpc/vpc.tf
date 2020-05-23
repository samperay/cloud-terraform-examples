module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "demo"
  cidr = "10.0.0.0/16"

  azs             = ["ap-south-1a", "ap-south-1b", "ap-south-1c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway = true
  enable_vpn_gateway = true

  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}

provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region = "ap-south-1"
}

resource "aws_instance" "webserver" {
  instance_type = "t2.micro"
  ami = "${ lookup(var.amiid, var.aws_region) }"
  subnet_id = "${module.vpc.public_subnets[0]}"
}