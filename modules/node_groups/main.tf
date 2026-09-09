# Node group module.
# This module is responsible only for the EKS worker nodes. It keeps the node
# capacity, AMI, and autoscaling logic separate from cluster and IAM concerns.

resource "aws_eks_node_group" "this" {
  cluster_name    = var.cluster_name
  node_group_name = "${var.cluster_name}-ng"
  node_role_arn   = var.node_role_arn
  subnet_ids      = var.subnet_ids

  scaling_config {
    desired_size = var.desired_size
    min_size     = var.min_size
    max_size     = var.max_size
  }

  ami_type       = var.ami_type
  capacity_type  = var.capacity_type
  disk_size      = var.disk_size
  instance_types = [var.instance_type]

  dynamic "remote_access" {
    for_each = var.ssh_key_name != "" ? [1] : []

    content {
      ec2_ssh_key = var.ssh_key_name
    }
  }

  tags = merge(var.tags, {
    Name = "${var.cluster_name}-ng"
  })

  depends_on = var.depends_on
}
