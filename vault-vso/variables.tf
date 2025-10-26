variable "eks_cluster_name" {
  type    = string
}

variable "cluster_endpoint" {
  type        = string
  description = "EKS cluster endpoint"
}

variable "cluster_certificate_authority_data" {
  type        = string
  description = "EKS cluster certificate authority data"
}