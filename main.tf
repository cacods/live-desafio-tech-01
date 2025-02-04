module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "5.18.1"

  name = "${var.sandbox_id}-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["${var.aws_region}a", "${var.aws_region}b", "${var.aws_region}c"]
  private_subnets = var.private_subnets
  public_subnets  = var.public_subnets

  enable_nat_gateway = true
  enable_vpn_gateway = true

  public_subnet_tags = {
    "kubernetes.io/cluster/${var.eks_name}" = "shared"
    "kubernetes.io/role/elb"                = 1
  }

  private_subnet_tags = {
    "kubernetes.io/cluster/${var.eks_name}" = "shared"
    "kubernetes.io/role/internal-elb"       = 1
  }

  tags = {
    Terraform                               = true
    Environment                             = "dev"
    Project                                 = var.sandbox_id
    "kubernetes.io/cluster/${var.eks_name}" = "shared"
  }

}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.31"

  cluster_name    = var.eks_name
  cluster_version = "1.31"

  cluster_endpoint_public_access = true

  enable_cluster_creator_admin_permissions = true

  # cluster_compute_config = {
  #   enabled    = true
  #   node_pools = ["general-purpose"]
  # }

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  eks_managed_node_groups = {
    default = {
      min_size       = 2
      max_sieze      = 2
      desired_size   = 2
      instance_types = ["t3.small"]
    }
  }

  tags = {
    Environment = "dev"
    Terraform   = "true"
    Project     = var.sandbox_id
  }
}
