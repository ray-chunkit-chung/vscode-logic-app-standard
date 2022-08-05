#!/bin/bash
# Create a logic app standard base
az deployment group create --subscription $SUBSCRIPTION_NAME \
                           --resource-group $RESOURCEGROUP_NAME \
                           --template-file ArmTemplate/logicAppASP/template.json \
                           --parameters ArmTemplate/logicAppASP/parameters.json
