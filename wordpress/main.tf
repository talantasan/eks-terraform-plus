module "wordpress"{
    source  = "../modules/k8s_namespace"
    chart_name  = "talant-wordpress"
}

resource "helm_release" "wordpress" {
  name       = "wordpress"
  chart      = "./chart"
  version    = "15.2.16"
  namespace  = "talant-wordpress"

  values = [
    "${file("./values.yml")}"
  ]
}