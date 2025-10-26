
provider "kubernetes" {
  host                   = component.eks[each.key].cluster_endpoint
  cluster_ca_certificate = base64decode(component.eks[each.key].cluster_certificate_authority_data)
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    args        = ["eks", "get-token", "--cluster-name", component.eks[each.key].eks_cluster_name]
    command     = "aws"
  }
}
