output "instance_id" {
  description = "ID of the bastion instance used to access the private EKS cluster."
  value       = aws_instance.bastion.id
}

output "public_ip" {
  description = "Public IP address of the bastion instance for SSH or administrative access."
  value       = aws_instance.bastion.public_ip
}

output "private_ip" {
  description = "Private IP address of the bastion instance within the VPC."
  value       = aws_instance.bastion.private_ip
}
