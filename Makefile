define colorecho
      @tput setaf 6
      @echo $1
      @tput sgr0
endef

$(call colorecho,"Linking with" $(LD))
$(LD) $^ -o $@



###Provision Cluster with necessary subsystem Deps (Networking/Ingress and Storage/Rook)
#Provision Cluster w. Tiller(Helm) & Ingress

#minikube mount $(pwd):/humandb/code &>/dev/null &
#minikube mount /Users/andrew.popp/reports:/humandb/data &>/dev/null &

####
#Preload host with all images ?

minikube start --vm-driver=virtualbox --memory 4096 disk-size 50000MB
minikube addons enable ingress
kubectl apply -f kube-services/helm/tiller-rbac.yaml
helm init --service-account tiller
#provision Storage
helm repo add rook-stable https://charts.rook.io/stable
helm repo update
helm install --namespace rook-ceph-system --name rook-ceph rook-stable/rook-ceph -f kube-services/rook/values.yaml
sleep 40 ?
kubectl get pods --namespace rook-ceph-system
kubectl apply -f kube-services/rook/storage.yaml
sleep 200 ?
kubectl get pods --namespace rook-ceph
#Deploy filesystem
kubectl apply -f kube-services/rook/filesystem.yaml
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
#Allow access from outside of namespace to storage
kubectl apply -f kube-services/rook/networkPolicy.yaml
#Remove toolbox when done
kubectl -n rook-ceph delete deployment rook-ceph-tools
## Generate SSL Certs
openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout ./keys/mycancerdb-local-development.key -out ./keys/mycancerdb-local-development.crt -subj "/CN=mycancerdb-local-development.com"
## Store the certs in a secret
#kubectl create secret tls mycancerdb-local-development --key ./keys/mycancerdb-local-development.key --cert ./keys/mycancerdb-local-development.crt

### Create Hosts Entry with kubectl ip for mycancerdb-local-development.com
K8S_IP=$(minikube ip)
echo -n "${IP} ${HOSTNAME}"

### Deploy humanDB/CancerDB to the cluster w. Helm
helm install ./humandb

### Develop
cnd up --namespace cdb
cnd run install
cnd run start
