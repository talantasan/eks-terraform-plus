module "cert_manager"{
    source  = "../modules/k8s_namespace"
    chart_name  = "cert-manager"
}

# This chart will create NLB on AWS along with nginx-ingress
resource "helm_release" "cert_manager" {
  name       = "cert-manager"
  chart      = "./chart"
  version    = "0.8.9"
  namespace  = "cert-manager"

  values = [
    "${file("./values.yml")}"
  ]
}



