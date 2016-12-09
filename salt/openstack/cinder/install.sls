include:
  - openstack.env

cinder-install:
  pkg.installed:
    - names:
       - openstack-cinder
       - python-cinderclient
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

cinder-dbsync:
  file.managed:
    - name: /root/cinderdb_sync.sh
    - source: salt://openstack/cinder/files/cinderdb_sync.sh
    - user: root
    - group: root
    - mode: 755
  cmd.run:
    - name: /usr/bin/sh /root/cinderdb_sync.sh && touch /etc/cinder/dbsync.lock
    - unless: test -f /etc/cinder/dbsync.lock

cinder-reg:
  file.managed:
    - name: /root/cinder-reg.sh
    - source: salt://openstack/cinder/files/cinder-reg.sh
    - user: root
    - group: root
    - mode: 755
    - template: jinja
    - defaults:
      keystone: {{ pillar['openstack']['keystone'] }}
  cmd.run:
    - name: /usr/bin/sh /root/cinder-reg.sh && touch /etc/cinder/cinder-reg.lock
    - unless: test -f /etc/cinder/cinder-reg.lock

cinder-service:
  service.running:
    - names:
      - openstack-cinder-api
      - openstack-cinder-scheduler
    - enable: True
    - watch:
      - file: /etc/cinder/cinder.conf
