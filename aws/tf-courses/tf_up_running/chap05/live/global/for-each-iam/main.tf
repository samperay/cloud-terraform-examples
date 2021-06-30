terraform {
  required_version = ">=0.12, <0.13"
}

provider "aws" {
  region = "ap-south-1"
}

resource "aws_iam_user" "example" {
  for_each = toset(var.username)
  name = each.value
}

output "alluser" {
  value = values(aws_iam_user.example)[*].arn
  description = "usernames created"
}