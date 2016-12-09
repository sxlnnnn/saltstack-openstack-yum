httpd-install:
  pkg.installed:
    - names:
      - httpd

httpd-service:
  service.running:
    - name: httpd.service
    - enable: True
