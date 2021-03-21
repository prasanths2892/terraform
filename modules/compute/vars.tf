variable "resource_group" {}
variable "location" {}
variable "web_subnet_id" {}
variable "app_subnet_id" {}

variable "vm_size" {
  default = "Standard_D2s_v3"
}


variable "image_publisher" {
  default = "Canonical"
}
variable "image_offer" {
  default = "UbuntuServer"
}
variable "image_sku" {
  default = "18.04-LTS"
}
variable "image_version" {
  default = "latest"
}
variable "os_caching" {
    default = "ReadWrite"
}
variable "create_option" {
    default = "FromImage"
} 
variable "managed_disk_type" {
   default =  "Standard_LRS"
}
variable "web_host_name"{}
variable "web_username" {}
variable "web_os_password" {}
variable "app_host_name"{}
variable "app_username" {}
variable "app_os_password" {}
