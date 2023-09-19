terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=2.0.0"
    }
  }
}

# Configure the Microsoft Azure Provider
provider "azurerm" {
  features {}
}

terraform {
  backend "azurerm" {
   
resource_group_name  = "backend"
storage_account_name  = "backendvm"
container_name        = "demo2backend"
key                   = "demo2backend.tfstate"
    
  }
}
