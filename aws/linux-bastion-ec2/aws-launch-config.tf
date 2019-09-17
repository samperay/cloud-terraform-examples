// launch configuration for linux bastion hosts

resource "aws_launch_configuration" "bastion-lc" {
  name            = "bastion"
  image_id        = "${lookup(var.AMIS, var.AWS_REGION)}"
  instance_type   = "t2.micro"
  key_name        = "${aws_key_pair.mykey.key_name}"
  security_groups = ["${aws_security_group.bastion-allow-ssh.id}"]
}