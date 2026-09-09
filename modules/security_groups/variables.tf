variable "name" {
  description = "Name prefix used for the security groups."
  type        = string
}

variable "vpc_id" {
  description = "VPC ID where the cluster and node security groups should be created."
  type        = string
}

variable "tags" {
  description = "Common tags applied to all security group resources."
  type        = map(string)
  default     = {}
}
