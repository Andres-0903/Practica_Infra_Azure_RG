resource "azurerm_resource_group" "practica_terraform" {
  name     = "Practica_Terraform"
  location = "eastus"

  tags = {
    Name  = "RG_EU"
    env   = "Dev"
    owner = "Andres"
    Iac   = "terraform"
    cloud = "azure"
  }
}

