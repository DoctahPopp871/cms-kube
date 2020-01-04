### Table of Contents
**[Requirements](#requirements)**<br>
**[Deployment Instructions](#installation-instructions)**<br>
**[Usage Instructions](#usage-instructions)**<br>
**[Troubleshooting](#troubleshooting)**<br>
**[Notes and Miscellaneous](#notes-and-miscellaneous)**<br>
**[Deploying new services](#deploying-new-services)**<br>
**[Next Steps, Credits, Feedback, License](#next-steps)**<br>

## Requirements

See the [Requirements wiki page](https://).
[Telepresence](https://github.com/telepresenceio/telepresence)

## Installation Instructions

### Cloud deployments

#### AWS
* There is a container configured for HumanDB and AWS that can be used to interact with the remote cluster. You'll need to build your cluster first, so you should start at
the [AWS Deployment wiki page](https://). There are some directions to deploy the workspace container below. It has everything you need to work with the project and remote cluster

###### AWS Docker build container
    - This is how you can setup your local control plane to interact with k8s
    - docker build --pull --no-cache -t humandb-deploy:latest -f DockerfileAWS .
    - docker run -it -e “AWS_ACCESS_KEY_ID=” -e “AWS_SECRET_ACCESS_KEY=” -e “AWS_DEFAULT_REGION=us-east-1” -e “KUBECONFIG=$KUBECONFIG:/kube-services/humandb-config” --volume=$(pwd)/humandb/:/buildtools/ --volume=/where/i/keep/my/keys/:/buildtools/keys --volume=/var/run/docker.sock:/var/run/docker.sock humandb-deploy:latest

  - Once youve built and run your container, as long as that shell is left active, you can initiate multiple shell sessions here.
  - `docker exec -it name /bin/bash`

See the [AWS Deployment wiki page](https://).

#### GCloud

See the [GCloud Deployment wiki page](https://).

#### Azure

See the [Azure Deployment wiki page](https://).

### Local Development

Local Development is a flexible process that leverages telepresence and kubernetes. Local development can interact with a local (minikube) k8s cluster or a remote (AWS,GCloud) K8s cluster

#### Minikube

## Script runs minikube ip and then populates hosts.conf with the local DNS record for the minikube IP to correspond with the entry in the values.config for the name.

minikube start --vm-driver=virtualbox
minikube mount /path/to/code:/humandb &>/dev/null & 2&>> pid.txt
minikube addons enable ingress
kubectl apply -f kube-services/helm/tiller-rbac.yaml
helm init --service-account tiller
helm install humandb

##Re-Arch Directions
#Provision Cluster w. Tiller(Helm) & Ingress
minikube start --vm-driver=virtualbox
minikube mount $(pwd):/humandb/code &>/dev/null &
minikube mount /Users/andrew.popp/reports:/humandb/data &>/dev/null &
minikube addons enable ingress
kubectl apply -f kube-services/helm/tiller-rbac.yaml
helm init --service-account tiller
#provision Storage
helm repo add rook-stable https://charts.rook.io/stable
helm install --namespace rook-ceph-system --name rook-ceph rook-stable/rook-ceph -f kube/services/rook/values.yaml
#kubectl apply -f humandb/templates/storage.yaml
#Confirm storage subsystem
kubectl get pods --namespace rook-ceph
#Deploy filesystem
kubectl apply -f humandb/templates/filesystem.yaml
#Confirm filesystem subsystem
kubectl get pods --namespace rook-ceph
#Deploy FS provisioner to cluster
kubectl create configmap fs-tree --from-file=kube-services/rook/fs_generator.sh --namespace rook-ceph
kubectl describe configmaps fs-tree --namespace rook-ceph
#Install Toolbox and run FS provisioner
kubectl apply -f kube-services/rook/toolbox.yaml
kubectl --namespace rook-ceph get pods -l "app=rook-ceph-tools"
#Managing Toolbox
#Connect to Toolbox
kubectl -n rook-ceph exec -it $(kubectl --namespace rook-ceph get pods -l "app=rook-ceph-tools" -o jsonpath='{.items[0].metadata.name}') bash
#Remove toolbox when done
kubectl -n rook-ceph delete deployment rook-ceph-tools

minikube ip
# Clever way of storing PIDS created during volume mounts ?
## Usage Instructions

Install it, and then…

1. In Chrome/Safari/Opera, *make sure* you reload your web mail page before trying to use Markdown Here.
2.
3.
4.

## Troubleshooting

See the [Troubleshooting wiki page](https://).

## Notes and Miscellaneous

*
*

## Deploying New Services

### Deploying a workspace
  - Deploying a workspace to work with data on the humanDB is easy once you have a feel for k8s Ive created an example in the examples folder
  - The example in `kube-services/examples/workspace` this folder will deploy an ubuntu workspace on the humanDB cluster, and attach hdb01 data to the workspace.
  - Define the workspace file. `workspace.yaml`
  - Apply the workspace file. `kubectl apply -f workspace.yaml`
  - Find the workspace pod `kubectl get pods --namespace humandb-01`
  - Shell into the workspace container `kubectl exec --namespace humandb-01 -it <pod-name> -- /bin/bash `
  - When done leave.
  - You can tear your workspace down, or rebuild it. You own your workspace.

## Next Steps

See the [issues list](https://) and the [Notes Wiki](https://). All ideas, bugs, plans, complaints, and dreams will end up in one of those two places.

Feel free to create a feature request issue if what you want isn't already there. If you'd prefer a less formal approach to floating an idea, message us on the ["HumanDB" Slack Channel](https://humandbworkspace.slack.com).

It also takes a fair bit of work to stay up-to-date with the latest changes in all the applications and web sites where Markdown Here works.


## Feedback

All bugs, feature requests, pull requests, feedback, etc., are welcome. [Create an issue](https://). Or [message us on the "HumanDB" Slack Channel](https://humandbworkspace.slack.com).

## License

### Code

MIT License: https://opensource.org/licenses/MIT or see [the `LICENSE` file](https://).
