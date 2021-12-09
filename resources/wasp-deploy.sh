#!/bin/bash
ENVIRONMENT="${1-sandbox}"

TERRAFORM_TFVARS_FILE="wasp-${ENVIRONMENT?}.tfvars"

if [ ! -e "${TERRAFORM_TFVARS_FILE}" ]; then
  echo "File ${TERRAFORM_TFVARS_FILE?} not exists."
  exit 1
fi

env DEBUG=2 stackrun \
  azure-kubernetes-cluster:0.1.0 apply -auto-approve \
    -var-file=/opt/variables/default.tfvars \
    -var-file=/opt/variables/${TERRAFORM_TFVARS_FILE?}
