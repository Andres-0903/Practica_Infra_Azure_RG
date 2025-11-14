###VM
resource "azurerm_linux_virtual_machine" "vm_demo" {
  name                  = "appServer2"
  location              = azurerm_resource_group.practica_terraform.location
  resource_group_name   = azurerm_resource_group.practica_terraform.name
  network_interface_ids = [azurerm_network_interface.nic.id]
  size                  = "Standard_B1s"

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }
  admin_username = var.admin_user

  admin_ssh_key {
    username   = var.admin_user
    public_key = file(var.public_key_path)
  }

  tags = {
    environment = "Dev"
  }
}
