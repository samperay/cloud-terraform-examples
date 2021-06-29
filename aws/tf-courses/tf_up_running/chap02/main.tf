provider "aws" {
  region = "ap-south-1"
}

resource "aws_instance" "example" {
  ami = "ami-0c1a7f89451184c8b"
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.instance-sg.id]
  user_data = <<-EOF
            #!/bin/bash
            echo "Hello World" > index.html
            nohup busybox httpd -f -p ${var.server_port} &
            EOF
  tags = {
    Name = "terrafom-up-running"
  }
}

resource "aws_security_group" "instance-sg" {
  name = var.sg_name

  ingress {
    from_port = var.server_port
    to_port = var.server_port 
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
  }

  
}