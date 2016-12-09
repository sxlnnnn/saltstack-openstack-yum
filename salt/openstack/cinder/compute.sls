include:
  - openstack.env

cinder-install:
  pkg.installed:
    - names:
       - python-oslo-policy  
       - openstack-cinder
       - targetcli
       - lvm2
  file.managed:
    - name: /etc/cinder/cinder.conf
    - source: salt://openstack/cinder/files/cinder.conf
    - user: root
    - group: root
    - mode: 644
    - template: jinja
    - defaults:
      glance: {{ pillar['openstack']['glance'] }}
      mysql: {{ pillar['openstack']['mysql'] }}
      keystone: {{ pillar['openstack']['keystone'] }}
      rabbitmq: {{ pillar['openstack']['rabbitmq'] }}

cinder-service:
  service.running:
    - names:
      - openstack-cinder-volume
      - target
      - lvm2-lvmetad.service
    - enable: True
    - watch:
      - file: /etc/cinder/cinder.conf
