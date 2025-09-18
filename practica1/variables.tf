# variable "Azure_Cliente_ID" {
#   type        = string
#   description = "ID del cliente"
# }

variable "Azure_Tenant_Id" {
  type        = string
  description = "Tenat-ID"
}

# variable "Azure_Client_Secret" {
#   type        = string
#   description = "Client-Secret"
# }

variable "Azure_Subscription_Id" {
  type        = string
  description = "Subscription"
}

#Variables Network
variable "address_segment" {
  description = "direccionamiento Network"
  type        = list(string)
}

variable "public_subnet" {
  description = "CiDR_public_subnet"
  type        = string
}

variable "private_subnet" {
  description = "CiDR_private_subnet"
  type        = string
}

##Variables VM
# variable "appserver" {
#   type        = string
#   description = "nombre vm"
# }

variable "admin_user" {
  description = "user administrator"
  type        = string
}

variable "public_key_path" {
  description = "Ruta de la clave pública SSH"
  type        = string
}



