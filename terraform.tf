terraform {
  backend "azurerm" {
    resource_group_name  = "data-skp-rg1"
    storage_account_name = "pyddatablob"
    container_name       = "terraform-backend"
    key                  = "dev_terraform.tfstate"
  }
}
