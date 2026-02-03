packer {
  required_plugins {
    virtualbox = {
      version = ">= 1.0.5"
      source  = "github.com/hashicorp/virtualbox"
    }
  }
}

source "virtualbox-iso" "debian13" {
  boot_command     = ["<esc><wait>auto preseed/url=http://{{ .HTTPIP }}:{{ .HTTPPort }}/preseed.cfg<enter>"]
  cpus             = 2
  memory           = 4096
  guest_os_type    = "Debian_64"
  http_directory   = "http"
  iso_checksum     = "none" 
  iso_url          = "debian13.iso"
  ssh_password     = "minecloud123"
  ssh_username     = "minecloud"
  ssh_timeout      = "30m"
  shutdown_command = "echo 'minecloud123' | sudo -S shutdown -P now"
  vm_name          = "minecloud-base-v1"
  format           = "ovf"
  headless         = true
}

build {
  sources = ["source.virtualbox-iso.debian13"]

  provisioner "shell" {
    execute_command = "echo 'minecloud123' | sudo -S sh -c '{{ .Vars }} {{ .Path }}'"
    inline = [
      "apt-get update",
      "apt-get install -y docker.io curl",
      # 1. Installation de Docker Compose
      "curl -L https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m) -o /usr/local/bin/docker-compose",
      "chmod +x /usr/local/bin/docker-compose",
      # 2. Installation de Buildx (Le plugin manquant)
      "mkdir -p /usr/local/lib/docker/cli-plugins",
      "BUILDX_URL=$(curl -s https://api.github.com/repos/docker/buildx/releases/latest | grep hw_asset_url | grep $(uname -m) | cut -d '\"' -f 4)",
      "curl -L https://github.com/docker/buildx/releases/latest/download/buildx-v0.17.1.linux-$(dpkg --print-architecture) -o /usr/local/lib/docker/cli-plugins/docker-buildx",
      "chmod +x /usr/local/lib/docker/cli-plugins/docker-buildx",
      # 3. Finalisation
      "ln -sf /usr/local/bin/docker-compose /usr/local/lib/docker/cli-plugins/docker-compose",
      "usermod -aG docker minecloud",
      "systemctl enable docker"
    ]
  }
}
