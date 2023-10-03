---
title: Azure Container Registry (ACR) and AKS access issues
parent:  Module 1 - AKS Day 2
has_children: false
nav_order: 2
---

# Topic 2. Azure ACR Access/Authentication Issues with Azure AKS Cluster
Azure Container Registry (ACR) and Azure Kubernetes Service (AKS) integration could face various access/authentication issues, primarily due to misconfigurations, expired credentials, lack of permissions, or network restrictions. Below is a markdown list detailing these potential challenges:

### Understanding AKS, ACR integration and Managed Identities

Newer AKS provisioned clusters use Azure AD Managed identities by default.

   ![acr identity](../../assets/images/module2/acr-managed-identites.png)

### Common troubleshooting steps for ErrImagePull errors

The following is a simple flowchart/guide to help troubleshooting ErrImagePull & ErrImagePullBackOff errors for a deployed POD

   ![acr identity](../../assets/images/module2/ErrImagePullBackOff.png)

- **ACR and AKS Configuration:**
  - **Misconfigurations:** Incorrect configuration of ACR or AKS can prevent them from integrating successfully.
 
   **Sample 1 - Disconnected ACR** Test an image pull from an ACR in the same subscription but disconnected from the AKS cluster

   Use the following command to disconnect an ACR from an AKS cluster
   ```shell
   az aks update -n myAKSCluster -g myResourceGroup --detach-acr <acr-name>
   ```
   
   Deploy an application from the disconnected ACR
   ```shell
   kubectl apply -f .\errimagepull\deployment-acr-not-connected.yaml   
   ```
    ![acr identity](../../assets/images/module2/disconnected-acr1.png)
    **kubectl describe pod** shows an ErrImagePull error occurs with a HTTP **401 Unauthorized Error**
    ![acr identity](../../assets/images/module2/disconnected-acr2.png)

    The following az cli command is very useful for checking and validating connection configuration between ACR and an AKS cluster and a rule should be used to test for missing roles and integrations.

    ```
   az aks check-acr --name <<AKS_CLUSTER_NAME>> --resource-group <<RESOURCE_GRP_NAME>> --acr <<ACR_ID>>
    ```
   ![acr identity](../../assets/images/module2/disconnected-acr3-check.png)

   The following command can subsequently used to explicitly attach an ACR to an AKS cluster, **note** multiple ACR's can be attached to a single AKS cluster.

   ```
   az aks update -n <<AKS_CLUSTER_NAME>> -g <<RESOURCE_GRP_NAME>> --attach-acr <<ACR_ID>>
   ```

   - **Incorrect Image References:** Incorrect or non-existent image tags and references will lead to failures in pulling images from ACR. These errors can be generic and sometimes misleading.

   **Sample 2 - incorrect image Tag** Test a deployment from a valid ACR but incorrect image tag for an application

   ```shell
   kubectl apply -f .\errimagepull\deployment-acr-invalid-image.yaml   
   ```
   ![invalid-image](../../assets/images/module2/acr-invalid-img-tag1.png)

   note: **kubectl describe** pod still shows the 401 Unauthorized error which is somewhat misleading in this case, pay attention to the RPC Error Code which shows **NotFound**
   ![invalid-image](../../assets/images/module2/acr-invalid-img-tag2.png)

- **Service Principal Issues:**
  - **Expiration:** Service Principals have an expiration date, post which they are unable to authenticate.
  - **Insufficient Permissions:** If the Service Principal doesn't have adequate permissions to access ACR, it will fail to pull images.
  - **Deletion or Disabling:** Deleted or disabled Service Principals result in authentication failure.

- **Managed Identity Issues:**
  - **Scope of Assignment:** Managed Identities may not have the correct scope of assignment, i.e., not assigned at the correct level (Subscription, Resource Group, Resource) to have access to the ACR.
  - **Role Assignment:** Lack of or incorrect role assignment, such as lacking AcrPull (or higher) role, can prevent pulling images.
  - **Misconfigurations:** Incorrectly configured managed identities can lead to access issues between ACR and AKS.

- **RBAC Roles:**
  - **Lack of Appropriate Roles:** Not having appropriate roles assigned, like `AcrPull` to pull images or `AcrPush` to push images, will result in access denial.
  - **Role Assignment Level:** Incorrect level of role assignment (Resource, Resource Group, Subscription) can also lead to issues.
  - **Multiple Roles Conflict:** Having multiple conflicting roles assigned can cause unexpected behavior.

 **Sample 3 - Missing Role**  This exercise Simulates an Access role issue by explicitly removing the **AcrPull** role from the Kubelet's Managed Identity account. Note: for new AKS clusters, this is enabled/set when the ACR is associated to the AKS cluster.

   ```
   az role assignment delete --assignee 617dcb03-43e1-435f-93ac-6fd109cc4a21 --role AcrPull --scope /subscriptions/ae5cd0d7-0de7-46fc-98ed-73428e2bdd5b/resourceGroups/k8s-tech-brief-rg/providers/Microsoft.ContainerRegistry/registries/akhanregistry
   ```
   
``` shell
kubectl apply -f .\errimagepull\deployment-midentity-missing-role.yaml
```

- Observe the results by examining the POD's description (Kubectl describe POD <<pod_name>>)
 ![invalid-role](../../assets/images/module2/midentity-missing-role1.png)
- We observe the events in the POD description by doing a Kubectl describe command.The ErrImagePull error results in a **401 Unauthorized** error message which is expected as the managed identity does not have the right ACR privileges. 
 ![invalid-role](../../assets/images/module2/midentity-missing-role2.png)
 

- **Network Policies and Firewalls:**
  - **Network Restrictions:** AKS and ACR may be in different networks or subnets with no access to each other.
  - **Firewall Rules:** Strict firewall rules may block the traffic between AKS and ACR.
  - **Private Link Issues:** Misconfigurations or issues with Private Link setup can prevent access to ACR.

- **External Private Registries:**
  - **Authentication Issues:** Incorrect credentials, token expiry, or other authentication mechanisms can lead to failure in accessing external private registries.
  - **Network Accessibility:** External registries might be unreachable due to network policies, firewalls, or other network-related issues.
  - **Permissions and Roles:** External registries might require specific permissions or roles that, if not configured properly, can prevent access to the required resources.

 #### Try to deploy workload from an external private Docker Hub registry
 ```shell
 kubectl apply -f .\errimagepull\deployment-private-registry.yaml
 ```
 The deployment fails with an ErrImagePull, we see the error in the POD description

 - Observe the results
 ![invalid-role](../../assets/images/module2/private-repo1.png)

 - To resolve the issue, uncomment the imagePullSecrets section in the deployment.yaml and redeploy.
   ```
      containers:
      - name: main
        imagePullPolicy: Always
        image: akhan2017/nginx
       registry
      imagePullSecrets:
      - name: dockerhubcred
   ```

### Recommended Practices
- Regularly review and renew Service Principals and Managed Identities.
- Assign minimum necessary permissions and regularly audit roles and permissions.
- Properly configure network policies, firewall rules, and Private Links.
- Regularly validate the configuration and access between AKS and ACR.

Remember that resolving access and authentication issues typically involves examining the Kubernetes events and logs, validating the configurations, permissions, and network connectivity, and addressing any identified discrepancies or issues.

### Useful references for ACR authentication issues
[Troubleshoot Registry login](https://learn.microsoft.com/en-us/azure/container-registry/container-registry-troubleshoot-login)

[Troubleshoot ACR network issues](https://learn.microsoft.com/en-us/azure/container-registry/container-registry-troubleshoot-access)

[Monitor ACR (logs & Metrics)](https://learn.microsoft.com/en-us/azure/container-registry/monitor-service)
