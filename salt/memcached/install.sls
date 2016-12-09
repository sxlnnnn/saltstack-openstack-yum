memcached-install:
  pkg.installed:
    - names:
      - memcached
      - python-memcached

memcached-service:
  service.running:
    - name: memcached.service
    - enable: True
