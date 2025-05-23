param location string = resourceGroup().location
param gatewayName string
param aksName string
param appGateway_id string
param appGateway_name string
param appgw_cidr string


resource aks 'Microsoft.ContainerService/managedClusters@2021-05-01' existing = {
  name: aksName
}

resource ingressApplicationGatewayaddon 'Microsoft.ContainerService/managedClusters/addonProfiles@2022-01-01' = {
  name: 'ingressApplicationGateway'
  parent: aks
  properties: {
    enabled: true
    config: {
      applicationGatewayName:appGateway_name
      effectiveApplicationGatewayId: appGateway_id
      subnetCIDR:appgw_cidr
    }
  }
}

// resource appRoutingApplicationGatewayaddon 'Microsoft.ContainerService/managedClusters/addonProfiles@2022-01-01' = {
//   name: 'httpApplicationRouting'
//   parent: aks
//   properties: {
//     enabled: true
//   }
// }
