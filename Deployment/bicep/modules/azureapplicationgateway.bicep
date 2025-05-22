
param location string = resourceGroup().location
param gateway_name string
param vnet_name string
param app_gateway_subnet_name string
param appgw_cidr string

resource vnet 'Microsoft.Network/virtualNetworks@2021-02-01' existing = {
  name: vnet_name
}

resource subnet 'Microsoft.Network/virtualNetworks/subnets@2024-05-01' = {
  parent:vnet
  name:app_gateway_subnet_name
    properties: {
      addressPrefix: appgw_cidr
    }
}

resource appGwPublicIp 'Microsoft.Network/publicIPAddresses@2022-09-01' = {
  name: '${gateway_name}ip'
  location: location
  sku: {
    name: 'Standard'
  }
  properties: {
    publicIPAllocationMethod: 'Static'
  }
}

resource appGateway 'Microsoft.Network/applicationGateways@2021-02-01' = {
  name: gateway_name
  location: location
  properties: {
    sku: {
      name: 'Standard_v2'
      tier: 'Standard_v2'
      capacity: 2
    }
    gatewayIPConfigurations: [
      {
        name: 'appGatewayIpConfig'
        properties: {
          subnet: {
            id: subnet.id
          }
        }
      }
    ]
    frontendIPConfigurations: [
      {
        name: 'appGwFrontendIp'
        properties: {
          publicIPAddress: {
            id: appGwPublicIp.id
          }
        }
      }
    ]
    frontendPorts: [
      {
        name: 'http_port'
        properties: {
          port: 80
        }
      }
      {
        name: 'https_port'
        properties: {
          port: 443
        }
      }
    ]
    sslCertificates: [
      {
        name: 'appGwSslCert'
        properties: {
          data: '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'
          password: 'YourPassword123'
        }
      }
    ]
    backendAddressPools: [
      {
        name: 'appGatewayBackendPool'
      }
    ]
    backendHttpSettingsCollection: [
      {
        name: 'appGatewayBackendHttpSettings'
        properties: {
          port: 80
          protocol: 'Http'
          cookieBasedAffinity: 'Disabled'
          requestTimeout: 20
        }
      }
    ]
    httpListeners: [
      {
        name: 'appGatewayHttpListener'
        properties: {
          frontendIPConfiguration: {
            id: resourceId('Microsoft.Network/applicationGateways/frontendIPConfigurations', gateway_name, 'appGwFrontendIp')
          }
          frontendPort: {
            id: resourceId('Microsoft.Network/applicationGateways/frontendPorts', gateway_name, 'https_port')
          }
          sslCertificate: {
            id: resourceId('Microsoft.Network/applicationGateways/sslCertificates', gateway_name, 'appGwSslCert')
          }
          protocol: 'Https'
          requireServerNameIndication: false
        }
      }
    ]
    requestRoutingRules: [
      {
        name: 'appGwRoutingRule'
        properties: {
          ruleType: 'Basic'
          priority: 10010
          httpListener: {
            id: resourceId('Microsoft.Network/applicationGateways/httpListeners', gateway_name, 'appGatewayHttpListener')
          }
          backendAddressPool: {
            id: resourceId('Microsoft.Network/applicationGateways/backendAddressPools', gateway_name, 'appGatewayBackendPool')
          }
          backendHttpSettings: {
            id: resourceId('Microsoft.Network/applicationGateways/backendHttpSettingsCollection', gateway_name, 'appGatewayBackendHttpSettings')
          }
        }
      }
    ]
  }
}
