使用salt安装后cinder-volume默认采用lvm驱动，并不需要调用lvm.sls，所以并没有使用它。
但是安装后使用cinder service-list命令时，你会发现cinder-volume状态是down，这是因为没有创建卷。

cinder-volume服务器上创建卷

pvcreate /dev/sdb 
vgcreate cinder-volumes /dev/sdb

vim /etc/lvm/lvm.conf
filter = [ "a/sdb/", "r/.*/"]

systemctl start openstack-cinder-volume.service

