resource "aws_iam_instance_profile" "cw-instance-profile" {
  name  = "cw-instance-profile"
  role  = "${aws_iam_role.ec2_cloudwatch_access_role.name}"
}