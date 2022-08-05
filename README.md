# azure-logic-app-standard
azure logic app to track new file upload to one drive. If new, add an Azure queue


# Install necessary program
  - .net core sdk 3.1 e.g. dotnet-sdk-3.1.421-win-x64
  - host bundle e.g. dotnet-hosting-3.1.27-win
  - azure function core e.g. func-cli-x64
  - .net sdk 6.0 e.g. dotnet-sdk-6.0.302-win-x64
  - Vscode
  - Vscode extension: Logic app (standard), Azurite

# CICD 

 - Step1 know single-tenant-azure-logic-apps
azure-docs/devops-deployment-single-tenant-azure-logic-apps.md at main · MicrosoftDocs/azure-docs · GitHub

 - Step2 create app at local
azure-docs/create-single-tenant-workflows-visual-studio-code.md at main · MicrosoftDocs/azure-docs · GitHub

 - Step???? enable the run history for that workflow.
https://github.com/MicrosoftDocs/azure-docs/blob/main/articles/logic-apps/create-single-tenant-workflows-visual-studio-code.md#enable-run-history-stateless


 - Step3 devops-deployment
azure-docs/set-up-devops-deployment-single-tenant-azure-logic-apps.md at main · MicrosoftDocs/azure-docs · GitHub


# Create workflow

https://docs.microsoft.com/en-us/cli/azure/logicapp?view=azure-cli-latest
```
az logic workflow create -n demo -g test -l centralus --definition .\src\workflow.json
```

Install logic app extension https://github.com/MicrosoftDocs/azure-docs/blob/main/articles/logic-apps/set-up-devops-deployment-single-tenant-azure-logic-apps.md
```
az extension add --yes --source "https://aka.ms/logicapp-latest-py2.py3-none-any.whl"
```
Deploy
```
az logicapp deployment source config-zip --name MyLogicAppName 
   --resource-group MyResourceGroupName --subscription MySubscription 
   --src MyBuildArtifact.zip
```


# Get customDomainVerificationId
```
az graph query -q "Resources | join kind=leftouter (ResourceContainers | where type=='microsoft.resources/subscriptions' | project subscriptionName=name, subscriptionId) on subscriptionId | where type == 'microsoft.web/sites'| project customVerificationId = tostring(properties.customDomainVerificationId), subscriptionId, subscriptionName | distinct *"
```

```
az graph query -q "Resources | project name, properties.customDomainVerificationId, type | where type == 'microsoft.web/sites'"
```

# The subscription is not registered to use namespace 'Microsoft.Logic'

Install AzureRmResourceProvider in Admin Powershell
https://stackoverflow.com/questions/64787022/the-term-register-azresourceprovider-is-not-recognized-as-the-name-of-a-cmdlet
```
Install-Module -Name Az -AllowClobber -Scope AllUsers -Force
Connect-AzAccount
```

Register Microsoft.Logic
https://stackoverflow.com/questions/36200143/the-subscription-is-not-registered-to-use-namespace-microsoft-datafactory-error
```
Register-AzureRmResourceProvider -ProviderNamespace Microsoft.Logic
```


If error
```
PS C:\xxx\> Connect-AzAccount
Connect-AzAccount : The 'Connect-AzAccount' command was found in the module 'Az.Accounts', but the module could not be
loaded. For more information, run 'Import-Module Az.Accounts'.
At line:1 char:1
+ Connect-AzAccount
+ ~~~~~~~~~~~~~~~~~
    + CategoryInfo          : ObjectNotFound: (Connect-AzAccount:String) [], CommandNotFoundException
    + FullyQualifiedErrorId : CouldNotAutoloadMatchingModule

PS C:\xxx\> Import-Module Az.Accounts
Import-Module : File C:\xxx\Az.Accounts.psm1 cannot be loaded
because running scripts is disabled on this system. For more information, see about_Execution_Policies at
https:/go.microsoft.com/fwlink/?LinkID=135170.
At line:1 char:1
+ Import-Module Az.Accounts
+ ~~~~~~~~~~~~~~~~~~~~~~~~~
    + CategoryInfo          : SecurityError: (:) [Import-Module], PSSecurityException
    + FullyQualifiedErrorId : UnauthorizedAccess,Microsoft.PowerShell.Commands.ImportModuleCommand
```





# Getting started

Login Azure
```
az login
```

Create resource group (Assume a subscription exists)
```
az group create --subscription $SUBSCRIPTION_NAME \
                --location $LOCATION \
                --name $RESOURCEGROUP_NAME \
                --tags "$TAGS"
```

Create storage account
```
az storage account create --subscription $SUBSCRIPTION_NAME \
                          --name $STORAGE_NAME \
                          --resource-group $RESOURCEGROUP_NAME
```

Create queues in storage account
```
az deployment group create --subscription $SUBSCRIPTION_NAME \
                           --resource-group $RESOURCEGROUP_NAME \
                           --template-file ArmTemplate/queue/template.json
```
<!-- ```
az deployment group create --subscription $SUBSCRIPTION_NAME \
                           --resource-group $RESOURCEGROUP_NAME \
                           --template-file ArmTemplate/queue/template.json \
                           --parameters ArmTemplate/queue/parameters.json

az storage queue create --subscription $SUBSCRIPTION_NAME \
                        --name $STORAGE_QUEUE_NAME \

az deployment group create --subscription $SUBSCRIPTION_NAME \
                           --resource-group $RESOURCEGROUP_NAME \
                           --template-file ArmTemplate/logicApp/template.json
``` -->


Create api connection to one drive and queue in this resource group
```
az deployment group create --subscription $SUBSCRIPTION_NAME \
                           --resource-group $RESOURCEGROUP_NAME \
                           --template-file ArmTemplate/api_queue/template.json
az deployment group create --subscription $SUBSCRIPTION_NAME \
                           --resource-group $RESOURCEGROUP_NAME \
                           --template-file ArmTemplate/api_onedrive/template.json
```

Create logic app to connect one drive and queue
```
az deployment group create --subscription $SUBSCRIPTION_NAME \
                           --resource-group $RESOURCEGROUP_NAME \
                           --template-file ArmTemplate/logicApp/template.json
```

Start the logic app
```
az logicapp start --subscription $SUBSCRIPTION_NAME \
                  --resource-group $RESOURCEGROUP_NAME \
                  --name $LOGICAPP_NAME
```



# Delete everything

```
az group delete --name $RESOURCEGROUP_NAME
```

