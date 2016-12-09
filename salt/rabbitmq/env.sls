include:
  - rabbitmq.install

rabbitmq-openstck-env:
  cmd.run:
    - name: rabbitmqctl add_user openstack openstack && rabbitmqctl set_permissions openstack ".*" ".*" ".*" && rabbitmq-plugins enable rabbitmq_management && touch /etc/rabbitmq/rabbitmq.lock
    - unless: test -f /etc/rabbitmq/rabbitmq.lock
