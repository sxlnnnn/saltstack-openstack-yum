rabbitmq-install:
  pkg.installed:
    - names:
      - rabbitmq-server

rabbitmq-service:
  service.running:
    - name: rabbitmq-server.service
    - enable: True
