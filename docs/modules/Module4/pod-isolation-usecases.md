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
- To **remove** the taint
  ```
  kubectl taint nodes <node_name> disktype=ssd:NoSchedule-
  ```

3. Deploy a pod that has the toleration for the specific Taint
    ```
    kubectl apply -f https://raw.githubusercontent.com/akhan-msft/aks-day2/main/podisolation/tolerated-pod.yaml
    ```

    Specifying a toleration does not mean that a Pod is guaranteed to be deployed to a tainted node, to guarantee this behavior you have to use the Toleration along with Node affinity as shown in the following deployment manifest.

    ```
    kubectl apply -f https://raw.githubusercontent.com/akhan-msft/aks-day2/main/podisolation/taintandaffinity.yaml
    ```

### Node Selector
1. Deploy a pod that **does not** have matching node based on node selector

    ```
    kubectl apply -f https://raw.githubusercontent.com/akhan-msft/aks-day2/main/podisolation/nodeselector-bad.yaml
    ```

    Notice pod will remain in pending state and events displays the message and is very explicit regarding the node selector

2. Deploy a windows container on a windows node pool using the correct node selector

    ```
    kubectl apply -f https://raw.githubusercontent.com/akhan-msft/aks-day2/main/podisolation/windows-container.yaml
    ```

### Pod Anti-affinity and Node-Affinity rules

1. in the following example, we want to deploy pods on separate nodes so that front-end pods and backend pods are on separate nodes, we would use an Po anti-affinity rule for this.

    ```
    kubectl apply -f https://raw.githubusercontent.com/akhan-msft/aks-day2/main/podisolation/pod-antiaffinity.yaml
    ```


2. Subsequently POD anti-affinity rules combined with Node affinity so pods can be deployed to each node of a specific label selector.

    ```
    kubectl apply -f https://raw.githubusercontent.com/akhan-msft/aks-day2/main/podisolation/pod-antiaffinity-nodeaffinity.yaml
    ```



