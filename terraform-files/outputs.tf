output "vm_public_ip" {
  description = "Public IP of the Debian VM"
  value       = azurerm_public_ip.publicip.ip_address
}

output "ssh_connection" {
  description = "SSH connection command"
  value       = "ssh yash@${azurerm_public_ip.publicip.ip_address}"
}

output "resource_group_name" {
  description = "Name of the created resource group"
  value       = azurerm_resource_group.rg.name
}

output "setup_log_location" {
  description = "Location of the VM setup log file"
  value       = "/var/log/vm-setup.log"
}

output "post_deployment_commands" {
  description = "Commands to check setup progress"
  value = <<-EOT
    # Check setup progress:
    tail -f /var/log/vm-setup.log
    
    # Verify installations:
    which live-build
    ls -la /home/yash/Nanite-configs/
    EOT
}

output "ssh_private_key" {
  description = "SSH private key for connecting to the VM"
  value       = tls_private_key.ssh_key.private_key_pem
  sensitive   = true
}

output "ssh_private_key_file" {
  description = "Save this private key to a file for SSH access"
  value       = "Save the ssh_private_key output to a file (e.g., nanite-key.pem) and use: ssh -i nanite-key.pem yash@<PUBLIC_IP>"
}