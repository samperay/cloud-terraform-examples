output "asg_name" {
  value       = aws_autoscaling_group.example.name
  description = "autoscaling group name"
}

output "instance_security_group_id" {
  value       = aws_security_group.example-sg.id
  description = "The ID of the EC2 Instance Security Group"
}