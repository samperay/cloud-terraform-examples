provider "aws" {
  region  = var.region
  profile = "default"
}

locals {
  time = formatdate("DD MMM YYYY hh:mm ZZZ", timestamp())
}

variable "region" {
  default = "ap-south-1"
}

variable "tags" {
  type    = list
  default = ["dev", "qa", "prod"]
}

variable "ami" {
  type = map
  default = {
    "us-east-1"  = "ami-0323c3dd2da7fb37d"
    "us-west-2"  = "ami-0d6621c01e8c2de2c"
    "ap-south-1" = "ami-0447a12f28fddb066"
  }
}

resource "aws_instance" "app-dev" {
  ami           = lookup(var.ami, var.region)
  instance_type = "t2.micro"
  count         = 3

  tags = {
    Name = element(var.tags, count.index)
  }
}

output "timestamp" {
  value = local.time
}
