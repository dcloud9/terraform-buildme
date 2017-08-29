#! /bin/bash
### Export all env vars. Use $REGION even standing the stack in single region for future-proofing multi-region deploy.
#export S3TFSTATE=<s3-bucket-name>-$REGION
export S3TFSTATE=buildme-958131019040-prod01-tfstate-$REGION

# Export to env vars to Terraform
export TF_VAR_s3tfstate=$S3TFSTATE

