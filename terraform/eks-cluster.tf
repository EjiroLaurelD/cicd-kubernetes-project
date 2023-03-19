locals {
  cluster_name = "myapps"
}

module "eks_cluster" {
  source  = "terraform-aws-modules/eks/aws"
  version = "18.25.0"

  cluster_name                    = local.cluster_name
  cluster_version                 = var.cluster_version
  cluster_endpoint_private_access = true
  cluster_endpoint_public_access  = true

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
    
  }

  tags = merge(var.tags, {
    "Name" = "eks-cluster-${var.name}-${data.aws_region.current.name}"
  })
}

resource "null_resource" "deploy-manifests" {
  provisioner "local-exec" {
    command = " aws eks update-kubeconfig --name myapps --region ${var.region} ; kubectl apply -f ../portfolio-manifest ; kubectl apply -f ../complete-demo.yaml; kubectl apply -f ../manifest-ingress ; kubectl apply -f ../manifests-monitoring"
}
  depends_on = [module.eks_cluster]
}

