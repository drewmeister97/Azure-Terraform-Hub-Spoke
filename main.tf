provider "azurerm" {
  features {}
  skip_provider_registration = true
}

# Hub VNet
resource "azurerm_virtual_network" "hub_vnet" {
  name                = var.hub_vnet_name
  address_space       = [var.hub_address_space]
  location            = var.location
  resource_group_name = var.resource_group_name
}

# Spoke VNets
resource "azurerm_virtual_network" "spoke_vnet_1" {
  name                = var.spoke_vnet_1_name
  address_space       = [var.spoke_vnet_1_address_space]
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_virtual_network" "spoke_vnet_2" {
  name                = var.spoke_vnet_2_name
  address_space       = [var.spoke_vnet_2_address_space]
  location            = var.location
  resource_group_name = var.resource_group_name
}

resource "azurerm_virtual_network" "spoke_vnet_3" {
  name                = var.spoke_vnet_3_name
  address_space       = [var.spoke_vnet_3_address_space]
  location            = var.location
  resource_group_name = var.resource_group_name
}

# VNet Peering - Spoke 1 to Hub
resource "azurerm_virtual_network_peering" "spoke1_to_hub" {
  name                      = "spoke1-to-hub"
  resource_group_name       = var.resource_group_name
  virtual_network_name      = azurerm_virtual_network.spoke_vnet_1.name
  remote_virtual_network_id = azurerm_virtual_network.hub_vnet.id
  allow_forwarded_traffic   = true
  allow_gateway_transit     = false
  use_remote_gateways       = false
}

resource "azurerm_virtual_network_peering" "hub_to_spoke1" {
  name                      = "hub-to-spoke1"
  resource_group_name       = var.resource_group_name
  virtual_network_name      = azurerm_virtual_network.hub_vnet.name
  remote_virtual_network_id = azurerm_virtual_network.spoke_vnet_1.id
  allow_forwarded_traffic   = true
  allow_gateway_transit     = false
  use_remote_gateways       = false
}

# VNet Peering - Spoke 2 to Hub
resource "azurerm_virtual_network_peering" "spoke2_to_hub" {
  name                      = "spoke2-to-hub"
  resource_group_name       = var.resource_group_name
  virtual_network_name      = azurerm_virtual_network.spoke_vnet_2.name
  remote_virtual_network_id = azurerm_virtual_network.hub_vnet.id
  allow_forwarded_traffic   = true
  allow_gateway_transit     = false
  use_remote_gateways       = false
}

resource "azurerm_virtual_network_peering" "hub_to_spoke2" {
  name                      = "hub-to-spoke2"
  resource_group_name       = var.resource_group_name
  virtual_network_name      = azurerm_virtual_network.hub_vnet.name
  remote_virtual_network_id = azurerm_virtual_network.spoke_vnet_2.id
  allow_forwarded_traffic   = true
  allow_gateway_transit     = false
  use_remote_gateways       = false
}

# VNet Peering - Spoke 3 to Hub
resource "azurerm_virtual_network_peering" "spoke3_to_hub" {
  name                      = "spoke3-to-hub"
  resource_group_name       = var.resource_group_name
  virtual_network_name      = azurerm_virtual_network.spoke_vnet_3.name
  remote_virtual_network_id = azurerm_virtual_network.hub_vnet.id
  allow_forwarded_traffic   = true
  allow_gateway_transit     = false
  use_remote_gateways       = false
}

resource "azurerm_virtual_network_peering" "hub_to_spoke3" {
  name                      = "hub-to-spoke3"
  resource_group_name       = var.resource_group_name
  virtual_network_name      = azurerm_virtual_network.hub_vnet.name
  remote_virtual_network_id = azurerm_virtual_network.spoke_vnet_3.id
  allow_forwarded_traffic   = true
  allow_gateway_transit     = false
  use_remote_gateways       = false
}

# Firewall Subnets
resource "azurerm_subnet" "firewall_subnet" {
  name                 = "AzureFirewallSubnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.hub_vnet.name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_subnet" "firewall_management_subnet" {
  name                 = "AzureFirewallManagementSubnet"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.hub_vnet.name
  address_prefixes     = ["10.0.2.0/24"]
}

# Public IP for Firewall
resource "azurerm_public_ip" "firewall_pip" {
  name                = "${var.firewall_name}-pip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
}

# Azure Firewall
resource "azurerm_firewall" "example" {
  name                = var.firewall_name
  location            = var.location
  resource_group_name = var.resource_group_name

  sku_name = "AZFW_VNet"
  sku_tier = "Standard"

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.firewall_subnet.id
    public_ip_address_id = azurerm_public_ip.firewall_pip.id
  }

  management_ip_configuration {
    name          = "management"
    subnet_id     = azurerm_subnet.firewall_management_subnet.id
    public_ip_address_id = azurerm_public_ip.firewall_pip.id
  }
}

# Firewall Policy
resource "azurerm_firewall_policy" "example" {
  name                = var.firewall_policy_name
  location            = var.location
  resource_group_name = var.resource_group_name
}

