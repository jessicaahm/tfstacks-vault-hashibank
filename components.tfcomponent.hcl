component "vso" {
    for_each = var.regions
    source = "./vault-vso"
    
    inputs = {
        eks_cluster_name = component.eks[each.key].cluster_name
        cluster_endpoint = component.eks[each.key].cluster_endpoint
        cluster_certificate_authority_data = component.eks[each.key].cluster_certificate_authority_data
    }
    
    providers = {
        kubernetes  = provider.kubernetes.configurations[each.key]
    }
}