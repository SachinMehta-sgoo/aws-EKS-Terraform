# Private EKS Terraform Workspace

This repository contains a minimal Terraform setup for a private EKS cluster used for testing and early development work.

## Goal

- Keep the cluster private by default.
- Keep the setup lean and cost-aware for a sandbox environment.
- Split infrastructure into smaller modules so future changes are easier to manage.
- Make the repo understandable for other developers without reading the entire AWS architecture in one file.

## Directory structure

```text
.
├── .gitignore
├── README.md
├── versions.tf
├── variables.tf
├── main.tf
├── outputs.tf
├── terraform.tfvars.example
├── modules/
│   ├── addons/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── eks_cluster/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── iam/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── node_groups/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── security_groups/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   └── vpc/
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
```

## Design choices

1. Private cluster
   - EKS public endpoint is disabled.
   - Control plane and worker nodes are placed in private networking.
   - This keeps the cluster isolated and reduces exposure.

2. Minimal cost
   - One node group is used by default.
   - Control-plane CloudWatch logs are disabled.
   - Add-ons are intentionally minimal to avoid unnecessary AWS cost.

3. Loosely coupled modules
   - Networking, IAM, cluster, node groups, and add-ons are separate modules.
   - New AWS components can be added without rewriting the whole stack.

4. Friendly for team use
   - Each major file contains comments for developer clarity.
   - Variables and resource names are intentionally readable.

## Prerequisites

Before running Terraform, ensure the following are available:

- Terraform installed
- AWS CLI installed and configured
- An AWS account with permission to create:
  - VPC, subnets, and route tables
  - NAT gateway and Internet gateway
  - IAM roles and policies
  - EKS cluster
  - EKS node group
  - security groups

Check your AWS account access:

```bash
aws sts get-caller-identity
```

## Setup steps

From the repo root, copy the example values:

```bash
copy terraform.tfvars.example terraform.tfvars
```

Then edit `terraform.tfvars` with your desired values. Keep the defaults unless you know you need a different setup.

Example:

```hcl
aws_region = "us-east-1"
project_name = "demo-eks"
environment = "test"
cluster_version = "1.30"
node_instance_type = "t3.small"
node_desired_capacity = 1
node_min_capacity = 1
node_max_capacity = 2
```

## Run Terraform

### 1) Initialize Terraform

```bash
terraform init
```

### 2) Review the execution plan

```bash
terraform plan
```

### 3) Apply the infrastructure

```bash
terraform apply
```

### 4) Configure kubectl

```bash
aws eks update-kubeconfig --region us-east-1 --name demo-eks
```

## Bastion access guide

This repo includes a small EC2 bastion instance that is used only to access the private EKS cluster from inside the VPC.

### Recommended SSH restriction
Edit the `bastion_ssh_cidr` value in `terraform.tfvars` and replace `0.0.0.0/0` with your own public IP address in CIDR notation.

Example:

```hcl
bastion_ssh_cidr = "203.0.113.10/32"
```

This is the safest pattern for a test environment because it limits SSH access to your machine.

### Connect to the bastion
After applying the Terraform, get the bastion public IP from AWS Console or from Terraform output:

```bash
terraform output
```

Then SSH to the bastion:

```bash
ssh -i ~/.ssh/your-key.pem ec2-user@<bastion-public-ip>
```

### Access the EKS cluster from the bastion
Once connected to the bastion, run:

```bash
aws eks update-kubeconfig --region us-east-1 --name demo-eks
kubectl get nodes
```

This works because the bastion is inside the same VPC and can reach the private EKS API endpoint.

## Destroy the environment

```bash
terraform destroy
```

## Notes

- This is a starting point for a private test EKS cluster, not a production design.
- Keep adding new AWS resources as separate modules rather than putting everything into one file.
- Use the `terraform.tfvars` file for local environment values and avoid hardcoding secrets in source control.
- If you want to expand the project later, add another module for EC2, Databases, ALB, or other shared infrastructure.
