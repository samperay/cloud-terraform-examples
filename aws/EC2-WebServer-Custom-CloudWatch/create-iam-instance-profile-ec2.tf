resource "aws_iam_instance_profile" "cw-instance-profile" {
  name  = "cw-instance-profile"
  roles = ["${aws_iam_role.ec2_cloudwatch_access_role.name}"]
}