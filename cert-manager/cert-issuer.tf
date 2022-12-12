resource "kubectl_manifest" "staging_issuer" {
    yaml_body = "${file("./manifests/staging-issuer.yml")}" 
    depends_on = [helm_release.cert_manager]
}

# resource "kubectl_manifest" "prod_issuer" {
#     yaml_body = "${file("./manifests/prod-issuer.yml")}" 
#     depends_on = [helm_release.cert_manager]
# }