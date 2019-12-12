module "consul_cluster" {
  # TODO: update this to the final URL
  # Use version v0.0.5 of the consul-cluster module
  source = "github.com/hashicorp/terraform-aws-consul//modules/consul-cluster?ref=v0.0.5"
  cluster_name = "consul-stage"
  instance_type = "t2.micro"
  vpc_id = "vpc-91d7a5f8"
  allowed_inbound_cidr_blocks = ["0.0.0.0/0"]
  ami_id = "ami-066d5b23cdee62544"
  # Add this tag to each node in the cluster
  cluster_tag_key   = "consul-cluster"
  cluster_tag_value = "consul-cluster-example"
  ssh_key_name = "mykey"

  # Configure and start Consul during boot. It will automatically form a cluster with all nodes that have that same tag.
  user_data = <<-EOF
              #!/bin/bash
              /opt/consul/bin/run-consul --server --cluster-tag-key consul-cluster --cluster-tag-value consul-cluster-example
              EOF

  # ... See variables.tf for the other parameters you must define for the consul-cluster module

  allowed_ssh_cidr_blocks = ["0.0.0.0/0"]
  availability_zones = ["ap-south-1a"]
}
