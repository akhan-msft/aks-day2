---
title: AGIC Behavior
parent:  Module 3 - Application Gateway Ingress Controller
has_children: false
nav_order: 2
---

# Topic 2: Understanding AGIC behavior




## Enabling AGIC in an existing AKS cluster

AGIC with AKS integration

1. Application Gateway is created with an empty backend pool, a default listener, a default rule for port 8 and default http probes.
2. It deploys the AGIC pods within the AKS cluster
3. Accessing the will result in Gateway 52 errors

## Deploying an Ingress resource

1. Deploy the official MS sample application 

```
kubectl apply -f https://raw.githubusercontent.com/Azure/application-gateway-kubernetes-ingress/master/docs/examples/aspnetapp.yaml
```
2.  The above application deploys an aspnet app, service and ingress, run the following command to verify
   ```
     kubectl get ingress
   ```

3. AGIC monitors for ingress resources and automatically creates the following components
  - A new backend pool with http settings for the required port
  - A new rule based on the ingress definition
  - A new path based rule based on the URI of the ingress, in the ingress below, the AGIC will create a path based rule for /empapi to route to the empapi service on port 80

```
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: empapi-ingress
  namespace: apps
spec:
  ingressClassName: azure-application-gateway
  rules:
  - http:
      paths:
      - path: /empapi
        backend:
          service:
            name: empapi
            port:
              number: 80
        pathType: Prefix
```










