resource "kubectl_manifest" "aws_cli_pod" {
    yaml_body = "${file("./manifests/aws-cli-pod.yml")}" 
}

resource "kubectl_manifest" "service_account" {
    yaml_body = "${file("./manifests/serviceaccount.yml")}" 
}

