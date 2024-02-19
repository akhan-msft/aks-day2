---
title: Kubernetes POD Isolation Strategies
parent:  Module 4 - Pod Isolation Strategies
has_children: false
nav_order: 1
---

# Topic 1: POD isolation strategies

In Kubernetes and Azure Kubernetes Service (AKS), you can pin a pod to a specific node or node pool using various scheduling features. Here's a bulleted list of the different ways you can achieve this:


## Understanding AGIC Architecure and core components

### NodeSelector:

- Use nodeSelector in your pod specification to constrain a pod to nodes with specific labels. This is a simple way to schedule pods on nodes with particular labels.

### Affinity and Anti-Affinity:

- Leverage affinity to specify rules that allow you to constrain which nodes your pod is eligible to be scheduled on, based on labels on nodes and other conditions.
It includes both nodeAffinity (which is similar to nodeSelector but with more expressive options) and podAffinity/podAntiAffinity (which allows you to define rules about how pods should be scheduled relative to other pods).

### Taints and Tolerations:

- Use taints on nodes and tolerations on pods. A taint allows a node to repel a set of pods unless those pods tolerate the taint, enabling you to dedicate nodes for specific pods.

### Node Pools 

- When using AKS, you can create node pools with specific characteristics (e.g., CPU, memory, GPU) and use nodeSelector, affinity, or taints and tolerations to schedule pods on these specific node pools.

### Manual Scheduling:
- Directly assign a pod to a specific node by setting the .spec.nodeName in the pod's configuration. This bypasses the scheduler to place the pod on a specified node, but it's generally not recommended for most use cases due to its lack of flexibility.

### DaemonSets:

- While not exactly pinning a single pod to a node, DaemonSets ensure that a copy of a pod runs on all or some nodes in the cluster. By using nodeSelector in the DaemonSet spec, you can control on which nodes the DaemonSet pods are scheduled.

