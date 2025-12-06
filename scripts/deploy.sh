#!/bin/bash
set -e

# Usage: ./deploy.sh [env] [action]
# Example: ./deploy.sh dev apply

ENV=$1
ACTION=$2

if [[ -z "$ENV" || -z "$ACTION" ]]; then
    echo "Usage: $0 [dev|prod] [plan|apply|destroy]"
    exit 1
fi

VALID_ENVS=("dev" "prod")
if [[ ! " ${VALID_ENVS[@]} " =~ " ${ENV} " ]]; then
    echo "Error: Invalid environment. Must be one of: ${VALID_ENVS[*]}"
    exit 1
fi

cd terraform

# Select or create workspace
echo "Selecting workspace: $ENV..."
terraform workspace select $ENV || terraform workspace new $ENV

# Run Terraform action
echo "Running terraform $ACTION for $ENV..."
terraform $ACTION -var-file="envs/$ENV.tfvars"
