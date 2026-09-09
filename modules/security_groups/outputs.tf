output "cluster_security_group_id" {
  description = "Security group ID assigned to the EKS control plane."
  value       = aws_security_group.cluster.id
}

output "node_security_group_id" {
  description = "Security group ID assigned to the managed worker nodes."
  value       = aws_security_group.node.id
}

output "bastion_security_group_id" {
  description = "Security group ID assigned to the bastion EC2 instance used for EKS access."
  value       = aws_security_group.bastion.id
}
