resource "aws_instance" "web" {
  ami           = "${lookup(var.AMIS, var.AWS_REGION)}"
  instance_type = "t2.micro"
  key_name      = "${aws_key_pair.mykey.key_name}"
  count         = 2

  user_data = "#!/bin/bash\nsudo apt-get install apache2 -y\nsudo systemctl start apache2\nsudo curl http://169.254.169.254/latest/meta-data/public-ipv4 >index.html\nsudo cp ./index.html /var/www/html/index.html"

  tags = {
    Name = "web"
  }
}
