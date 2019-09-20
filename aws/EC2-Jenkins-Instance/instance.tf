resource "aws_instance" "jenkins-instance" {
  ami                    = "${lookup(var.AMIS, var.AWS_REGION)}"
  instance_type          = "t2.small"
  subnet_id              = "${aws_subnet.main-public-1.id}"
  vpc_security_group_ids = ["${aws_security_group.jenkins-sg.id}"]
  key_name               = "${aws_key_pair.mykey.key_name}"
  user_data              = "${data.template_cloudinit_config.cloudinit-jenkins.rendered}"

  tags = {
    Name = "jenkins-instance"
  }
}

resource "aws_ebs_volume" "jenkins-data" {
  availability_zone = "ap-south-1a"
  size              = 20
  type              = "gp2"
  tags = {
    Name = "jenkins-data"
  }
}

resource "aws_volume_attachment" "jenkins-data-attachment" {
  device_name  = "${var.INSTANCE_DEVICE_NAME}"
  volume_id    = "${aws_ebs_volume.jenkins-data.id}"
  instance_id  = "${aws_instance.jenkins-instance.id}"
  skip_destroy = true
}