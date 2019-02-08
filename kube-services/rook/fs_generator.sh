#!/bin/bash

pushd /resources
# Top Level Dir Structure
mkdir -p {services,shared,cancerDB}
# Current Services
mkdir -p ./services/{dashboard,discourse/shared,fhir}
# Current Shared resources
mkdir -p ./shared/{pgsql,gdcDB}
# CancerDB Genomic Schema
mkdir -p ./cancerDB/{Germline_WES_001,Germline_WGS_001,Tumor_WES_001,Tumor_WGS_001}
popd
## Future Iteration (cmd line parameters // options)
# Would you like to add a service ? - take input, and category, run relevant mkdir command to update.
# Build can be paramterized and variable to enforce a starting state, but allow for additional folders to be created.
