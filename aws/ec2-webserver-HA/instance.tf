resource "aws_instance" "web" {
  ami           = "${lookup(var.AMIS, var.AWS_REGION)}"
  instance_type = "t2.micro"
  key_name      = "${aws_key_pair.mykey.key_name}"
  count         = 2

  provisioner "file" {
      source = "scripts/script.sh"
      destination = "/tmp/script.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/script.sh",
      "sudo /tmp/script.sh | tee script-output.log"
    ]
  }

  connection {
    host = "${self.public_ip}"
    user = "ubuntu"
    private_key = "${file("${var.PRIVATE_KEY}")}"
  }

  tags = {
    Name = "web"
  }
}
