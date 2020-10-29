provider "aws" {
 region = "ap-south-1"
 profile = "default"
}


resource "aws_s3_bucket" "b" {
  bucket = "sunil-amperayani-test-bucket"
  acl    = "private"

  tags = {
    Name        = "sunil.amperayani@brillio.com"
    Environment = "test"
  }
}
