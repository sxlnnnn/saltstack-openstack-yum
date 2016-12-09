#!/bin/sh
export OS_TOKEN=ADMIN
export OS_URL=http://{{ keystone }}:35357/v3
export OS_IDENTITY_API_VERSION=3


openstack project create --domain default --description "Admin Project" admin &&\
openstack user create --domain default --password admin admin &&\
openstack role create admin &&\
openstack role add --project admin --user admin admin &&\
openstack project create --domain default --description "Demo Project" demo &&\
openstack user create --domain default --password demo demo &&\
openstack role create user &&\
openstack role add --project demo --user demo user &&\
openstack project create --domain default --description "Service Project" service &&\
openstack service create --name keystone --description "OpenStack Identity" identity &&\
openstack endpoint create --region RegionOne identity public http://{{ keystone }}:5000/v2.0 &&\
openstack endpoint create --region RegionOne identity internal http://{{ keystone }}:5000/v2.0 &&\
openstack endpoint create --region RegionOne identity admin http://{{ keystone }}:35357/v2.0 


