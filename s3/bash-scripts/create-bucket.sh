#!/usr/bin/env bash

# This script is used for creating a bucket in S3

echo == Create bucket
set -e # exit if there is an error

# Check for the bucket name
if [ -z $1 ]; then
    echo Bucket name must be provided
    exit 1
fi
BUCKET_NAME=$1

# https://awscli.amazonaws.com/v2/documentation/api/latest/reference/s3api/create-bucket.html
aws s3api create-bucket \
--bucket $BUCKET_NAME \
--region us-east-1 \
--query Location \
--output text