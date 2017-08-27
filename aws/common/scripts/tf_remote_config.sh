#!/bin/bash

S3TFSTATE=${S3TFSTATE}
ENVIRONMENT=$2
# Ensure the .terraform are always removed and pull the latest modules
	rm -rf .terraform

  RELATIVE_PATH="$(git rev-parse --show-toplevel | git rev-parse --show-prefix)"

  echo "Configuring S3 bucket for the remote state file..."
  
  terraform init\
    -backend=true\
    -backend-config "region=${REGION}"\
    -backend-config "bucket=${S3TFSTATE}"\
    -backend-config "key=${RELATIVE_PATH}terraform.tfstate"\
    -backend-config "encrypt=true"

  printf '%.0s-' {1..60}; echo
