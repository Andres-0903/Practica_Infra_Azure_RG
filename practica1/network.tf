resource "azurerm_virtual_network" "VPC_VIRGINIA" {
  name                = "network_virginia"
  address_space       = var.address_segment
  location            = "eastus"
  resource_group_name = azurerm_resource_group.practica_terraform.name

  tags = var.tags
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

# resource "azurerm_public_ip" "public_ip" {
#   name                = "MypublicIP"
#   location            = azurerm_resource_group.practica_terraform.location
#   resource_group_name = azurerm_resource_group.practica_terraform.name
#   allocation_method   = "Dynamic"
#   sku                 = "Standard"

# }

resource "azurerm_network_interface" "nic" {
  name                = "my-nic"
  location            = azurerm_resource_group.practica_terraform.location
  resource_group_name = azurerm_resource_group.practica_terraform.name

  ip_configuration {
    name                          = "nic-webserver"
    subnet_id                     = azurerm_subnet.public_subnet.id
    private_ip_address_allocation = "Dynamic"
  }
  tags = var.tags
}

resource "azurerm_network_security_group" "sg_ingress" {
  name                = "sg_ingress"
  location            = azurerm_resource_group.practica_terraform.location
  resource_group_name = azurerm_resource_group.practica_terraform.name

  security_rule {
    name                       = "ingress"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
  tags = var.tags
}

resource "azurerm_subnet_network_security_group_association" "sg_association" {
  subnet_id                 = azurerm_subnet.public_subnet.id
  network_security_group_id = azurerm_network_security_group.sg_ingress.id
}
