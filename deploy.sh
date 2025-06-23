1. az deployment group create \                                     
  --resource-group test-rg \
  --template-file layers/dta/network/main.bicep \ 
  --parameters @layers/dta/network/config.json  

2. az deployment group create \                                                             
  --resource-group test-rg \
  --template-file layers/dta/app-service/main.bicep \
  --parameters @layers/dta/app-service/config.json

3. az deployment group create \                                     
  --resource-group test-rg \
  --template-file layers/dta/security/main.bicep \
  --parameters @layers/dta/security/config.json 