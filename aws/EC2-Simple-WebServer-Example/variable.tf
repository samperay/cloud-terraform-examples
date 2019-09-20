variable "AWS_ACCESS_KEY" {
}

variable "AWS_SECRET_KEY" {  
}

variable "AWS_REGION" {
}

variable "AMIS" {
  type = "map"
  default ={
      ap-south-1 = "ami-0912f71e06545ad88"
  }
}

variable "PUBLIC_KEY" {
  default ="mykey.pub"
}

variable "PRIVATE_KEY" {
  default = "mykey"
}
