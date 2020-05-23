provider "aws" {
  profile = "default"
  region     = "${var.aws_region}"
}

resource "aws_instance" "webserver" {
  instance_type          = "t2.micro"
  ami                    = "${lookup(var.amiid, var.aws_region)}"
  key_name               = "${aws_key_pair.mykey.key_name}"
  subnet_id              = "${aws_default_subnet.default_subnet.id}"
  vpc_security_group_ids = ["${aws_security_group.web_server_sec_group.id}"]


  # Installing Apache using a provisioner

  provisioner "remote-exec" {
    inline = [
    "sudo yum install -y httpd",
    "sudo service httpd start",
    "sudo groupadd www",
    "sudo usermod -a -G www ec2-user",
    "sudo usermod -a -G www apache",
    "sudo chown -R apache:www /var/www",
    "sudo chmod 770 -R /var/www"
    ]
  }

  connection {
    type = "ssh"
    user = "ec2-user"
    private_key = "${file("mykey")}"
    host = "${aws_instance.webserver.public_ip}"
  }

  # upload files using a file provisioner
  provisioner "file" {
    source = "files/index.html"
    destination = "/var/www/html/index.html"
  }

  provisioner "file" {
    source = "files/bootstrap.sh"
    destination = "/tmp/bootstrap.sh"
  }
  provisioner "remote-exec" {
    inline = [
    "chmod +x /tmp/bootstrap.sh",
    "/tmp/bootstrap.sh"
    ]
  }
}

output "webserver-public-ip-1" {
  value = "${aws_instance.webserver.public_ip}"
}
