provider "aws" {
  profile = "default"
  region = "${var.aws_region}"
}

variable "aws_region" {
  default="ap-south-1"
}

module "custom_module" {
  source = "./modules/"
  server_count = 3
}