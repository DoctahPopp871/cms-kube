#TODO
- Nginx HTTP>HTTPS Forced redirect for Discourse.
- Add name value to the docker run command.
- Expose k8s dashboard https://itnext.io/how-to-expose-your-kubernetes-dashboard-with-cert-manager-422ab1e3bf30
- Move discourse off of root https://meta.discourse.org/t/subfolder-support-with-docker/30507
  - https://meta.discourse.org/t/running-other-websites-on-the-same-machine-as-discourse/17247
- Move raw data to the EFS share   
- Container to scale cluster.
- Set humandb-01 as deafult namespace in toolbox container.
- set humandb as alias for kubectl for demo

# Getting Started
   - Kubernetes name space is humandb-01
   - Working with hdb01
      - docker for mac
      - AWS Account
        - AWS access keys
   - Talk about the docker image what does it do.
    - Loads the kubectl config file into image to allow interactions with the hdb01 control plane.
    - Its image is the Dockerfile in the base of this repo.
    - You can see that it has some default tools installed, do not remove any of these, but please add what you like.



# Working with kubectl (humandb-cli)

kubectl get pods --namespace humandb-01
kubectl exec pgsql-845fd958bf-wqdmf -- su postgres -c '/opt/bitnami/postgresql/bin/psql template1 -c "create extension if not exists hstore;"'
kubectl exec pgsql-845fd958bf-wqdmf --namespace humandb-01 -- su postgres -c '/opt/bitnami/postgresql/bin/psql template1 -c "create extension if not exists hstore;"'
kubectl exec pgsql-845fd958bf-wqdmf --namespace humandb-01 -- su postgres -c 'psql template1 -c "create extension if not exists hstore;"'
kubectl exec pgsql-845fd958bf-wqdmf --namespace humandb-01 -- su postgres -c 'psql template1 -c "create extension if not exists pg_trgm;"'
kubectl exec pgsql-845fd958bf-wqdmf --namespace humandb-01 -- su postgres -c 'psql discourse -c "create extension if not exists hstore;"'
kubectl exec pgsql-845fd958bf-wqdmf --namespace humandb-01 -- su postgres -c 'psql discourse -c "create extension if not exists pg_trgm;"'
kubectl get events --namespace humandb-01
kubectl apply -f redis.yaml
kubectl get events --namespace humandb-01
kubectl apply discourse.yaml
kubectl apply -f discourse.yaml
kubectl get events --namespace humandb-01
kubectl logs --since=1h --tail=50 -lapp=discourse-web
kubectl get events --namespace humandb-01
kubectl logs --since=1h --tail=50 -lapp=discourse-web
kubectl logs --since=1h --tail=50 -lapp=discourse-web --namespace humandb-01
kubectl get pods --namespace humandb-01
dockr exec -it efs-provisioner-69f4dbbdc9-lzqs7 -- /bin/bash
kubectl exec -it efs-provisioner-69f4dbbdc9-lzqs7 --namespace humandb-01 -- /bin/bash
kubectl exec -it discourse-web-6ff7695dfc-lg8bm --namespace humandb-01 -- /bin/bash



# Humandb-Services
  - Services and deployments related to deploying the services that make up the humandb-platform. This is where disoucrse and other services like smtp, auth would be deployed.
## Discourse
  - See README.md

# Kube-Services
  - Core services used to make things happen in the cluster. These are add-ons to the core set of services that are part of k8s

# Terraform
  - In order to replicate this infrastructure you can quickly use terraform to deploy all of the necessary pieces on AWS.
