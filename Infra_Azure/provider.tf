terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.34.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.4.3"
    }
  }
  backend "azurerm" {}


}

provider "azurerm" {
  features {}
  tenant_id       = var.Azure_Tenant_Id
  subscription_id = var.Azure_Subscription_Id
}
