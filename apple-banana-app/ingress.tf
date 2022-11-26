resource "kubectl_manifest" "ingress" {
    yaml_body = "${file("./manifests/ingress.yml")}"
}