---
title: Kubernetes POD Isolation use cases
parent:  Module 4 - Pod Isolation Strategies
has_children: false
nav_order: 2
---


### Taints & Tolerations

1. Taint the node/s
```
    kubectl taint nodes aks-agentpool-24727981-vmss000000 disktype=ssd:NoSchedule
```

2. Deploy a pod that has the toleration
```
apiVersion: v1
kind: Pod
metadata:
  name: mypod-tolerations
spec:
  containers:
  - name: mycontainer
    image: nginx
  tolerations:
  - key: "disktype"
    operator: "Equal"
    value: "ssd"
    effect: "NoSchedule"
````

3. Deploy pod that does not have matching node based on node selector

```
apiVersion: v1
kind: Pod
metadata:
  name: nspod
spec:
  containers:
  - name: nscontainer
    image: nginx
  nodeSelector:
    disktype: bogusssd
```

Notice pod will remain in pending state and events displays the message and is very explicit regarding the node selector

   