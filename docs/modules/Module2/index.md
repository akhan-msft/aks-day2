---
title: Module 2 - Azure Managed Prometheus and Grafana
has_children: true
---

## Module 2 - Introduction to Azure Managed Prometheus and Grafana

Azure Kubernetes Service (AKS) is a powerful service offered by Microsoft Azure that simplifies the deployment, management, and scaling of containerized applications using Kubernetes. As more organizations leverage AKS to deploy their applications, it’s crucial for support engineers to acquire proficiency in addressing common challenges and issues that might arise during the operational phase or "Day 2" of AKS usage. This workshop will delve deep into common Day 2 issues, focusing on solving problems related to CrashLoopBackOff states, troubleshooting Azure Container Registry (ACR) access issues, and resolving Azure Front Door (AFD) integration issues with AKS. Gaining insights into these areas will empower support engineers to ensure seamless operation and maintenance of containerized applications on AKS.

## Azure Managed Prometheus

The CrashLoopBackOff state is a common issue in Kubernetes that occurs when a container fails to start, leading to repeated attempts and failures. We will explore the underlying causes of CrashLoopBackOff states, such as configuration errors, resource constraints, and application bugs. Participants will learn effective troubleshooting methodologies, how to access and interpret logs, and derive actionable insights to rectify the issues causing containers to enter this state.


## Azure Managed Grafana

Azure Container Registry is pivotal for storing and managing container images, but access issues can disrupt the deployment flow. This segment will cover common ACR access problems such as authentication failures, network policies, and permission issues. Attendees will gain knowledge on diagnosing and resolving these issues, ensuring smooth and secure access to container images. A nuanced understanding of ACR's integration with AKS will be instrumental in optimizing the container lifecycle management processes.

## Azure Front Door (AFD) Common Integration Issues with AKS:

Azure Front Door offers a scalable and secure entry point for fast delivery of web applications, but integrating it with AKS can pose several challenges. This part of the workshop will focus on common integration issues like routing problems, SSL/TLS configuration errors, and application firewall setup. By addressing these issues, participants will learn to streamline the integration of AFD with AKS, ensuring the efficient delivery and enhanced security of web applications deployed in AKS.

## Prerequisites

This workshop will not only furnish support engineers with the knowledge to troubleshoot and resolve common AKS Day 2 issues but also provide hands-on experience and insights to preemptively address potential challenges, improving overall service reliability and user satisfaction. The sample deployment manifests will work on any Kubernetes cluster including local installations, note : sections 2/3 are core Azure services and require an AKS cluster for integration purposes.

1. BYOK (Bring your own Kubernetes cluster)
2. Text Editor (Visual Studio Code)
3. Kubectl client CLI
4. Git client