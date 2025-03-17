# Cloud-1: Déploiement automatisé d'Inception

Ce projet utilise Terraform et Ansible pour automatiser le déploiement d'une infrastructure WordPress complète sur AWS, en suivant l'architecture "un processus par conteneur".

## Prérequis

- [Terraform](https://developer.hashicorp.com/terraform/downloads) (v1.0.0+)
- [Ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html) (v2.9.0+)
- [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html) configuré avec des droits suffisants

## Structure du projet

```
cloud-1/
├── terraform/           # Configuration de l'infrastructure AWS
├── ansible/             # Configuration des serveurs et applications
├── create_inventory.sh  # Script pour générer l'inventaire Ansible
├── deploy.sh            # Script principal de déploiement
└── cleanup.sh           # Script pour nettoyer les ressources
```

## Configuration initiale

Après avoir cloné ce dépôt, vous devez configurer les secrets nécessaires au déploiement:

1. Créez un fichier de mot de passe pour Ansible Vault:
   ```bash
   echo "choisissez_un_mot_de_passe_fort" > .vault_pass
   chmod 600 .vault_pass
   ```

2. Créez ou modifiez le fichier de variables chiffrées:
   ```bash
   ansible-vault create ansible/group_vars/all/vault.yml
   ```

   Dans ce fichier, définissez les variables suivantes:
   ```yaml
   vault_mysql_root_password: "votre_mot_de_passe_root_mysql"
   vault_mysql_password: "votre_mot_de_passe_mysql_mysql"
   vault_wordpress_admin_password: "votre_mot_de_passe_admin_wp"
   ```

3. Configurez vos identifiants AWS soit via `aws configure`, ou en définissant les variables d'environnement:
   ```bash
   export AWS_ACCESS_KEY_ID="votre_access_key"
   export AWS_SECRET_ACCESS_KEY="votre_secret_key"
   export AWS_DEFAULT_REGION="la_region_de_votre_choix"
   ```

## Déploiement

Pour déployer l'infrastructure complète:

```bash
./deploy.sh
```

Ce script va:
1. Provisionner l'infrastructure avec Terraform
2. Générer un inventaire Ansible dynamique
3. Configurer le serveur et déployer les conteneurs avec Ansible
4. Afficher les URLs d'accès à WordPress et PHPMyAdmin

Le déploiement prend généralement entre 5 et 10 minutes.

## Accès aux applications

Une fois le déploiement terminé, vous pourrez accéder à:
- WordPress: http://[adresse_ip_du_serveur]
- PHPMyAdmin: http://[adresse_ip_du_serveur]/phpmyadmin

Les identifiants par défaut pour WordPress sont:
- Utilisateur: admin
- Mot de passe: admin

⚠️ **Important**: Changez ces identifiants immédiatement après la première connexion.

## Nettoyage des ressources

Pour détruire l'infrastructure et éviter des frais inutiles:

```bash
./cleanup.sh
```

## Fonctionnalités

Cette solution respecte toutes les exigences du projet Cloud-1:
- ✅ Déploiement entièrement automatisé
- ✅ Architecture en conteneurs (1 processus = 1 conteneur)
- ✅ Persistance des données après redémarrage
- ✅ Sécurité des accès publics
- ✅ Support TLS (HTTPS)
- ✅ Redirection basée sur les URLs

## Résolution des problèmes

Si vous rencontrez des erreurs:
1. Vérifiez que les identifiants AWS sont corrects
2. Assurez-vous que le mot de passe Vault dans `.vault_pass` correspond à celui utilisé pour chiffrer le fichier vault (demander moi le mot de passe si vous ne l'avez pas)
3. Consultez les logs Terraform et Ansible pour plus de détails