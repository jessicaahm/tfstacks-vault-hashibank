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

deployment "vso" {
    inputs {
        eks_cluster_name = upstream_input.eks_cluster_name
        cluster_endpoint = upstream_input.cluster_endpoint
        cluster_certificate_authority_data = upstream_input.cluster_certificate_authority_data
    }
}