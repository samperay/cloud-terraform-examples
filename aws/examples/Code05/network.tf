resource "aws_default_subnet" "default_subnet" {
  availability_zone = "ap-south-1a"
}

resource "aws_security_group" "web_server_sec_group" {
  name = "web server security group"

# allow ssh only
  ingress {
  from_port = 0
  to_port = 22
  protocol = "tcp"
  cidr_blocks = ["106.51.234.68/32"]
  }

  ingress {
  from_port = 0
  to_port = 80
  protocol = "tcp"
  cidr_blocks = ["106.51.234.68/32"]
  }
    
  egress {
  from_port = 0
  to_port = 0
  protocol = "-1"
  cidr_blocks = ["0.0.0.0/0"]
  }
}