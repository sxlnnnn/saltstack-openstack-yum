#!/bin/sh
export OS_TOKEN=ADMIN
export OS_URL=http://{{ keystone }}:35357/v3
export OS_IDENTITY_API_VERSION=3

openstack user create --domain default --password neutron neutron &&\
openstack role add --project service --user neutron admin &&\
openstack service create --name neutron --description "OpenStack Networking" network &&\
openstack endpoint create --region RegionOne network public http://{{ keystone }}:9696 &&\
openstack endpoint create --region RegionOne network internal http://{{ keystone }}:9696 &&\
openstack endpoint create --region RegionOne network admin http://{{ keystone }}:9696 &&\
touch /etc/neutron/neutron-reg.lock


