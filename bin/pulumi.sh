#!/bin/env bash

# This script is used for installing Pulumi

curl -fsSL https://get.pulumi.com | sh
export PATH=$HOME/.pulumi/bin:$PATH