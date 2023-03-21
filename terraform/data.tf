data "aws_region" "current" {}

data "eks_cluster" "cluster" {
  name = module.eks_cluster.cluster_name
}

data "eks_cluster_auth" "cluster" {
  name = module.eks_cluster.cluster_name
}
