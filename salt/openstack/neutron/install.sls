include:
  - openstack.env

neutron-install:
  pkg.installed:
    - names:
       - openstack-neutron
       - openstack-neutron-ml2
       - openstack-neutron-linuxbridge
       - python-neutronclient
       - ebtables
       - ipset
  file.managed:
    - name: /etc/neutron/neutron.conf
    - source: salt://openstack/neutron/files/neutron.conf
    - user: root
    - group: root
    - mode: 644
    - template: jinja
    - defaults:
      mysql: {{ pillar['openstack']['mysql'] }}
      rabbitmq: {{ pillar['openstack']['rabbitmq'] }}
      keystone: {{ pillar['openstack']['keystone'] }}
      controller: {{ pillar['openstack']['controller'] }}

ml2_conf.ini:
  file.managed:
    - name: /etc/neutron/plugins/ml2/ml2_conf.ini
    - source: salt://openstack/neutron/files/ml2_conf.ini
  cmd.run:
    - name: ln -s /etc/neutron/plugins/ml2/ml2_conf.ini /etc/neutron/plugin.ini
    - unless: test -f /etc/neutron/plugin.ini

linuxbridge_agent.ini:
  file.managed:
    - name: /etc/neutron/plugins/ml2/linuxbridge_agent.ini
    - source: salt://openstack/neutron/files/linuxbridge_agent.ini

dhcp_agent.ini:
  file.managed:
    - name: /etc/neutron/dhcp_agent.ini
    - source: salt://openstack/neutron/files/dhcp_agent.ini

/etc/neutron/metadata_agent.ini:
  file.managed:
    - source: salt://openstack/neutron/files/metadata_agent.ini
    - template: jinja
    - defaults:
      keystone: {{ pillar['openstack']['keystone'] }}
      controller: {{ pillar['openstack']['controller'] }}

neutron-dbsync:
  file.managed:
    - name: /root/neutrondb_sync.sh
    - source: salt://openstack/neutron/files/neutrondb_sync.sh
    - user: root
    - group: root
    - mode: 755
  cmd.run:
    - name: /usr/bin/sh /root/neutrondb_sync.sh && touch /etc/neutron/dbsync.lock
    - unless: test -f /etc/neutron/dbsync.lock

neutron-reg:
  file.managed:
    - name: /root/neutron-reg.sh
    - source: salt://openstack/neutron/files/neutron-reg.sh
    - user: root
    - group: root
    - mode: 755
    - template: jinja
    - defaults:
      keystone: {{ pillar['openstack']['keystone'] }}
  cmd.run:
    - name: /usr/bin/sh /root/neutron-reg.sh && touch /etc/neutron/neutron-reg.lock
    - unless: test -f /etc/neutron/neutron-reg.lock

neutron-service:
    service.running:
    - names: 
      - neutron-server.service
      - neutron-linuxbridge-agent.service
      - neutron-dhcp-agent.service
      - neutron-metadata-agent.service
    - enable: True      

