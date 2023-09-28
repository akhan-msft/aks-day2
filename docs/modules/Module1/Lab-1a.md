---
title: CrashLoopBackOff
parent:  Module 1 - AKS Day 2
has_children: false
nav_order: 1
---

# Topic 1: Understanding and troubleshooting CrashLoopBackOff

A CrashLoopBackOff status in a Kubernetes cluster means that a Container is failing to start, and is therefore being restarted repeatedly. There can be numerous reasons why this might happen. Below are some common reasons that may cause the 

## Understanding & Troubleshooting CrashLoopBackOff errors

### Common troubleshooting flow diagram

   ![CLBO flowchart](../../assets/images/module2/CrashLoopBackOff.png)


- **Configuration Errors:**
  - Incorrect command or arguments specified in the container spec.
  - Configuration file errors for the application running inside the container.

- **Resource Constraints:**
  - Insufficient CPU or Memory allocated to the pod.
  - Resource Quota Exhaustion: The pod may be attempting to use more resources than allowed.
  ```shell
      kubectl apply -f crashloopbackoff/deployments/deployment-oom.yaml
  ```

- **Image Issues:**
  - The specified image does not exist or is inaccessible.
  - Image pull errors due to incorrect image pull policy, incorrect credentials, or network issues.
  
- **Application Errors:**
  - Application inside the container is crashing due to errors or panics.
  - Application is exiting immediately after startup due to issues like missing dependencies.
  
- **Dependency Issues:**
  - Required services or endpoints are not accessible or are down, causing the container's process to fail.
  - Missing or inaccessible volumes or configuration maps that are essential for the container.

- **Permission Issues:**
  - The container is trying to perform actions it does not have permission for, leading to failure.
  - Incorrect Security Context or Service Account associated with the pod.

- **Liveness/Readiness Probes Failure:**
  - Misconfigured or overly aggressive liveness/readiness probes causing the container to be killed and restarted.

- **Network Issues:**
  - Misconfigured network policies preventing the application from accessing needed resources.
  - Issues with the cluster network plugins or configuration.

- **Corrupted Container Runtime:**
  - Issues with the container runtime can lead to the inability to start containers properly.

- **Node Issues:**
  - Issues with the Node itself, such as disk pressure, could indirectly cause containers to enter `CrashLoopBackOff` status.

- **Quota and Limit Issues:**
  - Exceeding CPU/Memory limits, leading to the termination of containers.
  - Hitting File descriptor limits.

- **Kernel Issues:**
  - Kernel panics or errors affecting the operation of containers.
  
