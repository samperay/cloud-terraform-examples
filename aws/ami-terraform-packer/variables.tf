variable "AWS_ACCESS_KEY" {
}

variable "AWS_SECRET_KEY" {
}

variable "AWS_REGION" {
  default = "ap-south-1"
}

variable "AMIS" {
  type = "map"
  default = {
    ap-south-1 = "ami-020ca1ee6a0f716a9"
  }
}

variable "PUBLIC_KEY" {
  default ="mykey.pub"
}

variable "PRIVATE_KEY" {
  default = "mykey"
}

variable "INSTANCE_DEVICE_NAME" {
  default = "/dev/xvdh"
}
variable "JENKINS_VERSION" {
  default = "2.176.3"
}
variable "TERRAFORM_VERSION" {
  default = "0.11.7"
}

variable "APP_INSTANCE_COUNT" {
  default = "0"
}

