output "node_group_name" {
  description = "Name of the managed node group created for the EKS cluster."
  value       = aws_eks_node_group.this.node_group_name
}

output "node_group_ready" {
  description = "A value that becomes available only after the node group is ready. Useful for addons that depend on worker nodes."
  value       = aws_eks_node_group.this.id
}
