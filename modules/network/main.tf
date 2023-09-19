resource "azurerm_virtual_network" "vm_network" {
  name                = var.virtual_network_name
  address_space       = [var.address_space]
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
}

resource "azurerm_subnet" "vm_subnet" {
  name                 = var.subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vm_network.name
  address_prefixes     = [var.address_prefixes]
}


