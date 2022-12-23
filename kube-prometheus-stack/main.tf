module "nginx_ingress_namespace"{
    source  = "../modules/k8s_namespace"
    chart_name  = "prometheus"
}

# This chart will create NLB on AWS along with nginx-ingress
resource "helm_release" "kube_prometheus_stack" {
  name       = "kube-prometheus-stack"
  chart      = "./chart"
  version    = "43.1.3"
  namespace  = "prometheus"

  values = [
    "${file("./values.yml")}"
  ]
}