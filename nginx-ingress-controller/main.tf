module "nginx_ingress_namespace"{
    source  = "../modules/k8s_namespace"
    chart_name  = "nginx-ingress"
}

# This chart will create NLB on AWS along with nginx-ingress
resource "helm_release" "nginx_ingress" {
  name       = "nginx-ingress-controller"
  chart      = "./chart"
  version    = "9.3.22"
  namespace  = "nginx-ingress"

  values = [
    "${file("./values.yml")}"
  ]
}