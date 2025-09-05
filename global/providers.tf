terraform {
  backend "azurerm" {
    resource_group_name  = "rg-tfstate"
    storage_account_name = "stfabricstate"
    container_name       = "tfstate"
    key                  = "fabric.terraform.tfstate"
  }
}