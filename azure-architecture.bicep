resource serverFarm'Microsoft.Web/serverfarms@2023-12-01' = {
  name: 'myCompanyPortal'
  location: 'westeurope'
  sku:{
    name: 'B1'
  }
}
