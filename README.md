# ☁️ MineCloud – Infrastructure as Code (IaC)

![Docker](https://img.shields.io/badge/docker-%230db7ed.svg?style=for-the-badge&logo=docker&logoColor=white)
![Ansible](https://img.shields.io/badge/ansible-%231A1918.svg?style=for-the-badge&logo=ansible&logoColor=white)
![Terraform](https://img.shields.io/badge/terraform-%235835CC.svg?style=for-the-badge&logo=terraform&logoColor=white)
![Debian](https://img.shields.io/badge/debian-%23D70A53.svg?style=for-the-badge&logo=debian&logoColor=white)
![Python](https://img.shields.io/badge/python-3670A0?style=for-the-badge&logo=python&logoColor=ffdd54)

MineCloud est un projet d'**Infrastructure-as-Code (IaC)** complet permettant de déployer automatiquement un **serveur Minecraft** et une **API de monitoring Flask** sur une machine virtuelle **Debian 13** avec **VirtualBox**.

---

## 🏗️ Architecture du projet

Ce projet orchestre l'ensemble du cycle de vie de l'infrastructure :

1. **Packer**  
   → Construction d'une image Debian 13 personnalisée ("Golden Image") avec Docker préinstallé.

2. **Terraform**  
   → Provisioning de la VM VirtualBox (CPU, RAM, réseau).

3. **Ansible**  
   → Configuration du système, correctifs Docker et déploiement applicatif.

4. **Docker Compose**  
   → Orchestration des conteneurs (Minecraft + API Flask).

---

## 📂 Structure des fichiers

```text
.
├── packer/          # Automatisation de l'image OS (ISO Debian à placer ici)
├── terraform/       # Définition de la VM (Provider VirtualBox)
├── ansible/         # Playbooks de déploiement
├── app/             # Code source applicatif
│   ├── status-app/  # API Flask (Monitoring + Dockerfile)
│   ├── backup.sh    # Script de sauvegarde du monde Minecraft
│   └── docker-compose.yml
└── Makefile         # Orchestration globale du projet

🚀 Déploiement

Le déploiement est entièrement automatisé via le Makefile :

# 1. Construire l'image de base Debian avec Packer
make build-image

# 2. Déployer l'infrastructure VirtualBox avec Terraform
make infra

# 3. Déployer les services applicatifs avec Ansible + Docker
make deploy

🛠️ Solutions techniques & correctifs

Le projet intègre des solutions à des problématiques réelles rencontrées en environnement virtualisé :

    Contournement Docker Buildx
    Utilisation de DOCKER_BUILDKIT=0 pour éviter les erreurs exec format error lors du build des images Docker.

    Idempotence Ansible
    Les playbooks peuvent être relancés sans interrompre inutilement les services existants.

    Healthchecks Docker
    Le conteneur Minecraft est surveillé pour garantir la disponibilité du service.

📊 Accès aux services
Service	Adresse	Port
Serveur Minecraft	localhost	25565
API Status (Flask)	http://localhost	5000
📸 Screenshots

Capture du déploiement


---

### 💡 Bonus (si tu veux améliorer encore ton README)

Je peux te proposer :
- Une section **"Prérequis"** (VirtualBox, Packer, Terraform, Ansible, Docker)
- Une section **"Schéma d’architecture"** (diagramme simple)
- Une section **"Troubleshooting"** (erreurs fréquentes rencontrées)
