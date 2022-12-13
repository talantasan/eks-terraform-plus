# Troubleshooting clusterIssuer

```
~ kubectl get clusterissuer
~ kubectl get secrets
~ kubectl get certificates
~ kubectl describe certificate name_of_certificate
```

# Automatic TLS Ingress with annotiations
***
- It is also possible to annotate Ingress resources for cert-manager
- If we annotate an Ingress resources with **_cert-manager.io/cluster-issuer=xxx_**
    1. cert-manager will detect that annotation
    2. it will obtain a certificate using the specified ClusterIssuer(xxx)
    3. it will store the key and certificate in the specified Secret
- Note: Ingress still needs the **tls** section with **secretName** and **hosts** 
***
