data "aws_region" "current" {}

#data "aws_eks_cluster" "cluster" {
#  name = module.eks_cluster.cluster_name 
#}

data "aws_eks_cluster_auth" "cluster" {
  name = module.eks_cluster.cluster_name 
}
