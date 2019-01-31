#!/usr/bin/env bash
#
#  Purpose: Provision the Resources using Terraform
#  Usage:
#    provision.sh

cd terraform
terraform init
terraform plan
terraform apply
terraform refresh
cd ..
