provider "aws" {
  region = "us-east-1"
}

resource "aws_instance" "example" {
  ami               = "${var.ami_id}"
  instance_type     = "${var.inst_type}"
  count 	    = "${var.inst_counts}"
  
  tags = {
    Name = "example"
  }
}
