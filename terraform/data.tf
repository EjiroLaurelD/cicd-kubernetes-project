data "aws_region" "current" {}

data "aws_eks_cluster" "cluster" {
  name = "myapps"
  depends_on = [module.eks_cluster]
}

data "aws_eks_cluster_auth" "cluster" {
  name = "myapps"
}
