Azure_Tenant_Id       = "13680a09-3f55-48ef-904c-f7ba014dc2b5"
Azure_Subscription_Id = "5909ccb5-1eb7-4733-8a4c-1b84ea3efd3e"

#Network
address_segment = ["10.10.0.0/16"]
public_subnet   = "10.10.1.0/24"
private_subnet  = "10.10.2.0/24"
##VM
admin_user = "andres"
#appserver       = "vm_server"
public_key_path = "C:/Users/andres/.ssh/id_rsa.pub"
#tags
tags = {
  "Owner"    = "Andres"
  "Cloud"    = "Azure"
  "IaC"      = "terraform"
  "Env"      = "Dev"
  "Location" = "eastus"
}
