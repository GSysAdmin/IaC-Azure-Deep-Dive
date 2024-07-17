resource serverFarm'Microsoft.Web/serverfarms@2023-12-01' = {
  name: 'asp-myCompanyPortal'
  location: 'westeurope'
  sku:{
    name: 'B1'
  }
}

resource website 'Microsoft.Web/sites@2023-12-01' = {
  name: 'app-myCompanyPortal-cgw'
  location: 'westeurope'
  properties: {
    serverFarmId: serverFarm.id
  }
}


resource websiteSettings 'Microsoft.Web/sites/config@2023-12-01' = {
  parent: website
  name: 'appsettings'
  properties: {
    enableAwesomeFeature: 'true'
  }
}
