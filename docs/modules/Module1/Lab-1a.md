---
title: CrashLoopBackOff
parent:  Module 1 - AKS Day 2
has_children: false
nav_order: 1
---

# Topic 1: Understanding and troubleshooting CrashLoopBackOff

A CrashLoopBackOff status in a Kubernetes cluster means that a Container is failing to start, and is therefore being restarted repeatedly. There can be numerous reasons why this might happen. Below are some common reasons that may cause this error

## Understanding & Troubleshooting CrashLoopBackOff errors

### Understanding POD & container states

![pod-states](../../assets/images/module2/pod-states.png)

1. Kube scheduler controller schedules for the pods to be run on a specific nodes/s
2. Kubelet agent on the node pulls the image from the image registry and creates the pod
3. The POD container starts based on the specific command provided in the deployment/pod specifications. The POD starts running
4. After running or during initilization an error occurs and the pod goes into an error or failed state
5. The Kubelet agent starts the container again because the restart policy on a deployment is always set to "always", after a few attempts of this process, pos goes into a CrashLoopBackOff state with every rum the backoff time limit increases to a maximum of 5 minutes.

### Common troubleshooting steps for CrashLoopBackOff

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


- **Resource Constraints:**
  - Insufficient CPU or Memory allocated to the pod.
  - Resource Quota Exhaustion: The pod may be attempting to use more resources than allowed.

  ```shell
      kubectl apply -f crashloopbackoff/deployments/deployment-oom.yaml
  ```
  ![oom-killed](../../assets/images/module2/oom-killed.png)
        

- **Application Errors:**
  - Application inside the container is crashing due to errors or panics.
  - Application is exiting immediately after startup due to issues like missing dependencies.

- **Application Dependency Issues:**
  - Required services or endpoints are not accessible or are down, causing the container's process to fail.

  ```shell
   kubectl apply -f .\crashloopbackoff\deployments\deployment-invalid-app-config.yaml
  ```
  This example is an application config issue, the application starts and then fails because a required dependency injection fails because of an invalid backend resource configuration.

   ```shell
   kubectl apply -f .\crashloopbackoff\deployments\deployment-invalid-app-config.yaml
   ```

   ![bad command](../../assets/images/module2/invalid-app-config1.png)

   ![bad command](../../assets/images/module2/invalid-app-config2.png)

   ![bad command](../../assets/images/module2/invalid-app-config3.png)


- **Permission Issues:**
  - The container is trying to perform actions it does not have permission for, leading to failure.
  - Incorrect Security Context or Service Account associated with the pod.
 
  The following sample is trying to run the container as a user that does not exist
  ```shell
     kubectl apply -f .\crashloopbackoff\deployments\deployment-invalid-user.yaml
  ```

  ![bad command](../../assets/images/module2/invalid-user1.png)

  ![bad command](../../assets/images/module2/invalid-user2.png)

- **Liveness/Readiness Probes Failure:**
  - Misconfigured or overly aggressive liveness/readiness probes causing the container to be killed and restarted.

  ```shell
   kubectl apply -f .\crashloopbackoff\deployments\deployment-failure-probe.yaml 
  ```

  ![bad command](../../assets/images/module2/failure_probe-1.png)

  ![bad command](../../assets/images/module2/failure_probe-2.png)

  ![bad command](../../assets/images/module2/failure_probe-3.png)

These are unlikely but possible

- **Node Issues:**
  - Issues with the Node itself, such as disk pressure, could indirectly cause containers to enter `CrashLoopBackOff` status.

- **Quota and Limit Issues:**
  - Exceeding CPU/Memory limits, leading to the termination of containers.
  - Hitting File descriptor limits.


  
