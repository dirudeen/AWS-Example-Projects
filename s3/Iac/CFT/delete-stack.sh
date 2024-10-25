#!/bin/env bash

if [ -z $1 ]; then
    echo "Stack name must be provided. e.g delete-stack.sh stack-name"
    exit 1
fi

stack_name=$1

aws cloudformation delete-stack --stack-name $stack_name