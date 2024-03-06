---
title: POD Isolation samples
parent:  Module 4 - Pod Isolation Strategies
has_children: false
nav_order: 2
---


### Taints & Tolerations

1. Get all the Taints in your AKS cluster nodes

  ```
    kubectl get nodes -o custom-columns=NAME:.metadata.name,TAINTS:.spec.taints --no-headers
  ```

2. Taint a specific node/s
```
    kubectl taint nodes <node_name> disktype=ssd:NoSchedule
```
- To remove the taint
```
  kubectl taint nodes <node_name> disktype=ssd:NoSchedule-
```

3. Deploy a pod that has the toleration for the specific Taint
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


### Node Selector
1. Deploy pod that does not have matching node based on node selector

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

2. Deploy a windows container on a windows node pool

```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: sample
  labels:
    app: sample
spec:
  replicas: 1
  template:
    metadata:
      name: sample
      labels:
        app: sample
    spec:
      nodeSelector:
        "kubernetes.io/os": windows
      containers:
      - name: sample
        image: mcr.microsoft.com/dotnet/framework/samples:aspnetapp
        resources:
          limits:
            cpu: 1
            memory: 800M
        ports:
          - containerPort: 80
```

### Pod Anti-affinity and Affinity rules

1. in the following example, we want to deploy pods on separate nodes so that front-end pods and backend pods are on separate nodes, we would use an anti affinity rule for this.

```
apiVersion: apps/v1
kind: Deployment
metadata:
  name: front-end
  labels:
    app: front-end
spec:
  replicas: 1
  selector:
    matchLabels:
      app: front-end
  template:
    metadata:
      labels:
        app: front-end
    spec:
      containers:
      - name: nginxfe
        image: nginx:latest
      affinity:
        podAntiAffinity:
          requiredDuringSchedulingIgnoredDuringExecution:
          - labelSelector:
              matchExpressions:
              - key: app
                operator: In
                values:
                - back-end
            topologyKey: "kubernetes.io/hostname"
---
apiVersion: apps/v1
kind: Deployment
metadata:
  name: back-end
  labels:
    app: back-end
spec:
  replicas: 1
  selector:
    matchLabels:
      app: back-end
  template:
    metadata:
      labels:
        app: back-end
    spec:
      containers:
      - name: nginxbe
        image: nginx:latest
      affinity:
        podAntiAffinity:
          requiredDuringSchedulingIgnoredDuringExecution:
          - labelSelector:
              matchExpressions:
              - key: app
                operator: In
                values:
                - front-end
            topologyKey: "kubernetes.io/hostname"


```
2. Subsequently POD affinity rules can be used to make pods co-exist next to each other.

```
  affinity:
    podAffinity:
      requiredDuringSchedulingIgnoredDuringExecution:
      - labelSelector:
          matchLabels:
            app: app-a
        topologyKey: "kubernetes.io/hostname"
```


