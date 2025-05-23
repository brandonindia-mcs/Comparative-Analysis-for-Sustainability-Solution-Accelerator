// Copyright (c) Microsoft Corporation.
// Licensed under the MIT license.

targetScope = 'subscription'

@maxLength(8)
param resourceprefix string = 'defltesg'
param appname string = 'esgdocanalysis'
param node_resource_group string = 'MC_rgesgdocanalysisdefltesg_aksesgdocanalysisdefltesg_swedencentral'
param aks_resource_group string = 'rgesgdocanalysisdefltesg'
param gateway string = 'gwesgdocanalysisdefltesg'
param aks string = 'aksesgdocanalysisdefltesg'
param cidr string = '10.226.0.0/24'


resource gs_resourcegroup 'Microsoft.Resources/resourceGroups@2021-04-01' existing = {
  name: aks_resource_group
}
resource rg_aks_worker 'Microsoft.Resources/resourceGroups@2021-04-01' existing = {
  name: node_resource_group
}

// /*
module gs_appgw 'modules/appgwaddon.bicep' = {
  name: 'aksaddon-${appname}-${resourceprefix}'
  scope: gs_resourcegroup
  params: {
    aksName:aks
    appGateway_id:appGateway.id
    appGateway_name:appGateway.name
    appgw_cidr:cidr
    gatewayName:gateway
  }
}

resource appGateway 'Microsoft.Network/applicationGateways@2021-02-01' existing = {
  name:gateway
  scope:resourceGroup(rg_aks_worker.name)
}
// /*
