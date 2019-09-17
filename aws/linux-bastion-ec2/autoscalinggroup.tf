// Creates autoscaling group for bastion hosts
resource "aws_autoscaling_group" "bastion-asg" {
  name_prefix          = "linux-bastion"
  name                 = "linux-bastion"
  max_size             = 3
  min_size             = 2
  desired_capacity     = 2
  launch_configuration = "${aws_launch_configuration.bastion-lc.name}"
  health_check_type    = "EC2"
  vpc_zone_identifier  = ["${aws_subnet.bastion-public-1.id}", "${aws_subnet.bastion-public-2.id}"]

  tags = {
    key                 = "Name"
    value               = "linux-bastion"
    propagate_at_launch = true
  }

}
