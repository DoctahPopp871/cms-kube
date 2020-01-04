<https://github.com/rook/rook/blob/master/Documentation/ceph-examples.md><br>
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
