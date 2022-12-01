module "nginx_ingress_namespace"{
    source  = "../modules/k8s_namespace"
    chart_name  = "external-dns"
}

resource "helm_release" "external_dns" {
  name       = "external-dns"
  chart      = "./chart"
  version    = "6.12.1"
  namespace  = "external-dns"

  values = [
    templatefile("./values.yml", 
      { 
      external_dns_role = local.external_dns_role_arn
      }
    )
  ]
}