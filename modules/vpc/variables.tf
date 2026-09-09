variable "name" {
  description = "Name prefix used on the VPC and its related resources."
  type        = string
}

variable "cidr" {
  description = "CIDR range for the VPC. Example: 10.20.0.0/16."
  type        = string
}

variable "azs" {
  description = "Availability zones used for the subnets."
  type        = list(string)
}

variable "public_subnet_cidrs" {
  description = "CIDR ranges for the public subnets. For a test cluster, keep it small and minimal."
  type        = list(string)
}

variable "private_subnet_cidrs" {
  description = "CIDR ranges for the private subnets used by the EKS cluster and worker nodes."
  type        = list(string)
}

variable "enable_internet_gateway" {
  description = "Whether to create a public internet gateway. This is useful for bastion access or internet-facing services if needed later."
  type        = bool
  default     = true
}

variable "enable_nat_gateway" {
  description = "Whether to create a NAT gateway so private subnets can reach the internet for package downloads."
  type        = bool
  default     = true
}

variable "tags" {
  description = "Tags shared across all network resources."
  type        = map(string)
  default     = {}
}
