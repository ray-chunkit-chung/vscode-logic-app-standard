#!/bin/bash
# Login azure cli using service principal
az login --service-principal -u $SERVICE_PRINCIPAL_USERNAME -p $SERVICE_PRINCIPAL_PASSWORD --tenant $TENANT_ID
