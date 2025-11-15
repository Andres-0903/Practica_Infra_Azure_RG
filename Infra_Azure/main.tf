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

resource "azurerm_storage_account" "tfstate_dev" {
  name                     = "tfstatedevstorageacct"
  resource_group_name      = azurerm_resource_group.practica_terraform.name
  location                 = azurerm_resource_group.practica_terraform.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    Name  = "Storage_TFState_Dev"
    env   = "Dev"
    owner = "Andres"
    Iac   = "terraform"
    cloud = "azure"
  }

}

resource "azurerm_storage_container" "tfstate_container" {
  name                  = "tfstate"
  storage_account_id    = azurerm_storage_account.tfstate_dev.id
  container_access_type = "private"
}

