provider "aws" {
  region = "ap-south-1"
}

module "webserver_cluster" {
  source = "../../../../modules/services/webserver-cluster"

  cluster_name = var.cluster_name
  instance_type = "t2.micro"
  min_size = 2
  max_size = 2
  enable_autoscaling = false
  server_text = "Hello Sunil, Welcome to new instance v2.."
  db_address = "appversionV2.amazonaws.com"
}

resource "aws_security_group_rule" "allow_testing_inbound" {
  type              = "ingress"
  security_group_id = module.webserver_cluster.alb_security_group_id

  from_port   = 1234
  to_port     = 1234
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
}