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
  default = "mykey.pub"
}

variable "PRIVATE_KEY" {
  default = "mykey"
}

