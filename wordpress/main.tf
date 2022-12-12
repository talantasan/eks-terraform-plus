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
    templatefile("./values.yml", 
      { 
      rds_endpoint = aws_
      db_user = local.var_db_user
      db_pass = local.var_db_pass 
      db_name = local.var_db_name
      ingress_hostname = local.var_ingress_hostname
      }
    )
  ]
}