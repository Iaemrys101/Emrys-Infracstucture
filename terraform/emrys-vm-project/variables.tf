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

variable "private_endpoint_subnet_name" {
  description = "Name of the dedicated private-endpoint subnet."
  type        = string
}

variable "private_endpoint_subnet_address_prefixes" {
  description = "Address ranges assigned to the private-endpoint subnet."
  type        = list(string)
}

variable "storage_account_prefix" {
  description = "Lowercase prefix used to build the globally unique Storage Account name."
  type        = string

  validation {
    condition     = can(regex("^[a-z0-9]+$", var.storage_account_prefix))
    error_message = "The Storage Account prefix must contain only lowercase letters and numbers."
  }
}

variable "admin_username" {
  description = "Administrator username for the Linux VMs."
  type        = string
  default     = "azureadmin"
}

variable "ssh_public_key_path" {
  description = "Path to the SSH public key used by the Linux VMs."
  type        = string
}

variable "vm_size" {
  description = "Azure size used by the Linux VMs."
  type        = string
  default     = "Standard_D2als_v6"
}