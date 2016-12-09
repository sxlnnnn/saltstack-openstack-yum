#!/bin/sh
su -s /bin/sh -c "cinder-manage db sync" cinder
