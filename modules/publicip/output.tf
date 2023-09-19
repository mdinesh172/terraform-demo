output "public_ip" {
  value = azurerm_public_ip.myip.ip_address
}

output "public_id" {
  value = azurerm_public_ip.myip.id
}