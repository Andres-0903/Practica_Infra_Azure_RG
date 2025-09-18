# output "Id_aplicacion-azure" {
#   value = data.azuread_application.nombre-aplicacion
# }

output "Id_aplicacion" {
  value = azurerm_resource_group.practica_terraform.id
}

output "dns_servers" {
  value = azurerm_virtual_network.VPC_VIRGINIA.guid
}

output "ip_instancia" {
  value = azurerm_linux_virtual_machine.vm_demo.public_ip_address
}
