

## Run the metrics server script first
## Create ServiceAccount
## Deploy dashboard

kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.0.0-beta4/aio/deploy/recommended.yaml
-

Dashboard access info :
run this command  and copy the token value provided in the output
kubectl -n kube-system describe secret $(kubectl -n kube-system get secret | grep eks-admin | awk '{print $1}')

Next run the kubernetes proxy. k proxy
this will consume the shell session where it is invoked, and will consume port 8001 on your machine.
You should see output like this Starting to serve on 127.0.0.1:8001
With your kube proxy connected, you can now navigate to : http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/#!/login
Entering the token retrieved from step 1 to login
