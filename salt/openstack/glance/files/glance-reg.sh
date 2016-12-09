#!/bin/sh
export OS_TOKEN=ADMIN
export OS_URL=http://{{ keystone }}:35357/v3
export OS_IDENTITY_API_VERSION=3


openstack user create --domain default --password glance glance &&\
openstack role add --project service --user glance admin  &&\
openstack service create --name glance  --description "OpenStack Image service" image &&\
openstack endpoint create --region RegionOne  image public http://{{ keystone }}:9292  &&\
openstack endpoint create --region RegionOne  image internal http://{{ keystone }}:9292 &&\
openstack endpoint create --region RegionOne  image admin http://{{ keystone }}:9292 


