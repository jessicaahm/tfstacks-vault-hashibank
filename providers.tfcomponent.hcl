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

upstream_input "eks_cluster_name" {
    type = "stack"
    source = "app.terraform.io/jessica-org/hackathon/tfstacks-vpc-eks-hashibank"
}

upstream_input "cluster_endpoint" {
    type = "stack"
    source = "app.terraform.io/jessica-org/hackathon/tfstacks-vpc-eks-hashibank"
}

upstream_input "cluster_certificate_authority_data" {
    type = "stack"
    source = "app.terraform.io/jessica-org/hackathon/tfstacks-vpc-eks-hashibank"
}

provider "kubernetes" "this" {
  config {
    host                   = upstream_input.eks_cluster.cluster_endpoint
    cluster_ca_certificate = base64decode(upstream_input.eks_cluster.cluster_certificate_authority_data)
    token                  = data.aws_eks_cluster_auth.cluster.token
  }
}