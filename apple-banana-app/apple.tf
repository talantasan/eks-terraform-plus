resource "kubectl_manifest" "apple" {
    yaml_body = "${file("./manifests/apple.yml")}" 
}

resource "kubectl_manifest" "apple_svc" {
    yaml_body = "${file("./manifests/apple-svc.yml")}" 
}

