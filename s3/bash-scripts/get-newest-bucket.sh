#!/usr/bin/env bash

# This script is used for getting the latest bucket

set -e # exit if there is an error

aws s3api list-buckets \
| jq -r '.Buckets | sort_by(.CreationDate) | reverse | .[0] | .Name'