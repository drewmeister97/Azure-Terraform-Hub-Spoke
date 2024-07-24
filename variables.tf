variable "resource_group_name" {
  description = "The name of the resource group."
  type        = string
  default     = "rg-hub-spoke-001"
}

variable "location" {
  description = "The Azure region where resources will be created."
  type        = string
  default     = "South Central US"
}

# Hub VNet Variables
variable "hub_vnet_name" {
  description = "The name of the hub virtual network."
  type        = string
  default     = "example-hub-vnet"
}

variable "hub_address_space" {
  description = "The address space for the hub virtual network."
  type        = string
  default     = "10.0.0.0/16"
}

# Spoke VNet Variables
variable "spoke_vnet_1_name" {
  description = "The name of the first spoke virtual network."
  type        = string
  default     = "spoke-vnet-1"
}

variable "spoke_vnet_1_address_space" {
  description = "The address space for the first spoke virtual network."
  type        = string
  default     = "10.1.0.0/16"
}

variable "spoke_vnet_2_name" {
  description = "The name of the second spoke virtual network."
  type        = string
  default     = "spoke-vnet-2"
}

variable "spoke_vnet_2_address_space" {
  description = "The address space for the second spoke virtual network."
  type        = string
  default     = "10.2.0.0/16"
}

variable "spoke_vnet_3_name" {
  description = "The name of the third spoke virtual network."
  type        = string
  default     = "spoke-vnet-3"
}

variable "spoke_vnet_3_address_space" {
  description = "The address space for the third spoke virtual network."
  type        = string
  default     = "10.3.0.0/16"
}

# Firewall Variables
variable "firewall_name" {
  description = "The name of the Azure Firewall."
  type        = string
  default     = "example-firewall"
}

variable "firewall_policy_name" {
  description = "The name of the Azure Firewall policy."
  type        = string
  default     = "example-firewall-policy"
}
