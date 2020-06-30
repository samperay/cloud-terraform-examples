provider "aws" {
  profile = "default"
  region     =  "${var.aws_region}"
}

resource "aws_instance" "webserver" {
  instance_type = "t2.micro"
  ami = "${lookup(var.amiid, var.aws_region)}"
}

output "webserver-public-ip" {
  value = "${aws_instance.webserver.public_ip}"
}
