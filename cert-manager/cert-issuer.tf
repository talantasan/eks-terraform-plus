resource "kubectl_manifest" "staging_issuer" {
    count = var.staging_issuer ? 1:0
    yaml_body = "${file("./manifests/staging-issuer.yml")}" 
    depends_on = [helm_release.cert_manager]
}

resource "kubectl_manifest" "prod_issuer" {
    count = var.prod_issuer ? 1:0
    yaml_body = "${file("./manifests/prod-issuer.yml")}" 
    depends_on = [helm_release.cert_manager]
}

variable prod_issuer {
    default = "false"
}

variable staging_issuer {
    default = "true"
}