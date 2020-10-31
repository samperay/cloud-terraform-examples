provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "bp-infra" {
  ami                    = "ami-0947d2ba12ee1ff75"
  instance_type          = "t2.micro"
  vpc_security_group_ids = [ "vpc-01c9bae0dba6a67b5" ]
  key_name               = "bp-infra"
  subnet_id              = "subnet-00faea7bb0bdfd6a0"

  tags = {
    Name = "bp-infra"
  }
}
