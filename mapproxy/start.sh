#!/bin/bash
USER_ID=`ls -lahn / | grep mapproxy | awk '{print $3}'`
GROUP_ID=`ls -lahn / | grep mapproxy | awk '{print $4}'`
USER_NAME=`ls -lah / | grep mapproxy | awk '{print $3}'`

groupadd -g $GROUP_ID mapproxy
useradd --shell /bin/bash --uid $USER_ID --gid $GROUP_ID $USER_NAME

# MapProxy config, and the app.py will be provided in the target machine via EFS
# TODO initialise the MapProxy config from git in the event of a completely new environment

# Ensure www-data user has privs to access mapproxy dir
chgrp www-data mapproxy

# Run MapProxy using uwsgi/nginx
su $USER_NAME -c "uwsgi --ini /uwsgi.ini"

# serve-develop is a test service for publishing a mapproxy config without a web server, which may be helpful for
# debugging
#su $USER_NAME -c "mapproxy-util serve-develop -b 0.0.0.0:8080 mapproxy.yaml"
