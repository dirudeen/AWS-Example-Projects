#!/usr/bin/env bash

# Des: This script is used for uploaading files to S3

echo == Syncing files to bucket
set -e # exit if there is an error

# check for bucket name and filename prefix
if [ -z $1 ] || [ -z $2 ]; then
    echo Bucket name and filename prefix must be provided
    exit 1
fi
BUCKET_NAME=$1
FILENAME_PREFIX=$2


# Generate a random number of files between 5 and 10
num_files=$((RANDOM % 6 + 5))  # Random number between 5 and 10

# Directory where files will be created
OUTPUT_DIR="/tmp/bash-scripts"

# Delete OUTPUT_DIR directory if it exist 
if [ -d $OUTPUT_DIR ]; then
    rm -r "$OUTPUT_DIR"
fi

# Create the directory if it doesn't exist
mkdir -p "$OUTPUT_DIR"

# Generate random files
for ((i=1; i<=$num_files; i++)); do
  # Generate a random file name
  RANDOM_FILENAME="${FILENAME_PREFIX}_$i.txt"
  
  # Create the file
  touch "$OUTPUT_DIR/$RANDOM_FILENAME"
  
  # Generate random data and write it to the file
  head -c 100 </dev/urandom | base64 > "$OUTPUT_DIR/$RANDOM_FILENAME"
done

tree $OUTPUT_DIR

aws s3 sync $OUTPUT_DIR/ s3://$BUCKET_NAME/files