output "cluster_name" {
  description = "Name of the private EKS cluster."
  value       = module.eks_cluster.cluster_name
}

output "cluster_endpoint" {
  description = "Private EKS control plane endpoint." 
  value       = module.eks_cluster.cluster_endpoint
}

output "vpc_id" {
  description = "ID of the VPC that hosts the cluster."
  value       = module.vpc.vpc_id
}

output "private_subnet_ids" {
  description = "Private subnet IDs used by the EKS control plane and worker nodes."
  value       = module.vpc.private_subnet_ids
}

output "node_group_name" {
  description = "Name of the default EKS managed node group."
  value       = module.node_groups.node_group_name
}

output "kubectl_config_command" {
  description = "Example command to interact with the cluster using kubectl after the cluster is created."
  value       = "aws eks update-kubeconfig --region ${var.aws_region} --name ${module.eks_cluster.cluster_name}"
}
