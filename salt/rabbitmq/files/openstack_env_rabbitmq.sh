#!/bin/sh
rabbitmqctl add_user openstack openstack && \
rabbitmqctl set_permissions openstack ".*" ".*" ".*" && \
rabbitmq-plugins enable rabbitmq_management && \
systemctl restart rabbitmq-server
