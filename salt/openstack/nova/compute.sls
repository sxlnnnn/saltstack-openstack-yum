include:
  - openstack.env

nova-install:
  pkg.installed:
    - names:
       - openstack-nova-compute
       - python-openstackclient
       - openstack-utils
       - sysfsutils
  file.managed:
    - name: /etc/nova/nova.conf
    - source: salt://openstack/nova/files/nova-computer.conf
    - user: root
    - group: root
    - mode: 644
    - template: jinja
    - defaults:
      mysql: {{ pillar['openstack']['mysql'] }}
      rabbitmq: {{ pillar['openstack']['rabbitmq'] }}
      keystone: {{ pillar['openstack']['keystone'] }}
      glance: {{ pillar['openstack']['glance'] }}
      neutron: {{ pillar['openstack']['neutron'] }}
      controller: {{ pillar['openstack']['controller'] }}
      computer: {{ pillar['openstack']['computer'] }}
      
nova-service:
    service.running:
    - names: 
      - libvirtd.service
      - openstack-nova-compute.service
    - enable: True      

