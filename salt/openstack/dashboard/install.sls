include:
  - openstack.env

dashboard-install:
  pkg.installed:
    - names:
       - openstack-dashboard
  file.managed:
    - name: /etc/openstack-dashboard/local_settings
    - source: salt://openstack/dashboard/files/local_settings
    - template: jinja
    - defaults:
      keystone: {{ pillar['openstack']['keystone'] }}
      memcache: {{ pillar['openstack']['memcache'] }}
  service.running:
    - name: httpd
    - reload: True
    - enable: True
    - watch:
      - file: /etc/openstack-dashboard/local_settings      
