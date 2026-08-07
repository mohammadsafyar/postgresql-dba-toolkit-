# execute on server etcd pg1 

sudo systemctl stop etcd

sudo mv /var/lib/etcd /var/lib/etcd.old

sudo /usr/local/bin/etcdutl snapshot restore /tmp/save_snap.db \
  --name pg1 \
  --data-dir /var/lib/etcd \
  --initial-cluster "pg1=http://172.23.111.121:2380,pg2=http://172.23.111.122:2380,pg3=http://172.23.111.123:2380" \
  --initial-advertise-peer-urls http://172.23.111.121:2380 \
  --initial-cluster-token postgres-prod-etcd



# execute on server etcd pg2

sud systemctl stop etcd

sudo mv /var/lib/etcd /var/lib/etcd.old

sudo /usr/local/bin/etcdutl snapshot restore /tmp/save_snap.db \
  --name pg2 \
  --data-dir /var/lib/etcd \
  --initial-cluster "pg1=http://172.23.111.121:2380,pg2=http://172.23.111.122:2380,pg3=http://172.23.111.123:2380" \
  --initial-advertise-peer-urls http://172.23.111.122:2380 \
  --initial-cluster-token postgres-prod-etcd


# execute on server etcd pg3

sudo systemctl stop etcd

sudo mv /var/lib/etcd /var/lib/etcd.old

sudo /usr/local/bin/etcdutl snapshot restore /tmp/save_snap.db \
  --name pg3 \
  --data-dir /var/lib/etcd \
  --initial-cluster "pg1=http://172.23.111.121:2380,pg2=http://172.23.111.122:2380,pg3=http://172.23.111.123:2380" \
  --initial-advertise-peer-urls http://172.23.111.123:2380 \
  --initial-cluster-token postgres-prod-etcd

# start service etcd order 
sudo systemctl start etcd

# check etcd 

etcdctl endpoint status --cluster -w table
