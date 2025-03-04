# Cloud-1: Automated Deployment of WordPress Infrastructure

This project automates the deployment of a containerized WordPress environment on AWS cloud infrastructure using Terraform for infrastructure as code and Docker for containerization.

## Overview

The goal is to create a fully automated deployment process that provisions AWS resources and deploys a WordPress site with separate containers for each service (WordPress, MySQL, PHPMyAdmin). The infrastructure is defined using Terraform and configured to ensure data persistence, security, and scalability.

## Features

- **Infrastructure as Code**: AWS resources provisioned with Terraform
- **Containerization**: One process per container using Docker
- **Secure Access**: Limited public access with proper security configurations
- **TLS Support**: HTTPS enabled for secure connections
- **Data Persistence**: Volumes for database and WordPress files
- **Auto-restart**: Services automatically restart after server reboot
- **URL Routing**: Proper redirection based on requested URLs

## Requirements

- AWS Account
- Terraform installed
- SSH key for server access
- Docker and Docker Compose

## Usage

1. Configure AWS credentials
2. Customize variables in `terraform.tfvars`
3. Initialize Terraform: `terraform init`
4. Deploy infrastructure: `terraform apply`
5. Access your WordPress site at the provided URL

## Project Structure

```
├── terraform/           # Infrastructure definition
├── docker/              # Docker configuration files
│   ├── docker-compose.yml
│   ├── wordpress/
│   ├── mysql/
│   └── phpmyadmin/
└── scripts/             # Deployment scripts
```

## Security Considerations

- Database is not directly accessible from the internet
- SSH access restricted by key authentication
- Security groups limit exposed ports
- TLS certificates for encrypted connections

## Cleanup

To avoid unnecessary AWS charges, destroy resources when not in use:
```
terraform destroy
```
