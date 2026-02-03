# ☁️ MineCloud IaC

![Docker](https://img.shields.io/badge/docker-%230db7ed.svg?style=for-the-badge&logo=docker&logoColor=white)
![Ansible](https://img.shields.io/badge/ansible-%231A1918.svg?style=for-the-badge&logo=ansible&logoColor=white)
![Terraform](https://img.shields.io/badge/terraform-%235835CC.svg?style=for-the-badge&logo=terraform&logoColor=white)
![Debian](https://img.shields.io/badge/debian-%23D70A53.svg?style=for-the-badge&logo=debian&logoColor=white)
![Python](https://img.shields.io/badge/python-3670A0?style=for-the-badge&logo=python&logoColor=ffdd54)

MineCloud est un projet d'**Infrastructure-as-Code (IaC)** complet permettant de déployer automatiquement un serveur Minecraft et une API de monitoring Flask sur une machine virtuelle Debian 13.

## 🏗️ Architecture du Projet

Ce projet orchestre l'ensemble du cycle de vie de l'infrastructure :

1.  **Packer** : Construction d'une image ISO Debian 13 personnalisée ("Golden Image") avec Docker pré-installé.
2.  **Terraform** : Provisioning de la VM sur VirtualBox (gestion des ressources CPU, RAM, Réseau).
3.  **Ansible** : Configuration OS, gestion des correctifs Docker et déploiement de l'application.
4.  **Docker Compose** : Orchestration des conteneurs (Serveur de jeu + API Python).

## 📂 Structure des fichiers

```text
.
├── packer/          # Automatisation de l'image OS (ISO Debian 13)
├── terraform/       # Définition de la VM (Provider VirtualBox)
├── ansible/         # Playbooks de déploiement (Correction Buildx & Docker)
├── app/             # Code source applicatif
│   ├── status-app/  # API Flask (Monitoring Python & Dockerfile)
│   ├── backup.sh    # Script de sauvegarde du monde
│   └── docker-compose.yml
└── Makefile         # Orchestration globale du projet
