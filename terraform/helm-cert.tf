resource "kubernetes_namespace" "cm" {
  metadata {
    name = "cert-manager"
  }
}
resource "helm_release" "cm" {
  name             = "cm"
  namespace        = kubernetes_namespace.cm.metadata[0].name
  create_namespace = false
  chart            = "cert-manager"
  repository       = "https://charts.jetstack.io"
  version          = "v1.5.3"
  values = [
    file("values.yaml")
  ]
  depends_on = [module.eks_cluster, kubernetes_namespace.cm, aws_iam_role.route53 ]

}
