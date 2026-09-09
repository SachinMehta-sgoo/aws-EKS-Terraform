# Private EKS Terraform Workspace

This repository is a Terraform workspace designed for a small, private EKS cluster used for testing and early experimentation.

## Goal

- Build a private Kubernetes cluster that is intentionally minimal.
- Split responsibilities into separate modules for easier understanding and future extension.
- Keep default settings low-cost and low-complexity during the early testing stage.

## Directory structure

```text
.
├── README.md
├── versions.tf
├── variables.tf
├── main.tf
├── outputs.tf
├── .gitignore
└── modules/
    ├── addons/
    │   ├── main.tf
    │   ├── variables.tf
    │   └── README.md
    ├── eks_cluster/
    │   ├── main.tf
    │   ├── variables.tf
    │   └── outputs.tf
    ├── iam/
    │   ├── main.tf
    │   ├── variables.tf
    │   └── outputs.tf
    ├── node_groups/
    │   ├── main.tf
    │   ├── variables.tf
    │   └── outputs.tf
    ├── security_groups/
    │   ├── main.tf
    │   ├── variables.tf
    │   └── outputs.tf
    └── vpc/
        ├── main.tf
        ├── variables.tf
        └── outputs.tf
```

## Important design choices

1. Private cluster only
   - The EKS API endpoint is configured with `endpoint_public_access = false`.
   - Worker nodes live in private subnets.
   - This keeps the cluster isolated and reduces exposure.

2. Minimal cost for test workloads
   - CloudWatch log types are intentionally left empty.
   - One worker node is used by default.
   - NAT gateway is enabled, but the configuration is intentionally simple.

3. Loosely coupled modules
   - Networking, IAM, cluster, node groups, and add-ons are in independent modules.
   - New resources can be added without rewriting the whole stack.

4. Comments added for developer clarity
   - Each important file includes annotations explaining intent and boundaries.

## Quick start

1. Initialize Terraform:

   ```bash
   terraform init
   ```

2. Review the plan:

   ```bash
   terraform plan
   ```

3. Apply the cluster:

   ```bash
   terraform apply
   ```

4. Configure kubectl:

   ```bash
   aws eks update-kubeconfig --region us-east-1 --name demo-eks
   ```

## Notes

- This workspace is intentionally minimal and is meant to be expanded gradually.
- The root `main.tf` is the orchestration layer that wires all modules together.
- Future developers can add new modules without changing the core structure.
