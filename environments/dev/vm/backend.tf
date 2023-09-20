terraform {
  backend "azurerm" {
    resource_group_name   = "terrastate"
    storage_account_name = "terrastate1"
    container_name       = "statebackend"
    key                  = "terrastate.tfstate"
  }
}