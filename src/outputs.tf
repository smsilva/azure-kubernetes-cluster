output "aks_id" {
  value = module.aks.aks_id
}

output "aks_kubelet_identity_client_id" {
  value = module.aks.aks_kubelet_identity_client_id
}

output "kubeconfig" {
  value     = module.aks.aks_kubeconfig
  sensitive = true
}
