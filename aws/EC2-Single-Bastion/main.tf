provider "aws" {
  region = "ap-south-1"
}

resource "aws_volume_attachment" "ebs_att" {
  device_name = "/dev/sdh"
  volume_id   = "${aws_ebs_volume.example.id}"
  instance_id = "${aws_instance.bastion.id}"
}

resource "aws_instance" "bastion" {
  ami               = "ami-0470e33cd681b2476"
  availability_zone = "ap-south-1a"
  instance_type     = "t2.micro"
  key_name          = "MyLinuxEC2KeyPair"
  security_groups   = ["sg-0448fa0acdf8474f0"]
  subnet_id         = "subnet-5a2a5533"
  
  tags = {
    Name = "bastion"
  }
}

resource "aws_ebs_volume" "example" {
  availability_zone = "ap-south-1a"
  size              = 5
}
