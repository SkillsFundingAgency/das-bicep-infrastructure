az deployment group create \
  --resource-group das-dta-hub-rg-new \
  --template-file layers/dta/network/main.bicep \    
  --parameters network="$(jq -c .network layers/dta/config.json)" 

az deployment group create \
  --resource-group test-rg \
  --template-file layers/dta/app-service/main.bicep \
  --parameters appService="$(jq -c .appService layers/dta/config.json)"

az deployment group create \
  --resource-group test-rg \
  --template-file layers/dta/security/main.bicep \
  --parameters security="$(jq -c .security layers/dta/config.json)"
