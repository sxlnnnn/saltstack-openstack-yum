#!/bin/sh
export OS_TOKEN=ADMIN
export OS_URL=http://{{ keystone }}:35357/v3
export OS_IDENTITY_API_VERSION=3


openstack user create --domain default --password=cinder cinder
openstack role add --project service --user cinder admin
openstack service create --name cinder   --description "OpenStack Block Storage" volume
openstack service create --name cinderv2   --description "OpenStack Block Storage" volumev2
openstack endpoint create --region RegionOne   volume public http://{{ keystone }}:8776/v1/%\(tenant_id\)s
openstack endpoint create --region RegionOne   volume internal http://{{ keystone }}:8776/v1/%\(tenant_id\)s
openstack endpoint create --region RegionOne   volume admin http://{{ keystone }}:8776/v1/%\(tenant_id\)s
openstack endpoint create --region RegionOne   volumev2 public http://{{ keystone }}:8776/v2/%\(tenant_id\)s
openstack endpoint create --region RegionOne   volumev2 internal http://{{ keystone }}:8776/v2/%\(tenant_id\)s
openstack endpoint create --region RegionOne   volumev2 admin http://{{ keystone }}:8776/v2/%\(tenant_id\)s


