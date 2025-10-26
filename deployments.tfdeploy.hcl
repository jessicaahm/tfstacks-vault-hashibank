locals {
  tf_organization = "jessica-org"
  tf_project_name = "hackathon"
  upstream_stack  = "tfstacks-vpc-eks-hashibank"
}

# Identity token for AWS workload identity
identity_token "aws" {
  audience = ["aws.workload.identity"]
}

# Identity token for Kubernetes workload identity
identity_token "k8s" {
  audience = ["k8s.workload.identity"]
}

# Upstream inputs from the VPC-EKS stack
upstream_input "eks_cluster_name" {
  type   = "stack"
  source = "app.terraform.io/${local.tf_organization}/${local.tf_project_name}/${local.upstream_stack}"
}

upstream_input "cluster_endpoint" {
  type   = "stack"
  source = "app.terraform.io/${local.tf_organization}/${local.tf_project_name}/${local.upstream_stack}"
}

upstream_input "cluster_certificate_authority_data" {
  type   = "stack"
  source = "app.terraform.io/${local.tf_organization}/${local.tf_project_name}/${local.upstream_stack}"
}

deployment "development" {
  inputs = {
    # Required variables
    regions                = ["us-east-1"]
    aws_identity_token     = identity_token.aws.jwt
    k8s_identity_token     = identity_token.k8s.jwt
    role_arn               = "arn:aws:iam::ACCOUNT_ID:role/YOUR_ROLE_NAME"  # Update this

    # VPC configuration (if needed)
    vpc_name = "vault-vpc"
    vpc_cidr = "10.1.0.0/16"

    # Kubernetes configuration
    kubernetes_version = "1.29"
    cluster_name       = "eks-cluster"
    namespace          = "hashibank"

    # Terraform Cloud configuration
    tfc_hostname              = "app.terraform.io"
    tfc_organization_name     = local.tf_organization
    tfc_kubernetes_audience   = "k8s.workload.identity"

    # EKS admin configuration
    eks_clusteradmin_arn      = "arn:aws:iam::ACCOUNT_ID:role/YOUR_ADMIN_ROLE"  # Update this
    eks_clusteradmin_username = "admin"

    # Upstream inputs from VPC-EKS stack
    # Note: The upstream outputs are maps with region keys
    # You'll need to select the specific region value
    eks_cluster_name                       = upstream_input.eks_cluster_name["us-east-1"]
    cluster_endpoint                       = upstream_input.cluster_endpoint["us-east-1"]
    cluster_certificate_authority_data     = upstream_input.cluster_certificate_authority_data["us-east-1"]
  }
}