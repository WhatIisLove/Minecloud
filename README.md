# ☁️ MineCloud IaC

![Docker](https://img.shields.io/badge/docker-%230db7ed.svg?style=for-the-badge&logo=docker&logoColor=white) ![Ansible](https://img.shields.io/badge/ansible-%231A1918.svg?style=for-the-badge&logo=ansible&logoColor=white) ![Terraform](https://img.shields.io/badge/terraform-%235835CC.svg?style=for-the-badge&logo=terraform&logoColor=white) ![Debian](https://img.shields.io/badge/debian-%23D70A53.svg?style=for-the-badge&logo=debian&logoColor=white)

MineCloud est un projet d'**Infrastructure-as-Code** complet. Il automatise le déploiement d'un serveur Minecraft et d'une API de monitoring sur une VM Debian 13 via **VirtualBox**.

---

## 📂 Structure du projet

```text
.
├── packer/          # Image ISO Debian 13 personnalisée
├── terraform/       # Provisioning VM VirtualBox
├── ansible/         # Configuration et déploiement Docker
├── app/             # Code source (Flask + Docker Compose)
└── screen.png       # Capture d'écran du projet
```
## 🚀 Déploiement 

Télécharger le dépot :
```git clone https://github.com/WhatIsLove/Minecloud.git```

Placer son iso dans ```packer/```

Lancer : ```make all```


📊 Accès aux services
```text
Service	Adresse	Port
Minecraft	localhost	25565
API Flask	http://localhost	5000

```

📸 Screenshot
<img src="screen.png" width="100%" alt="Rendu du projet">
