---
title: Module 5 - Azure Front Door and AKS Integration Architecture
parent:  Module 5 - Azure Front Door and AKS Integration
has_children: false
nav_order: 2
---

## Azure FD + AKS integration architecture

![AGIC architecure](../../assets/images/module5/azfdaks.png)


### Private Endpoints: 
- These are network interfaces within your virtual network that provide secure connectivity between clients and Private Link services.

### Private Link Service: 
- This service exposes your application on AKS to the private endpoint, effectively bringing it into your virtual network.


### Azure Front Door Origin Groups: 
- Origin Groups in Azure Front Door are a collection of one or more origins (endpoints). These groups allow for high availability scenarios and enable you to group different sets of services that are serving the same content. Azure Front Door uses Origin Groups to decide where to route client requests. If one origin in a group is unavailable, Azure Front Door will automatically failover to the next available origin in the group.

### Routes: 
- In Azure Front Door, routes define the rules for how client requests should be routed to the appropriate Origin Group. Each route specifies the accepted HTTP methods, the pattern to match in the URL path, and the forwarding behavior (like URL rewrite or redirect). This allows you to control and manage traffic distribution to your service endpoints, improving performance and availability. Each routing rule is associated with a particular URL path pattern. When a client makes a request to your custom domain, Azure Front Door matches the URL path of the request against the patterns in your routing rules

### Internal Kubernetes Load Balancer: 
- This is used to expose your services within the virtual network. The load balancer is then linked to the Private Link Service.

### Custom Domain: 
- You have a custom domain configured in AFD which is used to access your application. When you configure a custom domain on Azure Front Door, you also define a set of routing rules for that domain. These routing rules are essentially the instructions that tell Azure Front Door how to route traffic for that domain

### Customer Managed SSL/TLS Certificate: 
- This is used in AFD for securing the custom domain. The certificate helps in establishing an encrypted link between AFD and the client.

### Domain Mapping: 
- The root of your custom domain is mapped to the Kubernetes cluster, allowing the application to be accessed via the custom domain.

