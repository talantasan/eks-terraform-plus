resource "kubectl_manifest" "banana" {
    yaml_body = "${file("./manifests/banana.yml")}"
}

resource "kubectl_manifest" "banana_svc" {
    yaml_body = "${file("./manifests/banana-svc.yml")}"
}