variable "aws_access_key" {}

variable "aws_secret_key" {}

variable "aws_region" {
  default="ap-south-1"
}

variable "amiid" {
  type = "map"
}

variable "target_env" {
  default = "dev"
}