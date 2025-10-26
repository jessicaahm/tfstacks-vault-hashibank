# locals {
#     tf_organization = "jessica-org"
#     tf_project_name = "hackathon"
# }

# identity_token "aws" {
#   audience = ["aws.workload.identity"]
# }

# deployment "development" {
#     inputs {
#         aws_region = "us-east-1"
#         eks_cluster_name = upstream_input.eks_cluster_name
#         cluster_endpoint = upstream_input.cluster_endpoint
#         cluster_certificate_authority_data = upstream_input.cluster_certificate_authority_data
#     }
# }