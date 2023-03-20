data "aws_iam_policy_document" "route53_role__policy" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    condition {
      test     = "StringEquals"
      variable = "${replace(module.eks_cluster.cluster_oidc_issuer_url, "https://", "")}:sub"
      values   = ["system:serviceaccount:${kubernetes_namespace.cert_manager.metadata[0].name}:cert-manager"]
    }

    principals {
      identifiers = [module.eks_cluster.oidc_provider_arn]
      type        = "Federated"
    }
  }
}


resource "aws_iam_role_policy" "route53_policy" {
  name = "route53"
  role = aws_iam_role.route53.id
  policy = file("./route53.json")

}

resource "aws_iam_role" "route53" {
  name = "Route53"
  assume_role_policy = data.aws_iam_role_policy_document.route53_policy.json
}

resource"aws_iam_role_policy_attachment" "route53_policy_attach" {
  role = aws_iam_role.route53.name
  policy_arn = aws_iam_policy.route53_policy.arn
}

output "route53_policy" {
   value = aws_iam_role.route53_policy.arn
}
