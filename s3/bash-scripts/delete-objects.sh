#!/usr/bin/env bash

# This script is used for deleting a bucket in S3

echo "==> Delete all objects"
set -e # exit if there an error

# Check for bucket name
if [ -z $1 ]; then
    echo Bucket name must be provided
    exit 1
fi

BUCKET_NAME=$1

# gets and store all the objects from the bucket to delete.json
aws s3api list-objects --bucket $BUCKET_NAME \
--query Contents[].Key \
| jq '{Objects: map({Key: .})}' > /tmp/delete.json


aws s3api delete-objects \
--bucket $BUCKET_NAME \
--delete file:///tmp/delete.json