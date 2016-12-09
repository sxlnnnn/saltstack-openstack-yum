include:
  - openstack.env

neutron-install:
  pkg.installed:
    - names:
       - openstack-neutron
       - openstack-neutron-linuxbridge
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

neutron-service:
    service.running:
    - names: 
      - neutron-linuxbridge-agent.service
    - enable: True      

