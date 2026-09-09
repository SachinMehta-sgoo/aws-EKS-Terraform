# Security group module for the EKS control plane and worker nodes.
# The goal is to keep the network access explicit and minimal to reduce risk
# and allow future owners to understand which traffic is intentionally allowed.

resource "aws_security_group" "cluster" {
  name        = "${var.name}-eks-cluster-sg"
  description = "Security group for the EKS control plane. Restricted to private cluster access."
  vpc_id      = var.vpc_id

  egress {
    description = "Allow all outbound traffic from the control plane."
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(var.tags, {
    Name = "${var.name}-eks-cluster-sg"
  })
}

resource "aws_security_group" "node" {
  name        = "${var.name}-eks-node-sg"
  description = "Security group for the worker nodes in the private EKS cluster."
  vpc_id      = var.vpc_id

  egress {
    description = "Allow all outbound traffic from worker nodes."
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow node-to-node communication within the cluster."
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    self        = true
  }

  tags = merge(var.tags, {
    Name = "${var.name}-eks-node-sg"
  })
}

resource "aws_security_group_rule" "cluster_allow_https_from_nodes" {
  description       = "Allow HTTPS from worker nodes to the EKS control plane."
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  security_group_id = aws_security_group.cluster.id
  source_security_group_id = aws_security_group.node.id
}

resource "aws_security_group_rule" "node_allow_kubelet_from_cluster" {
  description       = "Allow worker nodes to receive traffic from the EKS control plane."
  type              = "ingress"
  from_port         = 1025
  to_port           = 65535
  protocol          = "tcp"
  security_group_id = aws_security_group.node.id
  source_security_group_id = aws_security_group.cluster.id
}
