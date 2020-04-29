<https://github.com/rook/rook/blob/master/Documentation/ceph-examples.md><br>

### Argo
k create -f namespace.yaml
k create -n argo -f install.yaml
k create -f alb-rbac.yaml
k create -f alb-ingress-controller.yaml
k create -f external-dns.yaml
k create -f ui-ingress.yaml
k create -n argo -f docker_cred.yaml
### Argo is deployed behind a private load balancer

### Rook-Ceph
k create -f common.yaml<br>
k create -f operator.yaml<br>
k create -f cluster.yaml<br>
k create -f networkPolicy.yaml<br>
k create -f filesystem-ec.yaml<br>
k create -f storageclass.yaml
k create -f toolbox.yaml<br>


#AutoScale Mode on FS
ceph mgr module enable pg_autoscaler
ceph osd pool set myfs-ec-data0 pg_autoscale_mode on
ceph osd pool autoscale-status
