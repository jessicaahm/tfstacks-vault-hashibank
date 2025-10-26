component "vso" {
    for_each = var.regions
    source = "./vault-vso"
    
    inputs = {
        eks_cluster_name = var.eks_cluster_name
        cluster_endpoint = var.cluster_endpoint
        cluster_certificate_authority_data = var.cluster_certificate_authority_data
    }
    
    providers = {
        kubernetes  = provider.kubernetes.configurations[each.key]
    }
}