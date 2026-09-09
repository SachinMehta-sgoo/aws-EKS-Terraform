output "vpc_id" {
  description = "ID of the VPC created for the EKS environment."
  value       = aws_vpc.this.id
}

output "public_subnet_ids" {
  description = "Public subnet IDs, kept separate for future access layers or bastion hosts."
  value       = aws_subnet.public[*].id
}

output "private_subnet_ids" {
  description = "Private subnet IDs used by the EKS control plane and worker nodes."
  value       = aws_subnet.private[*].id
}
