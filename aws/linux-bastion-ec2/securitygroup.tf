// Security group to allow inbound traffic 22 and all traffic outbound 

resource "aws_security_group" "bastion-allow-ssh" {
  vpc_id      = "${aws_vpc.bastion.id}"
  name        = "bastion-sg"
  description = "sg for bastion hosts allows only SSH"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${aws_subnet.bastion-public-1.cidr_block}"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${aws_subnet.bastion-public-2.cidr_block}"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
