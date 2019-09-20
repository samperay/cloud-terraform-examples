output "elb" {
  value = "${aws_elb.my-elb.dns_name}"
}
