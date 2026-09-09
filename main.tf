# Root Terraform configuration for a small, private EKS test environment.
# The design intentionally keeps the footprint minimal and modular so that
# additional resources can be added later without making the code difficult to read.

locals {
  common_tags = merge(var.tags, {
    Name        = var.project_name
    Environment = var.environment
    Project     = var.project_name
  })
}

module "vpc" {
  source = "./modules/vpc"

  name                 = var.project_name
  cidr                 = var.vpc_cidr
  azs                  = var.availability_zones
  public_subnet_cidrs  = ["10.20.1.0/24", "10.20.2.0/24"]
  private_subnet_cidrs = ["10.20.11.0/24", "10.20.12.0/24"]
  enable_nat_gateway   = true
  tags                 = local.common_tags
}

module "security_groups" {
  source = "./modules/security_groups"

  name   = var.project_name
  vpc_id = module.vpc.vpc_id
  tags   = local.common_tags
}

module "iam" {
  source = "./modules/iam"

  cluster_name = var.project_name
  tags         = local.common_tags
}

module "eks_cluster" {
  source = "./modules/eks_cluster"

  cluster_name            = var.project_name
  cluster_version         = var.cluster_version
  role_arn                = module.iam.cluster_role_arn
  subnet_ids              = module.vpc.private_subnet_ids
  security_group_ids      = [module.security_groups.cluster_security_group_id]
  endpoint_private_access = true
  endpoint_public_access  = false
  cluster_log_types       = []
  tags                    = local.common_tags
}

module "node_groups" {
  source = "./modules/node_groups"

  cluster_name       = module.eks_cluster.cluster_name
  subnet_ids         = module.vpc.private_subnet_ids
  security_group_ids = [module.security_groups.node_security_group_id]
  node_role_arn      = module.iam.node_role_arn
  instance_type      = var.node_instance_type
  desired_size       = var.node_desired_capacity
  min_size           = var.node_min_capacity
  max_size           = var.node_max_capacity
  disk_size          = 20
  tags               = local.common_tags
}

module "addons" {
  source = "./modules/addons"

  cluster_name    = module.eks_cluster.cluster_name
  cluster_version = var.cluster_version
}
