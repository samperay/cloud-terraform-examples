provider "aws" {
  region = "us-east-1"
}

// Create EC2 instance

resource "aws_instance" "vsure" {
  ami               = "ami-0affd4508a5d2481b"
  instance_type     = "t2.micro"
  count             = 1
  key_name          = "bo-vsure"
  security_groups   = ["sg-083534a96a94aa13c"]
  subnet_id         = "subnet-76877557"
  availability_zone = "us-east-1d"

  tags = {
    Name = "vsure-terraform"
  }
}

# // unable to EIP as limit has crossed

# // create EIP
# resource "aws_eip" "vsureeip" {
#   instance = "aws_instance.vsure.id"
#   vpc      = true

#   tags = {
#       Name = "vsuretfeip"
#   }
# }

# // attach EIP to instance

# resource "aws_eip_association" "vsureeipassoc" {
#   instance_id   = "aws_instance.vsure.id"
#   allocation_id = "aws_eip.vsureeip.id"
# }

// Create EBS Volumes

resource "aws_ebs_volume" "vsurevol" {
  availability_zone = "us-east-1d"
  type              = "gp2"
  size              = 10

  tags = {
    Name = "vsure-terraform-ebsvol"
  }
}

// attach EBS volume to the instance
resource "aws_volume_attachment" "vsurevolatt" {
  device_name  = "/dev/sdb"
  volume_id    = "aws_ebs_volume.vsurevol.id"
  instance_id  = "aws_instance.vsure.id"
  skip_destroy = false
}
