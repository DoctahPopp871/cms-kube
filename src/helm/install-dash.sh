#!/bin/bash

cp $(pwd)/env-values/mcdb000-values.yaml $(pwd)/dashboard/values.yaml
helm install --debug -n mcdb-000 ./dashboard
rm -rf $(pwd)/dashboard/values.yaml
:


## Provide value at script invocation to set values file
## Values file shoould be env var populated by positional argument
