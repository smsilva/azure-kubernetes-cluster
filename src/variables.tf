variable "cluster_name" {
  type        = string
  description = "Cluster Name"
  default     = "aks"
}

variable "cluster_location" {
  type        = string
  description = "Cluster Location"
  default     = "eastus2"
}

variable "cluster_version" {
  type        = string
  description = "Cluster Version"
  default     = "1.21.2"
}

variable "resource_group_name" {
  type        = string
  description = "Resource Group Name"
  default     = ""
}

variable "cluster_admin_group_ids" {
  type        = list(string)
  description = "AKS Admin Groups"
}
