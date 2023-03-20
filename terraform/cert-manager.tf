module "cert_manager" {
  source        = "terraform-iaac/cert-manager/kubernetes"

  cluster_issuer_email                   = "dafelaureld@gmai.com"
  cluster_issuer_name                    = "cert-manager-global"
  cluster_issuer_private_key_secret_name = "cert-manager-private-key"

 depends_on = [module.eks_cluster, kubernetes_namespace.cert_manager_ns, aws_iam_role.route53_policy ]

}


