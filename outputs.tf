output "hub_vnet_name" {
  value = azurerm_virtual_network.hub_vnet.name
}

output "spoke_vnet_1_name" {
  value = azurerm_virtual_network.spoke_vnet_1.name
}

output "spoke_vnet_2_name" {
  value = azurerm_virtual_network.spoke_vnet_2.name
}

output "spoke_vnet_3_name" {
  value = azurerm_virtual_network.spoke_vnet_3.name
}

output "firewall_name" {
  value = azurerm_firewall.example.name
}

output "firewall_policy_name" {
  value = azurerm_firewall_policy.example.name
}
