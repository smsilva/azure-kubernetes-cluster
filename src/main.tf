locals {
  cluster_name            = var.cluster_name
  virtual_network_name    = "${local.cluster_name}-vnet"
  virtual_network_cidrs   = ["10.0.0.0/8"]
  virtual_network_subnets = [{ cidr = "10.150.0.0/16", name = "aks" }]
  resource_group_name     = var.resource_group_name != "" ? var.resource_group_name : local.cluster_name
  admin_group_ids         = ["d5075d0a-3704-4ed9-ad62-dc8068c7d0e1"]
}

data "azurerm_resource_group" "default" {
  name = local.resource_group_name
}

module "vnet" {
  source = "git@github.com:smsilva/azure-network.git//src/vnet?ref=2.0.0"

  name                = local.virtual_network_name
  cidrs               = local.virtual_network_cidrs
  subnets             = local.virtual_network_subnets
  resource_group_name = data.azurerm_resource_group.default.name
  location            = var.cluster_location
}

module "aks" {
  source = "git@github.com:smsilva/azure-kubernetes.git//src?ref=2.1.0"

  cluster_name            = local.cluster_name
  cluster_location        = var.cluster_location
  cluster_version         = var.cluster_version
  cluster_subnet_id       = module.vnet.subnets["aks"].instance.id
  cluster_admin_group_ids = local.admin_group_ids
  default_node_pool_name  = "system" # 12 Alphanumeric characters
  resource_group_name     = data.azurerm_resource_group.default.name
}
