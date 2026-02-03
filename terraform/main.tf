terraform {
  required_providers {
    virtualbox = {
      source  = "terra-farm/virtualbox"
      version = "~> 0.3.0"
    }
  }
}

provider "virtualbox" {}

resource "null_resource" "build_golden_image" {
  provisioner "local-exec" {
    command = "cd ../packer && packer build -force debian13-minecloud.json"
  }
}

resource "virtualbox_vm" "minecloud_server" {
  depends_on = [null_resource.build_golden_image]
  
  name      = "minecloud-prod"
  image     = "../packer/minecloud-debian13.box"
  cpus      = 2
  memory    = "4096 mib"
  running   = true

  network_adapter {
    type = "nat"
    host_interface = "lo0"
  }
}

resource "null_resource" "configure_ports" {
  depends_on = [virtualbox_vm.minecloud_server]

  provisioner "local-exec" {
    command = <<EOF
      sleep 30
      VBoxManage modifyvm "${virtualbox_vm.minecloud_server.name}" --natpf1 "SSH,tcp,127.0.0.1,2222,,22"
      VBoxManage modifyvm "${virtualbox_vm.minecloud_server.name}" --natpf1 "MC_TCP,tcp,127.0.0.1,25565,,25565"
      VBoxManage modifyvm "${virtualbox_vm.minecloud_server.name}" --natpf1 "MC_UDP,udp,127.0.0.1,25565,,25565"
      VBoxManage modifyvm "${virtualbox_vm.minecloud_server.name}" --natpf1 "STATUS,tcp,127.0.0.1,5000,,5000"
    EOF
  }
}

