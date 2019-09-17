// create sg group for private subnets

resource "aws_security_group" "bastion-allow-private" {
  vpc_id      = "${aws_vpc.bastion.id}"
  name        = "bastion-sg"
  description = "sg for bastion hosts allows only SSH from puprivate subnets"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${aws_subnet.bastion-private-1.cidr_block}"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${aws_subnet.bastion-private-2.cidr_block}"]
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
  name        = "bastion-sg"
  description = "sg for bastion hosts allows only SSH from public subnets"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${aws_subnet.bastion-public-1.cidr_block}"]

    // allow public EC2 instance to connect SSH to private instances
    security_groups = ["${aws_security_group.bastion-allow-private.id}"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["${aws_subnet.bastion-public-2.cidr_block}"]
  }

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
    cidr_blocks = ["106.51.234.68/32"]
  }
}
