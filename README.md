☁️ MineCloud : Infrastructure-as-Code pour Serveur Minecraft

MineCloud est un projet complet d'Infrastructure-as-Code (IaC) permettant de déployer automatiquement un serveur Minecraft (Paper/Vanilla) accompagné d'une API de monitoring Flask, le tout conteneurisé sous Docker.

L'infrastructure est provisionnée sur VirtualBox via Terraform, après qu'une image de base Debian 13 a été construite avec Packer.
🏗️ Architecture Technique

    OS Base : Debian 13 (Trixie) - Construit via Packer.

    Provisioning : Terraform (Provider VirtualBox).

    Configuration & Déploiement : Ansible.

    Runtime : Docker & Docker Compose.

    Services :

        minecraft-srv : Serveur Minecraft (Image itzg/minecraft-server).

        flask-app : API Python de monitoring du statut du serveur.

📂 Structure du Projet
Plaintext

.
├── packer/          # Configuration de l'image ISO (Debian 13 + Docker)
├── terraform/       # Déploiement de la VM sur VirtualBox
├── ansible/         # Playbooks de déploiement de l'application
├── app/             # Code source de l'application
│   ├── status-app/  # API Flask (Dockerfile + Python)
│   └── docker-compose.yml
└── Makefile         # Automatisation des commandes (build, deploy, etc.)

🚀 Installation & Déploiement
1. Pré-requis

Assurez-vous d'avoir installé :

    Packer

    Terraform

    Ansible

    VirtualBox

2. Construction de l'image (Packer)

Générez l'image Debian pré-configurée avec Docker :
Bash

make build-image
# Ou manuellement :
packer build packer/debian13-minecloud.pkr.hcl

3. Provisioning de la VM (Terraform)

Créez l'instance virtuelle :
Bash

make infra
# Ou manuellement :
cd terraform && terraform apply

4. Déploiement de l'application (Ansible)

Installez les services et lancez les conteneurs :
Bash

make deploy

🛠️ Utilisation de l'API

L'API Flask permet de vérifier l'état du serveur Minecraft. Par défaut, elle écoute sur le port 5000.

Vérifier le statut :
Bash

curl http://localhost:5000/status

Accéder au serveur Minecraft :

    IP : 127.0.0.1 (ou l'IP configurée dans Terraform)

    Port : 25565

🔧 Résolution des problèmes (Troubleshooting)
Docker Buildx Error

Le projet est configuré pour utiliser le Legacy Builder de Docker afin d'éviter les erreurs d'architecture (exec format error) sur les environnements virtuels. Le build de l'image Flask est forcé via :
Bash

DOCKER_BUILDKIT=0 docker build -t minecloud-status-app ./status-app

Accès SSH

L'utilisateur par défaut configuré dans le preseed est minecloud. La clé SSH est automatiquement injectée par Terraform/Ansible.
📝 Améliorations futures

    [ ] Ajout d'un dashboard web complet (React/Vue).

    [ ] Migration du provider VirtualBox vers Proxmox ou AWS.

    [ ] Mise en place de sauvegardes automatiques vers un S3 via backup.sh.
