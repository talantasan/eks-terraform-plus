***Kube Prometheus Stack***
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update

helm install [RELEASE_NAME] prometheus-community/kube-prometheus-stack
or
helm pull prometheus-community/kube-prometheus-stack --untar=true
