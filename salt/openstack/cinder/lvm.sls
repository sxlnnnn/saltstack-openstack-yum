cinder-lvm:
  file.append:
    - name: /etc/cinder/cinder.conf
    - text:
      - [lvm]
      - volume_driver = cinder.volume.drivers.lvm.LVMVolumeDriver
      - volume_group = cinder-volumes
      - iscsi_protocol = iscsi
      - iscsi_helper = lioadm
  cmd.run:
    - name: sed -i 's/#enabled_backends = <None>/enabled_backends = lvm/g'  /etc/cinder/cinder.conf
    - unless: grep 'enabled_backends = lvm' /etc/cinder/cinder.conf

