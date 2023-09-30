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

  This first example illustrates a command overide in the deployment yaml that is incorrect even though the cmd/entrypoint in the Docker file is correct
  ```shell
  kubectl apply -f .\crashloopbackoff\deployments\deployment-bad-cmd.yaml              
  ```
  ![bad command](../../assets/images/module2/bad-command-screenshot1.png)

  ![bad command](../../assets/images/module2/bad-command-screenshot3.png)


  This second example is an application config issue, the application starts and then fails because on injection because of an invalid resource configuration.

   ```shell
   kubectl apply -f .\crashloopbackoff\deployments\deployment-invalid-app-config.yaml
   ```
   ![bad command](../../assets/images/module2/invalid-app-config1.png)

   ![bad command](../../assets/images/module2/invalid-app-config2.png)

   ![bad command](../../assets/images/module2/invalid-app-config3.png)

- **Resource Constraints:**
  - Insufficient CPU or Memory allocated to the pod.
  - Resource Quota Exhaustion: The pod may be attempting to use more resources than allowed.

  ```shell
      kubectl apply -f crashloopbackoff/deployments/deployment-oom.yaml
  ```
  ![bad command](../../assets/images/module2/)
        
- **Image Issues:**
  - The specified image does not exist or is inaccessible.
  - Image pull errors due to incorrect image pull policy, incorrect credentials, or network issues.
  
- **Application Errors:**
  - Application inside the container is crashing due to errors or panics.
  - Application is exiting immediately after startup due to issues like missing dependencies.

  ```shell
   kubectl apply -f .\crashloopbackoff\deployments\deployment-invalid-app-config.yaml
  ```
  
- **Dependency Issues:**
  - Required services or endpoints are not accessible or are down, causing the container's process to fail.
  - Missing or inaccessible volumes or configuration maps that are essential for the container.

- **Permission Issues:**
  - The container is trying to perform actions it does not have permission for, leading to failure.
  - Incorrect Security Context or Service Account associated with the pod.

  ```shell
     kubectl apply -f .\crashloopbackoff\deployments\deployment-invalid-user.yaml
  ```

- **Liveness/Readiness Probes Failure:**
  - Misconfigured or overly aggressive liveness/readiness probes causing the container to be killed and restarted.

  ```shell
   kubectl apply -f .\crashloopbackoff\deployments\deployment-failure-probe.yaml 
  ```

  ![bad command](../../assets/images/module2/failure_probe-1.png)

  ![bad command](../../assets/images/module2/failure_probe-2.png)

  ![bad command](../../assets/images/module2/failure_probe-3.png)

- **Node Issues:**
  - Issues with the Node itself, such as disk pressure, could indirectly cause containers to enter `CrashLoopBackOff` status.

- **Quota and Limit Issues:**
  - Exceeding CPU/Memory limits, leading to the termination of containers.
  - Hitting File descriptor limits.


  
