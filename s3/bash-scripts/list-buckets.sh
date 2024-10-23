#!/usr/bin/env bash

# This script is used for listing the 5 latest bucket in S3

set -e # exit if there is an error

aws s3api list-buckets \
| jq -r '.Buckets | sort_by(.CreationDate) | reverse | .[0:5] | .[] | .Name'

echo ...