Invoke-WebRequest -Uri "https://raw.githubusercontent.com/BrentenDovey-ACG/AZ-104_Azure_Administrator/master/removeAll.json" -OutFile ~/removeAll.json

$rg = az group list --query [].name -o tsv
az deployment group create --resource-group $rg --mode Complete --template-file ~/removeAll.json

