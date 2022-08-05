#!/bin/bash
# Delete everything in a resource group
yes | az group delete --name $RESOURCEGROUP_NAME --subscription $SUBSCRIPTION_NAME --yes
