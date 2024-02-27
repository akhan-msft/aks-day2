---
title: Module 5 - Azure Front Door and AKS Integration Overview
parent:  Module 5 - Azure Front Door and AKS Integration
has_children: false
nav_order: 1
---

## Azure 

### Azure Front Door (AFD): 
- AFD is a scalable and secure entry point for fast delivery of your global applications. It provides global load balancing and site acceleration service for web applications.

![AGIC architecure](../../assets/images/module5/front-door-visual-diagram.png)

### Azure Front Door

- **Global HTTP(S) Load Balancer**: Designed for global load balancing, offering high availability and performance for HTTP(S) applications.
  - Facilitates content delivery from the nearest location to users to reduce latency.
- **Application Acceleration**: Uses edge locations worldwide to cache content close to the users, improving load times.
- **Web Application Firewall (WAF)**: Provides centralized protection of your web applications from common threats and vulnerabilities, across global and regional points of presence.
- **URL-Based Routing**: Routes traffic to different backends based on URL paths.
- **SSL Offloading**: Manages SSL termination at the edge closer to the user, reducing encryption and decryption overhead on the web servers.
- **Session Affinity**: Ensures requests from the same client session are directed to the same backend for consistency.
- **Health Probes**: Automatically checks the health of the backend resources to ensure traffic is only routed to healthy instances.

### Azure Application Gateway

- **Regional HTTP(S) Load Balancer**: Primarily focused on managing web traffic within a region, offering application delivery controller (ADC) as a service.
  - Provides a layer 7 load balancer, which operates at the HTTP level.
- **Web Application Firewall (WAF)**: Offers centralized, in-region protection for web applications from common exploits and vulnerabilities.
- **SSL Termination**: Supports SSL termination at the application gateway, relieving web servers from the encryption and decryption effort.
- **Cookie-Based Session Affinity**: Ensures a client's sessions are preserved with the same backend for the duration of their session.
- **URL-Based Routing and Multiple-Site Hosting**: Allows routing of traffic based on URL paths and the hosting of multiple sites behind a single application gateway.
- **Connection Draining**: Supports graceful removal of backend pool members during planned service updates.
- **Custom Health Probes**: Configurable health probes that monitor the health of the backend servers.

### Summary

- **Scope of Use**: Azure Front Door is best suited for global applications requiring acceleration, high availability, and scalability across the globe. Azure Application Gateway is more suited for applications that require complex load balancing features, WAF protection, and SSL termination within a single region.
- **Performance and Scalability**: Front Door provides edge locations worldwide for content caching and faster delivery, while Application Gateway offers fine-grained control over traffic within a region.
- **Security**: Both offer WAF capabilities, but Front Door's is designed for global protection, while Application Gateway's focus is on regional traffic.
- **Cost**: The cost can vary based on the features used, with Front Door potentially incurring higher costs for global reach and Application Gateway costs depending on the number of features and scale within a region.

Choosing between Azure Front Door and Azure Application Gateway depends on the specific requirements of your application, such as global distribution and user base, the need for application acceleration, security requirements, and architectural complexity.
