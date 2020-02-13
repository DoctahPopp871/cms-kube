#!/bin/bash

cp $(pwd)/env-values/demo-values.yaml $(pwd)/dashboard/values.yaml
helm install --debug -n mcdb-demo ./dashboard
rm -rf $(pwd)/dashboard/values.yaml
:
