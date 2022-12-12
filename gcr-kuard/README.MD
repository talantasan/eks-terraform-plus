K8S certificate resource is namespace bound. Make sure you are creating certificates in same namespace where 
application is using it


Kuard Application here uses manual method for certificate creaton:
1. There can be multiple dnsNames
2. The refIssuer must match the clusterIssuer I have created earlier


