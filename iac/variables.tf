variable "resource_group_name" {
  type        = string
  description = "Name of the Azure Resource Group"
  default     = "rg-devsecops-lab"
}

variable "location" {
  type        = string
  description = "Azure Region"
  default     = "uae central"
}

variable "prefix" {
  type        = string
  description = "Prefix for infrastructure resources"
  default     = "devsecops"
}
