variable "aws_region" {
    description = "Région AWS à utiliser"
    type        = string
    default     = "eu-west-3"
  }

  variable "project_name" {
    description = "Nom du projet"
    type        = string
    default     = "cloud1"
  }

  variable "instance_type" {
    description = "Type d'instance EC2"
    type        = string
    default     = "t2.micro"
  }

  variable "vpc_cidr" {
    description = "CIDR block pour le VPC (virtual private cloud)"
    type        = string
    default     = "10.0.0.0/16"
  }

  variable "public_subnet_cidr" {
    description = "CIDR block pour le sous-réseau public"
    type        = string
    default     = "10.0.1.0/24"
  }

  variable "ssh_key_name" {
    description = "Nom de la clé SSH"
    type        = string
    default     = "cloud1-key"
  }

  variable "ssh_public_key" {
    description = "Clé publique SSH pour l'accès aux instances"
    type        = string
    default     = "../ssh_key_cloud1.pub"
  }