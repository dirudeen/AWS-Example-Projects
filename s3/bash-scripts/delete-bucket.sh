#!/usr/bin/env bash

# This script is used for deleting a bucket in S3

echo "==> Delete bucket"
set -e # exit if there an error

# check for bucket name
if [ -z $1 ]; then
    echo Bucket name must be provided
    exit 1
fi
BUCKET_NAME=$1

# https://awscli.amazonaws.com/v2/documentation/api/latest/reference/s3api/delete-bucket.html
aws s3api delete-bucket \
--bucket $BUCKET_NAME

echo "Bucket ${BUCKET_NAME} deleted"
