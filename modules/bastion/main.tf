# Bastion EC2 instance for private EKS access.
# This instance is intentionally small and dedicated to admin access only.
# It lives in a public subnet so it can act as the jump host for cluster access.

data "aws_ami" "amazon_linux_2" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

resource "aws_instance" "bastion" {
  ami                         = data.aws_ami.amazon_linux_2.id
  instance_type               = var.instance_type
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [var.security_group_id]
  associate_public_ip_address = true
  key_name                    = var.key_name

  user_data = <<-EOF
    #!/bin/bash
    yum update -y
    yum install -y amazon-efs-utils curl unzip
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
    install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl
    curl -Lo awscliv2.zip https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip
    unzip -o awscliv2.zip
    ./aws/install
    echo "Bastion ready for private EKS access" > /var/log/bastion-ready.log
  EOF

  tags = merge(var.tags, {
    Name = "${var.name}-bastion"
  })
}
