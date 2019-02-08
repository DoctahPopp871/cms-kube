- Get Auth Token
- Must apply auth config files prior
``kubectl -n kube-system describe secret $(kubectl -n kube-system get secret | grep eks-admin | awk '{print $1}')``

-
