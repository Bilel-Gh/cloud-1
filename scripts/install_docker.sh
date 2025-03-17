#!/bin/bash

# Installer Docker et Docker Compose
apt-get update
apt-get install -y docker.io docker-compose

# Préparer et creer le dossier pour les données persistantes
mkdir -p /data

# Formater le volume EBS 
(mkfs -t ext4 /dev/xvdf || true)

# Configurer le montage automatique et monter le volume
echo "/dev/xvdf /data ext4 defaults,nofail 0 2" >> /etc/fstab
mount /data || true

# Configurer les permissions
usermod -aG docker ubuntu
systemctl enable docker