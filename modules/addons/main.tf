# Addons module.
# This is intentionally kept separate so EKS add-ons can be managed and expanded
# independently from the cluster and node group definitions.

resource "aws_eks_addon" "vpc_cni" {
  count = var.enable_vpc_cni ? 1 : 0

  cluster_name                 = var.cluster_name
  addon_name                   = "vpc-cni"
  addon_version                = var.vpc_cni_version
  resolve_conflicts_on_create = "OVERWRITE"
  resolve_conflicts_on_update = "OVERWRITE"
}

resource "aws_eks_addon" "coredns" {
  count = var.enable_coredns ? 1 : 0

  cluster_name                 = var.cluster_name
  addon_name                   = "coredns"
  addon_version                = var.coredns_version
  resolve_conflicts_on_create = "OVERWRITE"
  resolve_conflicts_on_update = "OVERWRITE"
}

resource "aws_eks_addon" "kube_proxy" {
  count = var.enable_kube_proxy ? 1 : 0

  cluster_name                 = var.cluster_name
  addon_name                   = "kube-proxy"
  addon_version                = var.kube_proxy_version
  resolve_conflicts_on_create = "OVERWRITE"
  resolve_conflicts_on_update = "OVERWRITE"
}

resource "aws_eks_addon" "pod_identity_agent" {
  count = var.enable_pod_identity_agent ? 1 : 0

  cluster_name                 = var.cluster_name
  addon_name                   = "eks-pod-identity-agent"
  addon_version                = var.pod_identity_agent_version
  resolve_conflicts_on_create = "OVERWRITE"
  resolve_conflicts_on_update = "OVERWRITE"
}

resource "aws_eks_addon" "aws_efs_csi_driver" {
  count = var.enable_efs_csi_driver ? 1 : 0

  cluster_name                 = var.cluster_name
  addon_name                   = "aws-efs-csi-driver"
  addon_version                = var.efs_csi_driver_version
  resolve_conflicts_on_create = "OVERWRITE"
  resolve_conflicts_on_update = "OVERWRITE"
}
