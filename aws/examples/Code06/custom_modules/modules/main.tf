resource "aws_instance" "webserver" {
  instance_type = "t2.micro"
  ami = "ami-0470e33cd681b2476"
  count = "${var.server_count}"
}