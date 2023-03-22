#locals {
 # cluster_name = "eks-cluster-${var.name}-${data.aws_region.current.name}"
#}

module "eks_cluster" {
  source  = "terraform-aws-modules/eks/aws"
  version = "19.0"

  cluster_name                    = "myapps"
  cluster_version                 = var.cluster_version
  cluster_endpoint_private_access = true
  cluster_endpoint_public_access  = true

  cluster_addons = {
    coredns = {
      most_recent = true
    }
    kube-proxy = {
      most_recent = true
    }
    vpc-cni = {
      most_recent = true
    }
  }

  subnet_ids = [aws_subnet.private[0].id, aws_subnet.private[1].id, aws_subnet.private[2].id]
  vpc_id     = aws_vpc.main.id

  enable_irsa = true

  eks_managed_node_group_defaults = {
    instance_types = var.group_instance_type

    attach_cluster_primary_security_group = false
    vpc_security_group_ids                = [aws_security_group.allow-web-traffic.id]
  }

  eks_managed_node_groups = {
    dev = {
      instance_types = [var.group_instance_type[1]]
      desired_size   = var.group_desired_size
      min_size       = var.group_min_size
      max_size       = var.group_max_size
      capacity_type  = var.group_capacity_type
      labels = {
        Name = "sockshop-${var.name}-${data.aws_region.current.name}"
      }
      tags = merge(var.tags, {
        "Name" = "sockshop-${var.name}-${data.aws_region.current.name}"
      })
    }
   # provisioner "local-exec" {

  # command = " aws eks update-kubeconfig --name myapps --region ${var.region}"

#}

 # }
  }

  tags = merge(var.tags, {
    "Name" = "eks-cluster-${var.name}-${data.aws_region.current.name}"
  })
#  node_security_group_additional_rules = {
 #   # nginx-ingress requires the cluster to communicate with the ingress controller
  #  cluster_to_node = {
   #   description      = "Cluster to ingress-nginx webhook"
    #  protocol         = "tcp"
     ###ype             = "ingress"
      #source_cluster_security_group = true
    #}
 #provisioner "local-exec" {

  # command = " aws eks update-kubeconfig --name myapps --region ${var.region}"

#}
  }
#resource "null_resource" "eks_master_worker_join" {

 # provisioner "local-exec" {

   # command = "sh /Users/dhineshbabu.elango/Documents/Terraform_shellScripts/bin/eks_app_provision.sh ${module.my_cluster.cluster_id}"

  #}

#}

resource "null_resource" "deploy-manifests" {
  provisioner "local-exec" {
    command = "sh aws eks update-kubeconfig --name myapps --region ${module.my_cluster.cluster_id"
}
  depends_on = [module.eks_cluster]
}

