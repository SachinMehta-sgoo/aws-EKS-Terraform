variable "cluster_name" {
  description = "Name of the EKS cluster this node group belongs to."
  type        = string
}

variable "subnet_ids" {
  description = "Private subnet IDs where the worker nodes will be placed."
  type        = list(string)
}

variable "security_group_ids" {
  description = "Security groups attached to the worker nodes."
  type        = list(string)
  default     = []
}

variable "node_role_arn" {
  description = "IAM role ARN for the worker nodes."
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type used for the managed node group."
  type        = string
  default     = "t3.small"
}

variable "desired_size" {
  description = "Desired number of nodes in the node group."
  type        = number
  default     = 1
}

variable "min_size" {
  description = "Minimum size for autoscaling."
  type        = number
  default     = 1
}

variable "max_size" {
  description = "Maximum size for autoscaling."
  type        = number
  default     = 2
}

variable "disk_size" {
  description = "Root volume size in GiB. Keep this minimal for test EKS workloads."
  type        = number
  default     = 20
}

variable "ami_type" {
  description = "AMI type for EKS nodes. Default is Amazon Linux 2 optimized for EKS."
  type        = string
  default     = "AL2_x86_64"
}

variable "capacity_type" {
  description = "Capacity type for the node group. ON_DEMAND is the simplest cost-aware choice for testing."
  type        = string
  default     = "ON_DEMAND"
}

variable "ssh_key_name" {
  description = "Optional EC2 key pair name for SSH access. Leave empty unless you intentionally need SSH debugging access."
  type        = string
  default     = ""
}

variable "depends_on" {
  description = "Optional dependency resources to wait on before creating node groups."
  type        = list(any)
  default     = []
}

variable "tags" {
  description = "Common tags applied to the node group resources."
  type        = map(string)
  default     = {}
}
