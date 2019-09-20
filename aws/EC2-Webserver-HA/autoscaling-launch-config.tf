resource "aws_launch_configuration" "web-launch" {
  name            = "web-launchconfig"
  image_id        = "${lookup(var.AMIS, var.AWS_REGION)}"
  instance_type   = "t2.micro"
  key_name        = "${aws_key_pair.mykey.key_name}"
  security_groups = ["${aws_security_group.web.id}"]
  user_data       = "#!/bin/bash\nsudo apt-get update\nsudo apt-get install nginx -y\nIP=`sudo ifconfig | grep 'addr:10' | awk '{ print $2 }' | cut -d ':' -f2`\n echo 'this is instance: ' $IP > /var/www/html/index.html"
  
}

resource "aws_autoscaling_group" "web-autoscaling" {
  name                      = "web-autoscaling"
  vpc_zone_identifier       = ["${aws_subnet.main-subnet-public-1.id}", "${aws_subnet.main-subnet-public-2.id}"]
  launch_configuration      = "${aws_launch_configuration.web-launch.name}"
  min_size                  = 2
  max_size                  = 2
  health_check_grace_period = 200

  // you will write if you need your health check from EC2 instance
  #health_check_type         = "EC2"

  // if you are using ELB 
  load_balancers = ["${aws_elb.my-elb.name}"]
  force_delete   = true

  tag {
    key                 = "Name"
    value               = "web-instance"
    propagate_at_launch = true
  }
}