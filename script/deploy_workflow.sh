#!/bin/bash

# Clean previous tmp deploy zip if exists
[ -e workflow.zip ] && rm workflow.zip

# Creat tmp deploy zip
(cd ArmTemplate/workflow && zip -r ../../workflow.zip .)

# Create workflow on existing logic app standard
az logicapp deployment source config-zip --name $LOGIC_APP_NAME \
                                         --resource-group $RESOURCEGROUP_NAME \
                                         --subscription $SUBSCRIPTION_NAME \
                                         --src workflow.zip

# Clean
rm workflow.zip
