variable "cluster_name" {
  type        = string
  description = "Cluster Name"
  default     = "wasp-aks"
}

variable "cluster_location" {
  type        = string
  description = "Cluster Location"
  default     = "centralus"
}

variable "cluster_version" {
  type        = string
  description = "Cluster Version"
  default     = "1.21.2"
}

variable "resource_group_name" {
  type        = string
  description = "Resource Group Name"
  default     = "wasp-aks"
}
