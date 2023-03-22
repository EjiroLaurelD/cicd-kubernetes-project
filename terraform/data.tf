data "aws_region" "current" {}

data "aws_eks_cluster" "cluster" {
  name = "myapps" 
}

data "aws_eks_cluster_auth" "cluster" {
  name = "myapps" 
}
