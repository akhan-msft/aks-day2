---
title: Azure Container Registry (ACR) and AKS access issues
parent:  Module 1 - AKS Day 2
has_children: false
nav_order: 2
---

# Azure ACR Access/Authentication Issues with Azure AKS Cluster
Azure Container Registry (ACR) and Azure Kubernetes Service (AKS) integration could face various access/authentication issues, primarily due to misconfigurations, expired credentials, lack of permissions, or network restrictions. Below is a markdown list detailing these potential challenges:

### Common troubleshooting flow diagram

    ![Synk folders](../../assets/images/module2/ACR%20Managed%20identites.png)


- **Service Principal Issues:**
  - **Expiration:** Service Principals have an expiration date, post which they are unable to authenticate.
  - **Insufficient Permissions:** If the Service Principal doesn't have adequate permissions to access ACR, it will fail to pull images.
  - **Deletion or Disabling:** Deleted or disabled Service Principals result in authentication failure.
  - **Incorrect Assignment:** Service Principals assigned to the wrong ACR or AKS may face access issues.

- **Managed Identity Issues:**
  - **Scope of Assignment:** Managed Identities may not have the correct scope of assignment, i.e., not assigned at the correct level (Subscription, Resource Group, Resource) to have access to the ACR.
  - **Role Assignment:** Lack of or incorrect role assignment, such as lacking AcrPull (or higher) role, can prevent pulling images.
  - **Misconfigurations:** Incorrectly configured managed identities can lead to access issues between ACR and AKS.

- **RBAC Roles:**
  - **Lack of Appropriate Roles:** Not having appropriate roles assigned, like `AcrPull` to pull images or `AcrPush` to push images, will result in access denial.
  - **Role Assignment Level:** Incorrect level of role assignment (Resource, Resource Group, Subscription) can also lead to issues.
  - **Multiple Roles Conflict:** Having multiple conflicting roles assigned can cause unexpected behavior.

- **Network Policies and Firewalls:**
  - **Network Restrictions:** AKS and ACR may be in different networks or subnets with no access to each other.
  - **Firewall Rules:** Strict firewall rules may block the traffic between AKS and ACR.
  - **Private Link Issues:** Misconfigurations or issues with Private Link setup can prevent access to ACR.

- **External Private Registries:**
  - **Authentication Issues:** Incorrect credentials, token expiry, or other authentication mechanisms can lead to failure in accessing external private registries.
  - **Network Accessibility:** External registries might be unreachable due to network policies, firewalls, or other network-related issues.
  - **Permissions and Roles:** External registries might require specific permissions or roles that, if not configured properly, can prevent access to the required resources.

- **ACR and AKS Configuration:**
  - **Misconfigurations:** Incorrect configuration of ACR or AKS can prevent them from interacting successfully.
  - **Mismatched API Versions:** API version mismatch between AKS and ACR can lead to integration failures.
  - **Incorrect Image References:** Incorrect or non-existent image tags and references will lead to failures in pulling images from ACR.

### Recommended Practices
- Regularly review and renew Service Principals and Managed Identities.
- Assign minimum necessary permissions and regularly audit roles and permissions.
- Properly configure network policies, firewall rules, and Private Links.
- Regularly validate the configuration and access between AKS and ACR.

Remember that resolving access and authentication issues typically involves examining the Kubernetes events and logs, validating the configurations, permissions, and network connectivity, and addressing any identified discrepancies or issues.

