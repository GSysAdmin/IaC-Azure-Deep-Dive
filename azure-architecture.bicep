@allowed ([ 'test', 'prod' ])
param enviromnmentName string

param awesomeFeatureEnable bool

@description('Please make sure you do not increase the count to much!')
@minValue(1)
@maxValue(5)
param awesomeFeatureCount int

@minLength(5)
@maxLength(25)
param awesomeFeatureDisplayName string

// Take resource group  location id
param location  string = resourceGroup().location

// If prod deploy B2 else deploy B1  
var serverFarmSkuName = enviromnmentName == 'prod' ? 'B2' : 'B1'

resource serverFarm'Microsoft.Web/serverfarms@2023-12-01' = {
  name: 'asp-myCompanyPortal-${enviromnmentName}'
  location: location
  sku:{
    name: serverFarmSkuName
  }
}

resource website 'Microsoft.Web/sites@2023-12-01' = {
  name: 'app-myCompanyPortal-cgw-${enviromnmentName}'
  location: location
  properties: {
    serverFarmId: serverFarm.id
  }
}


resource websiteSettings 'Microsoft.Web/sites/config@2023-12-01' = {
  parent: website
  name: 'appsettings'
  properties: {
    enableAwesomeFeature: string(awesomeFeatureEnable)
    awesomeFeatureCount: string(awesomeFeatureCount)
    awesomeFeatureDisplayName: awesomeFeatureDisplayName
  }
}

resource logAnalyticsWorkspace 'Microsoft.OperationalInsights/workspaces@2023-09-01' existing = {
  scope: resourceGroup(subscription().subscriptionId, 'rg-westeurope-test-shared ')
  name: 
}

resource applicationInsights 'Microsoft.Insights/components@2020-02-02' = {
  name: 'appi-myCompanyPortal-${enviromnmentName}'
  location: location
  kind: 'web'
  properties: {
    Application_Type: 'web'
    WorkspaceResourceId: logAnalyticsWorkspace.id
  }
}
