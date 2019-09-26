resource "aws_iam_policy" "cloudwatchFullAccess" {
  name        = "cloudwatchFullAccess"
  description = "cloudwatchFullAccess"
  policy      = "${file("CloudwatchFullAccess-Policy.json")}"
}