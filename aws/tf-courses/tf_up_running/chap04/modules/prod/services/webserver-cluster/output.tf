output "alb_dns_name" {
  value = module.webserver_cluster.alb_dns_name
  description = "The domain name of the Load Balancer for the production cluster"
}