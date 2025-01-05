@description('Name of the AKS cluster')
param clusterName string = 'demoakscluster'

@description('Number of nodes in the system node pool')
param nodeCount int = 1

@description('Kubernetes version')
param kubernetesVersion string = '1.30.6'

targetScope = 'resourceGroup'

resource aks 'Microsoft.ContainerService/managedClusters@2023-03-01' = {
  name: clusterName
  location: resourceGroup().location
  sku: {
    name: 'Base'
    tier: 'Free'
  }
  properties: {
    kubernetesVersion: kubernetesVersion
    dnsPrefix: clusterName
    agentPoolProfiles: [
      {
        name: 'systempool'
        mode: 'System'
        count: nodeCount
        vmSize: 'Standard_DS2_v2'
        osType: 'Linux'
        osSKU: 'Ubuntu'
        type: 'VirtualMachineScaleSets'
      }
    ]
    networkProfile: {
      networkPlugin: 'azure'
      loadBalancerSku: 'standard'
    }
  }
  identity: {
    type: 'SystemAssigned'
  }
}
