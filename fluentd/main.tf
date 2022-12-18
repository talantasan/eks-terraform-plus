resource "helm_release" "fluentd" {
  name       = "fluentd"
  chart      = "./chart"
  version    = "0.3.9"
  values = [
    templatefile("./values.yml", 
      { 
      external_dns_role = local.var_external_dns_role_arn
      text_owner_id = local.var_textOwnerId
      domain_filters = local.var_domainFilters 
      }
    )
  ]
}