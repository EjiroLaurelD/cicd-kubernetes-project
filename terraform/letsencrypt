resource "kubectl_manifest" "cluster-issuer" {
  yaml_body = <<YAML
apiVersion: cert-manager.io/v1
kind: ClusterIssuer
metadata:
  name: letsencrypt-dns
spec:
  acme:
    server: https://acme-v02.api.letsencrypt.org/directory
    email: "dafelaurele@gmail.com"
    privateKeySecretRef:
      name: wildcard-cert-bkcvg
    solvers:            
      - dns01: 
          route53:
            #accessKeyID: "QUtJQVkyQTZGWTdaMjNMT1lQRk8"
            hostedZoneID: "Z0854745S4SSGNV4M9O3"
            region: us-east-1
            #secretAccessKeySecretRef:
             # name: cluster-issuer-secret
              #key: "MTQzWGpCdVpmaXhsbTBIcDIyOXhtUVRLOHFuZ3pKNXFLOXhBb1JEdw=="
  YAML
   
  depends_on = [helm_release.cert-manager]
}

resource "kubectl_manifest" "certificate" {
  yaml_body = <<YAML

apiVersion: cert-manager.io/v1
kind: Certificate
metadata:
  name: wildcard-cert
  namespace: cert-manager
spec:
  dnsNames:
  - '*.ejirolaureld.me'
  issuerRef:
    name: letsencrypt-dns      
    kind: ClusterIssuer
  secretName: "wildcard-cert"
  commonName: "*.ejirolaureld.me"
YAML

  depends_on = [kubectl_manifest.cluster-issuer]
}
