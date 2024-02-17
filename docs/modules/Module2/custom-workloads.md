---
title: Custom workloads & Troubleshooting
parent:  Module 2 - AKS Day 2
has_children: false
nav_order: 3
---

## Scraping metrics from Custom Workloads

By default, managed prometheus only scrapes certain core Kubernetes metrics only such as node and other, in order to measure metrics from a specific workload or other core control plane elements, you need to modify the config map for prometheus

## Changes required to support scraping for a speccific application/container

1. Modify the application to expose Prometheus metrics via an HTTP endpoint, most runtime support Prometheus client libraries to enable this seamlessly

2. Modify the deployment.yaml for the application workload and include the required annotations, the following is an example of an application that exposes its metrics at /actuator/prometheus endpoint on port 80

    ```
   annotations:
      prometheus.io/scrape: 'true'
      prometheus.io/path: '/actuator/prometheus'
      prometheus.io/port: '80'
    ```
3. Modify the prometheus config-map to ensure that pod scraping is enabled, it is **disabled** by default, in the following example, we are only scraping pods in the **apps** namespace

    ```
    # Use '.*' to scrape all namespaces of annotated pods.
    pod-annotation-based-scraping: |-
      podannotationnamespaceregex = "apps"
    ```
4. Validate the metrics are being exposed correctly, you can query using the prometheus or grafana explorer

```
   http_server_requests_seconds_count{exception="None",method="GET",outcome="SUCCESS",status="200",uri="/actuator/prometheus"}
```

# Topic 2: Troubleshooting