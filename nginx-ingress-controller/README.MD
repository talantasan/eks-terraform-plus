helm repo add nginx-stable https://helm.nginx.com/stable
helm repo update

helm pull nginx-stable/nginx-ingress
helm install 