#!/bin/bash
# Create workflow on existing logic app consumption
az logic workflow create \
  --resource-group $RESOURCEGROUP_NAME \
  --subscription $SUBSCRIPTION_NAME \
  --location $LOCATION \
  --name "logic-app-consumption-name" \
  --definition test-Stateful2/workflow.json
