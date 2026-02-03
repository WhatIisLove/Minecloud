VM_NAME=minecloud-prod
SSH_PORT=2222

all: clean-vbox build-packer import-run deploy

clean-vbox:
	@echo "🧹 Purge de VirtualBox..."
	-VBoxManage controlvm $(VM_NAME) poweroff || true
	-VBoxManage unregistervm $(VM_NAME) --delete || true
	-rm -rf "/home/tom/VirtualBox VMs/$(VM_NAME)/"
	@VBoxManage list hdds | grep "minecloud-base-v1-disk" -B 1 | grep "UUID:" | awk '{print $$2}' | xargs -I {} VBoxManage closemedium disk {} --delete || true

build-packer:
	@echo "📦 Build de la Golden Image..."
	cd packer && packer init . && packer build -force debian13-minecloud.pkr.hcl

import-run:
	@echo "☁️ Import et Démarrage..."
	VBoxManage import packer/output-debian13/minecloud-base-v1.ovf --vsys 0 --vmname $(VM_NAME) --memory 4096 --cpus 2
	VBoxManage modifyvm $(VM_NAME) --natpf1 "ssh,tcp,,$(SSH_PORT),,22"
	VBoxManage modifyvm $(VM_NAME) --natpf1 "minecraft,tcp,,25565,,25565"
	VBoxManage modifyvm $(VM_NAME) --natpf1 "flask,tcp,,5000,,5000"
	VBoxManage startvm $(VM_NAME) --type headless
	@echo "⏳ Boot en cours (45s)..."
	@sleep 45

deploy:
	@echo "🚀 Déploiement Applicatif..."
	ANSIBLE_HOST_KEY_CHECKING=False ansible-playbook -i '127.0.0.1,' \
		-u minecloud \
		--ssh-extra-args="-p $(SSH_PORT) -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null" \
		--extra-vars "ansible_password=minecloud123 ansible_sudo_pass=minecloud123" \
		ansible/deploy.yml
