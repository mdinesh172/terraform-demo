resource "azurerm_network_interface_security_group_association" "associate_nsg" {
  network_interface_id      = var.network_interface_ids
  network_security_group_id = var.nsg_id
}