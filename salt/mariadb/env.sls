include:
  - mariadb.install

mariadb-openstck-env:
  file.managed:
    - name: /root/openstack_env_mysql.sh
    - source: salt://mariadb/files/openstack_env_mysql.sh
    - user: root
    - group: root
    - mode: 755
  cmd.run:
    - name: /usr/bin/sh /root/openstack_env_mysql.sh && touch /etc/mariadb-openstack.lock
    - unless: test -f /etc/mariadb-openstack.lock
    - require: 
      - pkg: mariadb-install
