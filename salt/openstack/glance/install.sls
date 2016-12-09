include:
  - openstack.env

glance-install:
  pkg.installed:
    - names:
       - openstack-glance
       - python-glance
       - python-glanceclient

glance-api:
  file.managed:
    - name: /etc/glance/glance-api.conf
    - source: salt://openstack/glance/files/glance-api.conf
    - user: root
    - group: root
    - mode: 644
    - template: jinja
    - defaults:
      mysql: {{ pillar['openstack']['mysql'] }}
      keystone: {{ pillar['openstack']['keystone'] }}
         

glance-registry:
    file.managed:
    - name: /etc/glance/glance-registry.conf
    - source: salt://openstack/glance/files/glance-registry.conf
    - user: root
    - group: root
    - mode: 644
    - template: jinja
    - defaults:
      mysql: {{ pillar['openstack']['mysql'] }}
      keystone: {{ pillar['openstack']['keystone'] }}

glance-dbsync:
  file.managed:
    - name: /root/glancedb_sync.sh
    - source: salt://openstack/glance/files/glancedb_sync.sh
    - user: root
    - group: root
    - mode: 755
    - template: jinja
    - defaults:
      keystone: {{ pillar['openstack']['keystone'] }}
  cmd.run:
    - name: /usr/bin/sh /root/glancedb_sync.sh && touch /etc/glance/dbsync.lock
    - unless: test -f /etc/glance/dbsync.lock

glance-reg:
  file.managed:
    - name: /root/glance-reg.sh
    - source: salt://openstack/glance/files/glance-reg.sh
    - user: root
    - group: root
    - mode: 755
    - template: jinja
    - defaults:
      keystone: {{ pillar['openstack']['keystone'] }}
  cmd.run:
    - name: /usr/bin/sh /root/glance-reg.sh && touch /etc/glance/glance-reg.lock
    - unless: test -f /etc/glance/glance-reg.lock

glance-api-service:
  service.running:
    - name: openstack-glance-api
    - enable: True
    - watch:
      - file: glance-api

glance-registry-service:  
  service.running:
    - name: openstack-glance-registry
    - enable: True
    - watch:
      - file: glance-registry

