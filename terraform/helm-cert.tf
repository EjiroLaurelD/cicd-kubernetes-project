resource "kubernetes_namespace" "cert-manager-app" {
  metadata {
    name = "cert-manager"
  }
}
resource "helm_release" "cert-manager" {
  name             = "cert-manager"
  namespace        = kubernetes_namespace.cert-manager-app.metadata[0].name
  timeout          = 1000
  create_namespace = false
  chart            = "cert-manager"
  repository       = "https://charts.jetstack.io"
  version          = "v1.11.0"
  values = [
    file("values.yaml")
  ]
  depends_on = [module.eks_cluster, kubernetes_namespace.cert-manager-app, aws_iam_role.route53 ]

}
