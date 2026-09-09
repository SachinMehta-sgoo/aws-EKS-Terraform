variable "name" {
  description = "Name prefix for the bastion EC2 resource."
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type for the bastion. Keep this small because it's for admin access only."
  type        = string
  default     = "t3.micro"
}

variable "subnet_id" {
  description = "Public subnet where the bastion instance should be placed."
  type        = string
}

variable "security_group_id" {
  description = "Security group attached to the bastion EC2 instance."
  type        = string
}

variable "key_name" {
  description = "Optional EC2 key pair name for SSH access. Leave empty if you do not want SSH access."
  type        = string
  default     = ""
}

variable "tags" {
  description = "Tags applied to the bastion EC2 resource."
  type        = map(string)
  default     = {}
}
