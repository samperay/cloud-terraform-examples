terraform {
  required_version = ">=0.12, <0.13"
}

provider "aws" {
  region = "ap-south-1"
}

# one user to creaete without vars.tf 

/*
resource "aws_iam_user" "example" {
  name = "guru"
}
*/

# user to be created using vars.tf 

/*
resource "aws_iam_user" "example" {
  name = var.username
}
*/

# multiple users to be created 
/*
resource "aws_iam_user" "example" {
  count = 2
  name = guru.${count.index}
}
*/

# Create list of users with multiple names and traverse the index
resource "aws_iam_user" "example" {
  # lenght of the list defined in the usernames
  count = length(var.username)
  # create list of users till the array index
  name = var.username[count.index]
}

