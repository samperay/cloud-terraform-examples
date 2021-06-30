output "users" {
  value = aws_iam_user.example[*].arn
  description = "ARN for the users"
}