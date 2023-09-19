
resource "azurerm_windows_virtual_machine" "vm_wvm" {
  name                = var.windows_virtual_machine
  resource_group_name = var.resource_group_name
  location            = var.resource_group_location
  size                = var.size
  admin_username      = var.admin_username
  admin_password      = var.admin_password
  network_interface_ids = [
    var.network_interface_ids,
  ]
  
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = var.publisher
    offer     = var.offer
    sku       = var.sku
    version   = "latest"
  }
}
