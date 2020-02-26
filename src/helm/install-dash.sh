#!/bin/bash
VALFILE=${1}
APPNAME=${2}

# Check for Value line item
if [ -z ${1} ];then
  echo "Value file not provided as argument it should be your first arg"
  exit 1
else echo "Using the ${1} value file to deploy the app ... "
fi

if [ -z ${2} ];then
  echo "App name not provided as argument it should be your second arg"
  exit 1
else echo "Using the ${2} helm app name to deploy the app ... "
fi

set -e
cp $(pwd)/env-values/${1} $(pwd)/dashboard/values.yaml
helm install --debug -n ${2} ./dashboard
rm -rf $(pwd)/dashboard/values.yaml
:
