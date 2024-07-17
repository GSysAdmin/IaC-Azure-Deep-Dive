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

resource serverFarm'Microsoft.Web/serverfarms@2023-12-01' = {
  name: 'asp-myCompanyPortal-${enviromnmentName}'
  location: 'westeurope'
  sku:{
    name: 'B1'
  }
}

resource website 'Microsoft.Web/sites@2023-12-01' = {
  name: 'app-myCompanyPortal-cgw-${enviromnmentName}'
  location: 'westeurope'
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
