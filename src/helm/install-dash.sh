#!/bin/bash

cp $(pwd)/env-values/demo-values.yaml $(pwd)/dashboard/values.yaml
helm install --debug ./dashboard
rm -rf $(pwd)/dashboard/values.yaml
:
