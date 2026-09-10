variable "cluster_name" {
  description = "Unique name of the EKS cluster."
  type        = string
}

variable "cluster_version" {
  description = "Kubernetes version for the cluster."
  type        = string
}

variable "role_arn" {
  description = "IAM role ARN assigned to the control plane."
  type        = string
}

variable "subnet_ids" {
  description = "Private subnet IDs where the control plane and worker nodes are placed."
  type        = list(string)
}

variable "security_group_ids" {
  description = "Security groups associated with the EKS control plane. Use the dedicated cluster security group here."
  type        = list(string)
  default     = []
}

variable "endpoint_private_access" {
  description = "Whether the control plane API is reachable from inside the VPC."
  type        = bool
  default     = true
}

variable "endpoint_public_access" {
  description = "Whether the control plane API is reachable from the public internet. This is turned off to keep the cluster private."
  type        = bool
  default     = false
}

variable "cluster_log_types" {
  description = "EKS control plane logs to emit. For low-cost testing, keep this empty to avoid CloudWatch logging charges."
  type        = list(string)
  default     = []
}

variable "access_config" {
  description = "EKS access configuration for authentication mode. API_AND_CONFIG_MAP keeps the legacy config-map flow while allowing API-based access."
  type = object({
    authentication_mode = optional(string, "API_AND_CONFIG_MAP")
  })
  default = {
    authentication_mode = "API_AND_CONFIG_MAP"
  }
}

variable "enable_vpc_cni_addon" {
  description = "Whether to install the VPC CNI addon. This is optional and can be managed through the addons module instead."
  type        = bool
  default     = false
}

variable "vpc_cni_version" {
  description = "Version of the VPC CNI addon to install when enabled."
  type        = string
  default     = "v1.19.3-eksbuild.1"
}

variable "tags" {
  description = "Common tags applied to the cluster resource."
  type        = map(string)
  default     = {}
}
