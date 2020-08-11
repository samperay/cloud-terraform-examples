// create tags on the resources
locals {
  common_tags = {
    Owner      = "Devops"
    Service    = "rundeck"
    BU         = "CloudAutomation"
    CostCenter = "98856"
    Name       = "rundeck"
  }
}

// create EIP for the instance
resource "aws_eip" "rundeckeip" {
  vpc  = true
  tags = local.common_tags
}

// associate EIP to ec2 instance
resource "aws_eip_association" "eip_assoc" {
  instance_id   = aws_instance.myec2.id
  allocation_id = aws_eip.rundeckeip.id
  depends_on    = [aws_instance.rundeckec2]
}

resource "aws_instance" "rundeckec2" {
  ami           = var.ami_id
  instance_type = var.instancetype
  user_data     = "scripts/install.sh"
  depends_on    = [aws_eip.rundeckeip]
  tags          = local.common_tags
}

resource "aws_security_group" "allow_tls" {
  name = "rundeckec2-sg"
  ingress {
    from_port   = 4440
    to_port     = 4440
    protocol    = "tcp"
    cidr_blocks = ["${aws_eip.rundeckeip.public_ip}/32"]
  }
  tags = local.common_tags
}
