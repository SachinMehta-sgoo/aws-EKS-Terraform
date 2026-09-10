variable "cluster_name" {
  description = "Name of the EKS cluster to add the add-ons to."
  type        = string
}

variable "cluster_version" {
  description = "Kubernetes version used by the cluster. Add-on versions should match the cluster major/minor version."
  type        = string
  default     = "1.30"
}

variable "enable_vpc_cni" {
  description = "Whether to install the VPC CNI add-on."
  type        = bool
  default     = true
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

variable "enable_pod_identity_agent" {
  description = "Whether to install the EKS Pod Identity Agent add-on."
  type        = bool
  default     = true
}

variable "enable_efs_csi_driver" {
  description = "Whether to install the EFS CSI driver add-on."
  type        = bool
  default     = true
}

variable "vpc_cni_version" {
  description = "Version of the VPC CNI add-on. Leave unset to use the latest supported version for the cluster."
  type        = string
  default     = null
}

variable "coredns_version" {
  description = "Version of CoreDNS for the cluster. Leave unset to use the latest supported version for the cluster."
  type        = string
  default     = null
}

variable "kube_proxy_version" {
  description = "Version of kube-proxy for the cluster. Leave unset to use the latest supported version for the cluster."
  type        = string
  default     = null
}

variable "pod_identity_agent_version" {
  description = "Version of the EKS Pod Identity Agent add-on. Leave unset to use the latest supported version for the cluster."
  type        = string
  default     = null
}

variable "efs_csi_driver_version" {
  description = "Version of the EFS CSI driver add-on. Leave unset to use the latest supported version for the cluster."
  type        = string
  default     = null
}

