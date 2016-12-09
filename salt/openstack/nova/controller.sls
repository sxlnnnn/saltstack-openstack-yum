include:
  - openstack.env

nova-install:
  pkg.installed:
    - names:
       - openstack-nova-api
       - openstack-nova-cert
       - openstack-nova-conductor
       - openstack-nova-console
       - openstack-nova-novncproxy
       - openstack-nova-scheduler
       - python-novaclient     
  file.managed:
    - name: /etc/nova/nova.conf
    - source: salt://openstack/nova/files/nova.conf
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

nova-dbsync:
  file.managed:
    - name: /root/novadb_sync.sh
    - source: salt://openstack/nova/files/novadb_sync.sh
    - user: root
    - group: root
    - mode: 755
  cmd.run:
    - name: /usr/bin/sh /root/novadb_sync.sh && touch /etc/nova/dbsync.lock
    - unless: test -f /etc/nova/dbsync.lock

nova-reg:
  file.managed:
    - name: /root/nova-reg.sh
    - source: salt://openstack/nova/files/nova-reg.sh
    - user: root
    - group: root
    - mode: 755
    - template: jinja
    - defaults:
      keystone: {{ pillar['openstack']['keystone'] }}
  cmd.run:
    - name: /usr/bin/sh /root/nova-reg.sh && touch /etc/nova/nova-reg.lock
    - unless: test -f /etc/nova/nova-reg.lock

nova-service:
    service.running:
    - names: 
      - openstack-nova-api.service
      - openstack-nova-cert.service
      - openstack-nova-consoleauth.service
      - openstack-nova-scheduler.service
      - openstack-nova-conductor.service
      - openstack-nova-novncproxy.service   
    - enable: True      

