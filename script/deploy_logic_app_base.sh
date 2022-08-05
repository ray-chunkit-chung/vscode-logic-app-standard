#!/bin/bash
# Create a logic app standard base
az deployment group create --subscription $SUBSCRIPTION_NAME \
                           --resource-group $RESOURCEGROUP_NAME \
                           --template-file ArmTemplate/logicAppBase/template.json \
                           --parameters ArmTemplate/logicAppBase/parameters.json
