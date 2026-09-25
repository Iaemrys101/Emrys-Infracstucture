variable "location" {
  description = "Azure region used for the infrastructure."
  type        = string
}

variable "resource_group_name" {
  description = "Name of the Azure resource group."
  type        = string
}

variable "vnet_name" {
  description = "Name of the virtual network."
  type        = string
}

variable "vnet_address_space" {
  description = "Address space assigned to the virtual network."
  type        = list(string)
}

variable "subnet_name" {
  description = "Name of the workload subnet."
  type        = string
}

variable "subnet_address_prefixes" {
  description = "Address ranges assigned to the workload subnet."
  type        = list(string)
}

variable "tags" {
  description = "Standard organisational resource tags."
  type        = map(string)
}