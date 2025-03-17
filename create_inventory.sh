#!/bin/bash

# Obtenir l'adresse IP publique depuis Terraform
PROJECT_ROOT=$(pwd)
IP=$(terraform -chdir=terraform output -raw instance_public_ip)

# Créer le fichier d'inventaire
cat > ansible/inventory.ini << EOF
[webservers]
webserver ansible_host=${IP} ansible_user=ubuntu ansible_ssh_private_key_file=${PROJECT_ROOT}/ssh_key_cloud1

[all:vars]
ansible_python_interpreter=/usr/bin/python3
EOF

echo "Inventaire Ansible créé avec l'adresse IP: ${IP}"