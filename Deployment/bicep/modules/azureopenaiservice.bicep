// Copyright (c) Microsoft Corporation.
// Licensed under the MIT license.

param openAIServiceName string
param location string = resourceGroup().location

resource openAIService 'Microsoft.CognitiveServices/accounts@2024-10-01' = {
  name: openAIServiceName
  location: location
  kind: 'OpenAI'
  sku: {
    name: 'S0'
  }
  properties: {
    // Add any specific properties if needed
  }
}

output openAIServiceId string = openAIService.id
output openAIServiceName string = openAIService.name
output openAIServiceEndpoint string = openAIService.properties.endpoint
output oopenAIServiceLocation string = openAIService.location
