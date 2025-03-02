class DeploymentResult {
    [string]$ResourceGroupName
    [string]$StorageAccountName
    [string]$StorageAccountConnectionString
    [string]$AzSearchServiceName
    [string]$AzSearchServicEndpoint
    [string]$AzSearchAdminKey
    [string]$LogicAppDocumentProcessWatcherName
    [string]$LogicAppBenchmarkProcessWatcherName
    [string]$LogicAppGapAnalysisProcessWatcherName
    [string]$AzLogicAppDocumentRegistProcessWatcherUrl
    [string]$AzLogicAppBenchmarkProcessWatcherUrl
    [string]$AzLogicAppGapAnalysisProcessWatcherUrl
    [string]$AksName
    [string]$ContainerRegistryName
    [string]$AzCognitiveServiceName
    [string]$AzCognitiveServiceKey
    [string]$AzCognitiveServiceEndpoint
    [string]$AzOpenAiServiceName
    [string]$AzGPT4oModelName
    [string]$AzGPT4oModelId
    [string]$AzGPT4_32KModelName
    [string]$AzGPT4_32KModelId
    [string]$AzGPTEmbeddingModelName
    [string]$AzGPTEmbeddingModelId
    [string]$AzOpenAiServiceEndpoint
    [string]$AzOpenAiServiceKey
    [string]$AzCosmosDBName
    [string]$AzCosmosDBConnectionString

    DeploymentResult() {
        # Resource Group
        $this.ResourceGroupName = ""
        # Storage Account
        $this.StorageAccountName = ""
        $this.StorageAccountConnectionString = ""
        # Azure Search
        $this.AzSearchServiceName = ""
        $this.AzSearchServicEndpoint = ""
        $this.AzSearchAdminKey = ""
        # Logic Apps
        $this.LogicAppDocumentProcessWatcherName = ""
        $this.LogicAppBenchmarkProcessWatcherName = ""
        $this.LogicAppGapAnalysisProcessWatcherName = ""
        $this.AzLogicAppDocumentRegistProcessWatcherUrl = ""
        $this.AzLogicAppBenchmarkProcessWatcherUrl = ""
        $this.AzLogicAppGapAnalysisProcessWatcherUrl = ""
        # AKS
        $this.AksName = ""
        # Container Registry
        $this.ContainerRegistryName = ""
        # Cognitive Service - Azure AI Intelligence Document Service
        $this.AzCognitiveServiceName = ""
        $this.AzCognitiveServiceEndpoint = ""
        $this.AzCognitiveServiceKey = ""
        # Open AI Service
        $this.AzOpenAiServiceName = ""
        $this.AzOpenAiServiceEndpoint = ""
        $this.AzOpenAiServiceKey = ""
        # Model - GPT4o
        $this.AzGPT4oModelName = ""
        $this.AzGPT4oModelId = ""
        # Model - GPT4_32K
        $this.AzGPT4_32KModelName = ""
        $this.AzGPT4_32KModelId = ""
        # Model - Embedding
        $this.AzGPTEmbeddingModelName = ""
        $this.AzGPTEmbeddingModelId = ""
        # Cosmos DB
        $this.AzCosmosDBName = ""
        $this.AzCosmosDBConnectionString = ""
    }

    [void]MapResult([pscustomobject]$jsonString) {
        # Add your code here
        $this.ResourceGroupName = $jsonString.properties.outputs.gs_resourcegroup_name.value
        $this.StorageAccountName = $jsonString.properties.outputs.gs_storageaccount_name.value
        $this.AzSearchServiceName = $jsonString.properties.outputs.gs_azsearch_name.value
        $this.AzSearchServicEndpoint =  "https://$($this.AzSearchServiceName).search.windows.net"
        $this.LogicAppDocumentProcessWatcherName = $jsonString.properties.outputs.gs_logicapp_docregistprocesswatcher_name.value
        $this.LogicAppBenchmarkProcessWatcherName = $jsonString.properties.outputs.gs_logicapp_benchmarkprocesswatcher_name.value
        $this.LogicAppGapAnalysisProcessWatcherName = $jsonString.properties.outputs.gs_logicapp_ProcessWatcher_name.value
        $this.AksName = $jsonString.properties.outputs.gs_aks_name.value
        $this.ContainerRegistryName = $jsonString.properties.outputs.gs_containerregistry_name.value
        $this.AzCognitiveServiceName = $jsonString.properties.outputs.gs_azcognitiveservice_name.value
        $this.AzCognitiveServiceEndpoint = $jsonString.properties.outputs.gs_azcognitiveservice_endpoint.value
        $this.AzOpenAiServiceName = $jsonString.properties.outputs.gs_openaiservice_name.value
        $this.AzOpenAiServiceEndpoint = $jsonString.properties.outputs.gs_openaiservice_endpoint.value
        $this.AzCosmosDBName = $jsonString.properties.outputs.gs_cosmosdb_name.value
        $this.AzLogicAppDocumentRegistProcessWatcherUrl = $jsonString.properties.outputs.gs_logicapp_docregistprocesswatcher_endpoint.value
        $this.AzLogicAppBenchmarkProcessWatcherUrl = $jsonString.properties.outputs.gs_logicapp_benchmarkprocesswatcher_endpoint.value
        $this.AzLogicAppGapAnalysisProcessWatcherUrl = $jsonString.properties.outputs.gs_logicapp_docregistprocesswatcher_endpoint.value
        $this.AzGPT4oModelName = $jsonString.properties.outputs.gs_openaiservicemodels_gpt4o_model_name.value
        $this.AzGPT4oModelId = $jsonString.properties.outputs.gs_openaiservicemodels_gpt4o_model_id.value
        $this.AzGPT4_32KModelName = $jsonString.properties.outputs.gs_openaiservicemodels_gpt4_32k_model_name.value
        $this.AzGPT4_32KModelId = $jsonString.properties.outputs.gs_openaiservicemodels_gpt4_32k_model_id.value
        $this.AzGPTEmbeddingModelName = $jsonString.properties.outputs.gs_openaiservicemodels_text_embedding_model_name.value
        $this.AzGPTEmbeddingModelId = $jsonString.properties.outputs.gs_openaiservicemodels_text_embedding_model_id.value
    }
}
$filePath = "Deployment/scripts/JSONOBJ-4.scratch.json"
$deploymentResult = [DeploymentResult]::new()
$json = $null
$json = Get-Content -Path $filePath -Raw  
$jsonObject = $json | ConvertFrom-Json 
$deploymentResult.MapResult($jsonObject)   
$deploymentResult | Format-List -Property *
$deploymentResult | Select-Object -Property ResourceGroupName
# $deploymentResult | Get-Member
