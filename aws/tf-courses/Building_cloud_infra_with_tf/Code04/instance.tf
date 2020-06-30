provider "aws" {
  profile = "default"
  region     =  "${ var.aws_region }"
}

resource "aws_instance" "webserver" {
  instance_type = "t2.micro"
  ami = "${ lookup(var.amiid, var.aws_region) }"

  # Implict resource dependency
  subnet_id = "${ aws_default_subnet.default_subnet.id }"

  # Explict resource dependency
  depends_on = ["aws_s3_bucket.application-bins"]

}

output "webserver-public-ip-1" {
  value = "${ aws_instance.webserver.public_ip }"
}