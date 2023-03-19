module "cert_manager" {
  source        = "terraform-iaac/cert-manager/kubernetes"

  cluster_issuer_email                   = "dafelaureld@gmai.com"
  cluster_issuer_name                    = "letsencrypt-dns"
  cluster_issuer_private_key_secret_name = "cert-manager-private-key"
}

