output "alb_dns_name" {
  value = aws_lb.example.dns_name
  description = "The domain name of the Load Balancer"
}