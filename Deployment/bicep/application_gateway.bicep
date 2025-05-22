// Copyright (c) Microsoft Corporation.
// Licensed under the MIT license.

targetScope = 'subscription'

@maxLength(8)
param resourceprefix string
param appname string
param node_resource_group string
param cidr string
param vnet string
param subnet string

resource gs_noderesourcegroup 'Microsoft.Resources/resourceGroups@2021-04-01' existing = {
  name: node_resource_group
}


// Application Gateway
// /*
module gs_applicationgateway 'modules/azureapplicationgateway.bicep' = {
  name: 'gw${appname}${resourceprefix}'
  scope: gs_noderesourcegroup
  params: {
    gateway_name: 'gw${appname}${resourceprefix}'
    vnet_name: vnet
    appgw_cidr: cidr
    app_gateway_subnet_name: subnet
  }
}
// */
