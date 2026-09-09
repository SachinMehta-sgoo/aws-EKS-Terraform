variable "name" {
  description = "Name prefix used for the security groups."
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where the cluster and node security groups should be created."
  type        = string
}

variable "bastion_ssh_cidr" {
  description = "CIDR block allowed to SSH into the bastion instance. Restrict this to your own public IP or VPN range for security."
  type        = string
  default     = "203.0.113.10/32"
}

variable "tags" {
  description = "Common tags applied to all security group resources."
  type        = map(string)
  default     = {}
}
