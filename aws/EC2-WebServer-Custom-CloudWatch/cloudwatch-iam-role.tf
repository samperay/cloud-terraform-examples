resource "aws_iam_role" "ec2_cloudwatch_access_role" {
  name               = "ec2_cloudwatch_access_role"
  assume_role_policy = "${file("assumerolepolicy.json")}"

  tags = {
      Name = "ec2_cloudwatch_access_role"
  }
}