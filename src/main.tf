resource "random_string" "instance_id" {
  keepers = {
    cluster_name = var.cluster_name
  }

  length      = 3
  min_lower   = 1
  min_numeric = 2
  lower       = true
  special     = false
}

locals {
  cluster_name            = "${var.cluster_name}-${random_string.instance_id.result}"
  virtual_network_name    = "${local.cluster_name}-vnet"
  virtual_network_cidrs   = ["10.0.0.0/8"]
  virtual_network_subnets = [{ cidr = "10.150.0.0/16", name = "aks" }]
  resource_group_name     = var.resource_group_name != "" ? var.resource_group_name : local.cluster_name
  cluster_admin_group_ids = var.cluster_admin_group_ids
}

resource "azurerm_resource_group" "default" {
  name     = local.resource_group_name
  location = var.cluster_location
}

module "vnet" {
  source = "git@github.com:smsilva/azure-network.git//src/vnet?ref=3.0.5"

  name                = local.virtual_network_name
  cidrs               = local.virtual_network_cidrs
  subnets             = local.virtual_network_subnets
  resource_group_name = azurerm_resource_group.default.name

  depends_on = [
    azurerm_resource_group.default
  ]
}

module "aks" {
  source = "git@github.com:smsilva/azure-kubernetes.git//src?ref=3.0.0"

  cluster_name            = local.cluster_name
  cluster_location        = var.cluster_location
  cluster_version         = var.cluster_version
  cluster_subnet_id       = module.vnet.subnets["aks"].instance.id
  cluster_admin_group_ids = local.cluster_admin_group_ids
  default_node_pool_name  = "sysnp01" # 12 Alphanumeric characters
  resource_group_name     = azurerm_resource_group.default.name

  depends_on = [
    azurerm_resource_group.default
  ]
}
