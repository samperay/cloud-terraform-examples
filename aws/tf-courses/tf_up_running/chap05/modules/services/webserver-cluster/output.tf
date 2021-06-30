output "alb_dns_name" {
  value = aws_lb.example.dns_name
  description = "The domain name of the Load Balancer"
}

output "asg_name" {
  value = aws_autoscaling_group.example.name
  description = "name of the auto-scaling group"
}

output "alb_security_group_id" {
  value = aws_security_group.alb.id
  description = "ID of the security group attached to the load balancer"
}