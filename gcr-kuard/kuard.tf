resource "kubectl_manifest" "kuard" {
    yaml_body = "${file("./manifests/kuard-deploy.yml")}" 
}

resource "kubectl_manifest" "kuard_svc" {
    yaml_body = "${file("./manifests/kuard-svc.yml")}" 
}

resource "kubectl_manifest" "kuard_ingress" {
    yaml_body = "${file("./manifests/kuard-ingress.yml")}" 
}

resource "kubectl_manifest" "kuard_certificate_staging"{
    count = var.cert_staging_enable ? 1:0 
    yaml_body = "${file("./manifests/certificate_staging.yml")}"
}

resource "kubectl_manifest" "kuard_certificate_prod"{
    count = var.cert_prod_enable ? 1:0
    yaml_body = "${file("./manifests/certificate_prod.yml")}"
}

variable cert_staging_enable {
  type        = string
  default     = "true"
}

variable cert_prod_enable {
    default = "false"
}


