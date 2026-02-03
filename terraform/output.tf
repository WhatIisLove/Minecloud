output "vm_name" {
  value = virtualbox_vm.minecloud_server.name
}

output "access_info" {
  value = "Minecraft: 127.0.0.1:25565 | Status: http://127.0.0.1:5000 | SSH: ssh -p 2222 minecloud@127.0.0.1"
}
