variable "cluster_name" {
  description = "Name prefix used for the IAM roles created for the cluster and node groups."
  type        = string
}

variable "tags" {
  description = "Tags applied to the IAM resources for ownership and cost tracking."
  type        = map(string)
  default     = {}
}
