// creates a simple test instance in default VPC

resource "aws_instance" "example" {
  ami           = "${lookup(var.AMIS, var.AWS_REGION)}"
  instance_type = "t2.micro"
  key_name      = "${aws_key_pair.mykey.key_name}"
  count         = 1

  tags = {
    Name = "example"
  }

  provisioner "remote-exec" {
    inline = [" sudo yum install python -y"]
  }

  connection {
    host        = "${self.public_ip}"
    user        = "ec2-user"
    private_key = "${file("${var.PRIVATE_KEY}")}"
  }

  provisioner "local-exec" {
    command = "ansible-playbook -u ec2-user -i '${self.public_ip},' --private-key ${aws_key_pair.mykey.key_name} install_web.yml"
  }
}


terraform {
  backend "s3" {
    bucket = "terraformstate-files"
    key = "remote_state"
    region = "ap-south-1"
  }
}