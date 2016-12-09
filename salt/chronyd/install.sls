chronyd-install:
  pkg.installed:
    - names:
      - chrony

chronyd-service:
  service.running:
    - name: chronyd.service
    - enable: True
