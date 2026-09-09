# Addons module.
# This is intentionally kept separate so EKS add-ons can be managed and expanded
# independently from the cluster and node group definitions.

resource "aws_eks_addon" "aws_ebs_csi_driver" {
  count = var.enable_ebs_csi_driver ? 1 : 0

  cluster_name      = var.cluster_name
  addon_name        = "aws-ebs-csi-driver"
  addon_version     = var.ebs_csi_driver_version
  resolve_conflicts = "OVERWRITE"
}

resource "aws_eks_addon" "coredns" {
  count = var.enable_coredns ? 1 : 0

  cluster_name      = var.cluster_name
  addon_name        = "coredns"
  addon_version     = var.coredns_version
  resolve_conflicts = "OVERWRITE"
}

resource "aws_eks_addon" "kube_proxy" {
  count = var.enable_kube_proxy ? 1 : 0

  cluster_name      = var.cluster_name
  addon_name        = "kube-proxy"
  addon_version     = var.kube_proxy_version
  resolve_conflicts = "OVERWRITE"
}
