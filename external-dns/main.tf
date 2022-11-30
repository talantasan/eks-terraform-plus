module "nginx_ingress_namespace"{
    source  = "../modules/k8s_namespace"
    chart_name  = "external-dns"
}

# This chart will create NLB on AWS along with nginx-ingress
resource "helm_release" "nginx_ingress" {
  name       = "external-dns"
  chart      = "./chart"
  version    = "6.12.1"
  namespace  = "external-dns"

  values = [
    "${file("./values.yml")}"
  ]
}