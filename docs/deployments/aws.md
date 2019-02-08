#Terraform
- First place to start, deploys dedicated VPC for your HumanDB Cluster
- Deploys all AWS infra and the AWS EKS Service
- Creates all IAM roles and Auto Scaling Groups for the worker nodes
- Creates necessary kubectl connection file

# Kubectl (Management Container)

- Deploy the management container for kubernetes on AWS
###### AWS Docker build container
    - This is how you can setup your local control plane to interact with k8s
    - docker build --pull --no-cache -t humandb-deploy:latest -f DockerfileAWS .
    - docker run -it -e “AWS_ACCESS_KEY_ID=” -e “AWS_SECRET_ACCESS_KEY=” -e “AWS_DEFAULT_REGION=us-east-1” -e “KUBECONFIG=$KUBECONFIG:/buildtools/kube-services/humandb-config” --volume=$(pwd)/humandb/terraform/:/buildtools/terraform/ --volume=$(pwd)/humandb/kube-services/:/buildtools/kube-services/ --volume=$(pwd)/humandb/humandb-services:/buildtools/humandb-services/ --volume=/Users/andrew.popp/keys/:/buildtools/keys --volume=/var/run/docker.sock:/var/run/docker.sock -p 80:80 humandb-deploy:latest

  - Once youve built and run your container, as long as that shell is left active, you can initiate multiple shell sessions here.
  - `docker exec -it name /bin/bash`
