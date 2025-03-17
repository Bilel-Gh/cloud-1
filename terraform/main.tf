# Fichier: main.tf

# Configuration du provider AWS
provider "aws" {
  region = var.aws_region
}

# Configuration Terraform
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }

  # Si vous souhaitez utiliser un backend distant comme S3 pour le state
  # backend "s3" {
  #   bucket = "your-terraform-state-bucket"
  #   key    = "cloud1/terraform.tfstate"
  #   region = "eu-west-3"
  # }
}

# Data source pour trouver l'AMI Ubuntu la plus récente
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# Outputs pour Ansible
output "instance_public_ip" {
  description = "Public IP address of the EC2 instance"
  value       = aws_eip.web.public_ip
}

output "instance_id" {
  description = "ID of the EC2 instance"
  value       = aws_instance.web.id
}

output "key_name" {
  description = "Nom de la clé SSH utilisée pour se connecter à l'instance"
  value       = aws_key_pair.deployer.key_name
}