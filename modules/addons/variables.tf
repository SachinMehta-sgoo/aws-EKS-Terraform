variable "cluster_name" {
  description = "Name of the EKS cluster to add the add-ons to."
  type        = string
}

variable "cluster_version" {
  description = "Kubernetes version used by the cluster. Add-on versions should match the cluster major/minor version."
  type        = string
  default     = "1.30"
}

variable "enable_ebs_csi_driver" {
  description = "Whether to install the EBS CSI driver. Leave disabled during the initial test phase to keep dependencies minimal."
  type        = bool
  default     = false
}

variable "enable_coredns" {
  description = "Whether to install CoreDNS. This is commonly enabled for EKS clusters."
  type        = bool
  default     = true
}

variable "enable_kube_proxy" {
  description = "Whether to install kube-proxy. This is usually required for cluster networking."
  type        = bool
  default     = true
}

variable "ebs_csi_driver_version" {
  description = "Version of the EBS CSI driver addon."
  type        = string
  default     = "v1.41.0-eksbuild.1"
}

variable "coredns_version" {
  description = "Version of CoreDNS for the cluster."
  type        = string
  default     = "v1.14.3-eksbuild.16"
}

variable "kube_proxy_version" {
  description = "Version of kube-proxy for the cluster."
  type        = string
  default     = "v1.35.3-eksbuild.21"
}

