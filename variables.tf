variable "aws_region" {
  description = "AWS region where the EKS cluster and related resources will be created."
  type        = string
  default     = "us-east-1"
}

variable "project_name" {
  description = "Short name used as a prefix for all created AWS resources."
  type        = string
  default     = "demo-eks"
}

variable "environment" {
  description = "Deployment environment label used for tagging resources. Example: dev, test, staging."
  type        = string
  default     = "test"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC that hosts the private EKS cluster and worker nodes."
  type        = string
  default     = "10.20.0.0/16"
}

variable "availability_zones" {
  description = "List of availability zones used for the VPC and EKS subnets. Keep this to a small number to minimize cost during the test phase."
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

variable "cluster_version" {
  description = "Kubernetes version for the EKS cluster. Use a stable, supported version for your account."
  type        = string
  default     = "1.30"
}

variable "node_instance_type" {
  description = "Instance type for the worker node group. Start small and increase only when required."
  type        = string
  default     = "t3.small"
}

variable "node_desired_capacity" {
  description = "Desired number of worker nodes. For a low-cost test cluster, start with one node."
  type        = number
  default     = 1
}

variable "node_min_capacity" {
  description = "Minimum number of worker nodes for the EKS node group."
  type        = number
  default     = 1
}

variable "node_max_capacity" {
  description = "Maximum number of worker nodes for the EKS node group."
  type        = number
  default     = 2
}

variable "tags" {
  description = "Common tags applied to all resources for easier cost tracking and ownership."
  type        = map(string)
  default = {
    ManagedBy = "terraform"
    Owner     = "platform-team"
    Purpose   = "eks-private-test"
  }
}
