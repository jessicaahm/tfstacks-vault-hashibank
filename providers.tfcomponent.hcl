required_providers {
  aws = {
    source  = "hashicorp/aws"
    version = "~> 6.14.1"
  }
  tls = {
    source  = "hashicorp/tls"
    version = "~> 4.1.0"
  }
  kubernetes = {
    source  = "hashicorp/kubernetes"
    version = "~> 2.25"
  }
}

provider "kubernetes" "this" {
  config {
    host                   = var.cluster_endpoint
    cluster_ca_certificate = base64decode(var.cluster_certificate_authority_data)
    token                  = data.aws_eks_cluster_auth.cluster.token
  }
}