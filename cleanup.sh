#!/bin/bash
KEY_NAME=$(terraform -chdir=terraform output -raw key_name)
echo "=== Suppression de l'infrastructure ==="
cd terraform
terraform destroy -auto-approve
echo "=== Suppression de la paire de clés AWS ==="
aws ec2 delete-key-pair --key-name "$KEY_NAME"
echo "=== Nettoyage terminé ==="