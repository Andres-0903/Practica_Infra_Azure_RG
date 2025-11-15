#Variables Azure
variable "Azure_Tenant_Id" {}
variable "Azure_Subscription_Id" {}

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

variable "admin_user" {
  description = "user administrator"
  type        = string
}

variable "public_key_path" {
  description = "Ruta de la clave pública SSH"
  type        = string
}
##tags
variable "tags" {
  description = "Tags globales"
  type        = map(string)
}


