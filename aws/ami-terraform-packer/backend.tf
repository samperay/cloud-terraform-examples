terraform {
  backend "s3" {
    bucket = "terraform-state-ami-packer"
    key    = "terraform.tfstate"
    region = "ap-south-1"
  }
}
