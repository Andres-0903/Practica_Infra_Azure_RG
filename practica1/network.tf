resource "azurerm_virtual_network" "VPC_VIRGINIA" {
  name                = "vpc_virginia"
  address_space       = var.address_segment
  location            = "eastus"
  resource_group_name = azurerm_resource_group.practica_terraform.name
}

resource "azurerm_subnet" "public_subnet" {
  name                 = "public_subnet"
  resource_group_name  = azurerm_resource_group.practica_terraform.name
  virtual_network_name = azurerm_virtual_network.VPC_VIRGINIA.name
  address_prefixes     = [var.public_subnet]
}

resource "azurerm_subnet" "private_subnet" {
  name                 = "private_subnet"
  resource_group_name  = azurerm_resource_group.practica_terraform.name
  virtual_network_name = azurerm_virtual_network.VPC_VIRGINIA.name
  address_prefixes     = [var.private_subnet]
}

resource "azurerm_public_ip" "public_ip" {
  name                = "MypublicIP"
  location            = azurerm_resource_group.practica_terraform.location
  resource_group_name = azurerm_resource_group.practica_terraform.name
  allocation_method   = "Dynamic"
  sku                 = "Basic"

}

resource "azurerm_network_interface" "nic" {
  name                = "my-nic"
  location            = azurerm_resource_group.practica_terraform.location
  resource_group_name = azurerm_resource_group.practica_terraform.name

  ip_configuration {
    name                          = "nic-webserver"
    subnet_id                     = azurerm_subnet.public_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.public_ip.id
  }
}

