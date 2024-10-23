#!/usr/bin/env bash

# Des: This script is used for uploaading files to S3

echo == Put object
set -e # exit if there is an error

# check for bucket name and filename prefix
if [ -z $1 ] || [ -z $2 ]; then
    echo Bucket name and file path must be provided.
    exit 1
fi
BUCKET_NAME=$1
FILE_PATH=$2
FILENAME=$(basename $FILE_PATH)

aws s3api put-object \
--bucket $BUCKET_NAME \
--key $FILENAME \
--body $FILE_PATH