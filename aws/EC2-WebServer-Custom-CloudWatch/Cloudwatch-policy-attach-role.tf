resource "aws_iam_policy_attachment" "cw-attach-policy" {
  name       = "cw-attach-policy"
  roles      = ["${aws_iam_role.ec2_cloudwatch_access_role.name}"]
  policy_arn = "${aws_iam_policy.cloudwatchFullAccess.arn}"
}