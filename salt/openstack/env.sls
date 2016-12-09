openstack_liberty_yum:
  file.managed:
    - name: /etc/yum.repos.d/openstack_liberty.repo
    - source: salt://openstack/files/openstack_liberty.repo
    - user: root
    - group: root
    - mode: 644  

CentOS_Base_aliyun:
  file.managed:
    - name: /etc/yum.repos.d/CentOS-Base.repo
    - source: salt://openstack/files/CentOS-Base.repo
    - user: root
    - group: root
    - mode: 644  

epel_yum_aliyun:
  file.managed:
    - name: /etc/yum.repos.d/epel.repo
    - source: salt://openstack/files/epel.repo
    - user: root
    - group: root
    - mode: 644  

admin-openrc:
  file.managed:
    - name: /root/admin-openrc.sh
    - source: salt://openstack/files/admin-openrc.sh
    - user: root
    - group: root
    - mode: 755
    - template: jinja
    - defaults:
      keystone: {{ pillar['openstack']['keystone'] }}

demo-openrc:
  file.managed:
    - name: /root/demo-openrc.sh
    - source: salt://openstack/files/demo-openrc.sh
    - user: root
    - group: root
    - mode: 755
    - template: jinja
    - defaults:
      keystone: {{ pillar['openstack']['keystone'] }}
