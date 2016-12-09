#!/bin/sh
export OS_TOKEN=ADMIN
export OS_URL=http://{{ keystone }}:35357/v3
export OS_IDENTITY_API_VERSION=3

openstack user create --domain default --password nova nova
openstack role add --project service --user nova admin
openstack service create --name nova --description "OpenStack Compute" compute
openstack endpoint create --region RegionOne compute public http://{{ keystone }}:8774/v2/%\(tenant_id\)s
openstack endpoint create --region RegionOne compute internal http://{{ keystone }}:8774/v2/%\(tenant_id\)s
openstack endpoint create --region RegionOne compute admin http://{{ keystone }}:8774/v2/%\(tenant_id\)s


