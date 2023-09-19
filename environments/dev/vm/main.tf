  resource "azurerm_resource_group" "vm_rg" {
  name     = var.vm_rg_group_name
  location = var.vm_rg_group_location
}


module "virtual_machine" {
  source                  = "../../../modules/virtualmachine"
  windows_virtual_machine = var.vm_name
  resource_group_name     = azurerm_resource_group.vm_rg.name
  resource_group_location = azurerm_resource_group.vm_rg.location
  admin_username          = var.admin_username
  admin_password          = var.admin_password
  publisher               = var.publisher
  offer                   = var.offer
  sku                     = var.sku
  size                    = var.vm_size
  network_interface_ids   = "/subscriptions/${var.subscriptions}/resourceGroups/${var.vm_rg_group_name}/providers/Microsoft.Network/networkInterfaces/${var.nic_name}"
  depends_on              = [module.network_interface]
}


module "vm_network" {
  source                  = "../../../modules/network"
  virtual_network_name    = var.network_name
  resource_group_name     = azurerm_resource_group.vm_rg.name
  resource_group_location = azurerm_resource_group.vm_rg.location
  address_space           = var.address_space
  subnet_name             = var.subnet_name
  address_prefixes        = var.address_prefixes
  #network_interface_name = var.nic_name
  #public_ip_address_id = var.publicip
  depends_on              = [module.pub_ip]
}


module "pub_ip" {
  source               = "../../../modules/publicip"
  public_ip_name          = var.public_ip_name
  resource_group_name     = var.vm_rg_group_name
  resource_group_location =  var.vm_rg_group_location
  #domain_name_label    = var.domain_name
  depends_on              = [azurerm_resource_group.vm_rg]
  
}


module "network_interface" {
  source                  = "../../../modules/nic"
  network_interface_name  = var.nic_name
  resource_group_name     = azurerm_resource_group.vm_rg.name
  resource_group_location = azurerm_resource_group.vm_rg.location
  subnet_id               = "/subscriptions/${var.subscriptions}/resourceGroups/${var.vm_rg_group_name}/providers/Microsoft.Network/virtualNetworks/${var.network_name}/subnets/${var.subnet_name}"
  public_ip_address_id    = "/subscriptions/${var.subscriptions}/resourceGroups/${var.vm_rg_group_name}/providers/Microsoft.Network/publicIPAddresses/${var.public_ip_name}"
  depends_on              = [module.vm_network]
}

module "nsg" {
  source                  = "../../../modules/nsg"
  nsg_name                = var.nsg_name
  resource_group_name     = azurerm_resource_group.vm_rg.name
  resource_group_location = azurerm_resource_group.vm_rg.location
  depends_on              = [module.network_interface]
}

module "assosiate_nsg" {
  source                  = "../../../modules/assosiate_nsg"
  network_interface_ids   = "/subscriptions/${var.subscriptions}/resourceGroups/${var.vm_rg_group_name}/providers/Microsoft.Network/networkInterfaces/${var.nic_name}"
  nsg_id                  = "/subscriptions/${var.subscriptions}/resourceGroups/${var.vm_rg_group_name}/providers/Microsoft.Network/networkSecurityGroups/${var.nsg_name}"
  depends_on              = [module.nsg]
}




