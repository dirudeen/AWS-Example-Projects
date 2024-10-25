#!/bin/env bash

echo "==> Applying CFT template"

set -e # exit if there is an error

aws cloudformation deploy \
--template-file ./template.yaml \
--stack-name s3-bucket-creation \
--no-execute-changese \
--region us-east-1