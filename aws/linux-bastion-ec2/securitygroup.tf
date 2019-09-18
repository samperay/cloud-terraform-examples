// create sg group for private subnets

resource "aws_security_group" "bastion-allow-private" {
  vpc_id      = "${aws_vpc.bastion.id}"
  name        = "bastion-sg-private"
  description = "sg for bastion hosts allows only SSH from puprivate subnets"

// allow to SSH from public subnets 

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

// Security group to allow inbound traffic 22 and all traffic outbound 

resource "aws_security_group" "bastion-allow-public" {
  vpc_id      = "${aws_vpc.bastion.id}"
  name        = "bastion-sg-public"
  description = "sg for bastion hosts allows only SSH from public subnets"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
