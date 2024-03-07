---
title: AKS Nginx Ingress - cert renewals
parent:  Module 6 - AKS Nginx Ingress - cert renewals
has_children: false
nav_order: 1
---

## Azure AKS - Cert Renewal Process

SSL/TLS certificates can be used in a number of AKS cluster integrations, often times, these are at the Edge, meaning at Azure Front Door level or at the AKS cluster edge with either Application Gateway or Ingress controller

- At the global/regional level via **Azure Front Door** (AFD) Level
- At the AKS cluster edge level at the **Ingress controller** level
- At the **Azure Application Gateway** level if that front ends an AKS cluster.


### Cert Renewals at the AKS Edge Ingress Controller level

## Prerequisites

- An operational AKS cluster.
- Nginx Ingress Controller already deployed in your AKS cluster.
- A new or renewed SSL certificate and private key has been obtainer. You must have both the certificate (`cert.pem`) and the private key (`key.pem`) files.

## Steps

### Step 1: Create a Secret with Your SSL Certificate

First, you need to create a Kubernetes secret in the namespace where your Nginx Ingress Controller is deployed. This secret will store your SSL certificate and private key.

```bash
kubectl create secret tls new-ssl-cert --key /path/to/key.pem --cert /path/to/cert.pem -n nginx-ingress
```

### Step 2: Configure Nginx Ingress to Use the New Certificate
To set the newly created secret as the default SSL certificate for the Nginx Ingress Controller, you need to edit the Nginx configuration. This is achieved by modifying the Nginx Ingress Controller deployment or Helm chart values, depending on your deployment method.

```
kubectl edit deployment nginx-ingress-controller -n nginx-ingress
```
Add the following arguments under the spec.template.spec.containers[0].args section:
```
- --default-ssl-certificate=nginx-ingress/new-ssl-cert
```

A completed spec may look like the following

### Step 3: Verify the Configuration
After applying the changes, ensure that the Nginx Ingress Controller is using the new certificate by checking the logs:
```
kubectl logs deployment/nginx-ingress-controller -n nginx-ingress | grep default-ssl-certificate
```

### Step 3b (Optional): Specifying TLS cert at the Ingress resource
Alternatively, specify the TLS attribute within Ingress resource during deployment, this is not ideal but is an option if modifying the default ssl cert is not an option or you need to use a different certificate with a different domain
```bash
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: api-ingress
  namespace: api
  annotations:
    kubernetes.io/ingress.class: "nginx"
    nginx.ingress.kubernetes.io/ssl-redirect: "true"
    nginx.ingress.kubernetes.io/rewrite-target: /$2
spec:
  tls:
  - hosts:
    - k8sdemo.net
    secretName: webapp-tls-secret
  rules:
    - host: 
      http:
        paths:
          - path: /api(/|$)(.*)
            pathType: Prefix
            backend:
              service:
                name: apidemo
                port:
                  number: 80
```




