#Terraform HDB-EKS

- The deployment of the EKS Platform happens in two stages.
  - Stage 1 Control Plane deployment. Comment out the rules for the Wrkr SG so it can be created as a dep for Control Plane.
    - `terraform init`
    - `terraform plan -var-file terraform.tfvars`
    - `terraform apply -var-file terraform.tfvars`
  - Stage 2 Worker Nodes Deployment
    - `terraform init`
    - `terraform plan -var-file ../terraform.tfvars`
    - `terraform apply -var-file ../terraform.tfvars`
