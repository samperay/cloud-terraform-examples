provider "aws" {
  profile = "default"
  aws_region = "ap-south-1"
}

variable "region" {
  default = "ap-south-1"
}

data "aws_eks_cluster" "cluster" {
  name = module.eksdemocluster.cluster_id
}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eksdemocluster.cluster_id
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.cluster.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.cluster.certificate_authority.0.data)
  token                  = data.aws_eks_cluster_auth.cluster.token
  load_config_file       = false
  version                = "~> 1.9"
}

module "eksdemocluster" {
  source          = "terraform-aws-modules/eks/aws"
  cluster_name    = "eksdemo"
  cluster_version = "1.15"
  subnets         = "${module.vpc.public_subnets}"
  vpc_id          = "${module.vpc.vpc_id}"


  worker_groups = [
    {
      instance_type = "t2.micro"
      asg_max_size  = 2
    }
  ]
}

// create a new VPC and let EKS gets built in that cluster

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "eksdemo"
  cidr = "10.0.0.0/16"

  azs             = ["ap-south-1a", "ap-south-1b", "ap-south-1c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway = true
  enable_vpn_gateway = true

  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}
