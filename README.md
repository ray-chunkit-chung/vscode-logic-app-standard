# azure-logic-app-standard
azure logic app to track new file upload to one drive. If new, add an Azure queue

# Install necessary program
  - .net core sdk 3.1 e.g. dotnet-sdk-3.1.421-win-x64
  - host bundle e.g. dotnet-hosting-3.1.27-win
  - azure function core e.g. func-cli-x64
  - .net sdk 6.0 e.g. dotnet-sdk-6.0.302-win-x64
  - Vscode
  - Vscode extension: Logic app (standard), Azurite
  - bash

# CICD 

 - Step1 know single-tenant-azure-logic-apps
azure-docs/devops-deployment-single-tenant-azure-logic-apps.md at main · MicrosoftDocs/azure-docs · GitHub

 - Step2 create app at local
azure-docs/create-single-tenant-workflows-visual-studio-code.md at main · MicrosoftDocs/azure-docs · GitHub

 - Step???? enable the run history for that workflow.
https://github.com/MicrosoftDocs/azure-docs/blob/main/articles/logic-apps/create-single-tenant-workflows-visual-studio-code.md#enable-run-history-stateless

 - Step3 devops-deployment
azure-docs/set-up-devops-deployment-single-tenant-azure-logic-apps.md at main · MicrosoftDocs/azure-docs · GitHub

# Getting started

Login Azure
```
az login
```

Deploy infrastructure and workflow 
```
source .env
sh script/create_resource_group.sh
sh script/deploy_logic_app_asp.sh 
sh script/deploy_workflow.sh
```

# Delete everything

```
sh script/delete_resource_group.sh
```

# If error

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

