# Troubleshooting clusterIssuer
```
kubectl get clusterissuer
```

# Automatic TLS Ingress with annotiations
```
- It is also possible to annotate Ingress resources for cert-manager
- If we annotate an Ingress resources with **_cert-manager.io/cluster-issuer=letsencrypt-prod_**
```
