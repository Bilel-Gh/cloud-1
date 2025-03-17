#!/bin/bash
set -e

PROJECT_ROOT=$(pwd)

echo "=== Vérifier et générer une clé SSH si nécessaire ==="
SSH_KEY_PATH="./ssh_key_cloud1"
if [ ! -f "$SSH_KEY_PATH" ]; then
  echo "=== Génération d'une paire de clés SSH ==="
  ssh-keygen -t rsa -b 4096 -f "$SSH_KEY_PATH" -N "" -q
  echo "Clé SSH générée à $SSH_KEY_PATH"
fi

# Définir SSH_PUBLIC_KEY
SSH_PUBLIC_KEY=$(cat ssh_key_cloud1.pub)
# generer un fichier terraform.tfvars avec nos variables
echo "aws_region      = \"eu-west-3\"
project_name    = \"cloud1\"
instance_type   = \"t2.micro\"
ssh_public_key  = \"${SSH_PUBLIC_KEY}\"" > terraform/terraform.tfvars

echo "=== Déploiement de l'infrastructure avec Terraform ==="
cd terraform
terraform init
terraform apply -auto-approve
cd ..

echo "=== Création de l'inventaire Ansible dynamique ==="
./create_inventory.sh

echo "=== Attente de la disponibilité du serveur ==="
sleep 60  # Attente pour s'assurer que le serveur est prêt

echo "=== Configuration du serveur avec Ansible ==="
cd ansible
ansible-playbook -i inventory.ini playbook.yml --vault-password-file ../.vault_pass

cd ..
echo "=== Déploiement terminé avec succès ! ==="
echo "WordPress est accessible à l'adresse : http://$(terraform -chdir=terraform output -raw instance_public_ip)"
echo "PHPMyAdmin est accessible à l'adresse : http://$(terraform -chdir=terraform output -raw instance_public_ip)/phpmyadmin"