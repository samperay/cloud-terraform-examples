provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key =  "${var.aws_secret_key}"
  region     =  "${var.aws_region}"
}

resource "aws_instance" "webserver" {
  instance_type = "t2.micro"
  ami = "${lookup(var.amiid, var.aws_region)}"
}

