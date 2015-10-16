#!/bin/sh

if [ -z "$1" ]; then
    echo "No config script specified..."
    exit 1
fi

if [ -f /etc/environ ]; then
    # setup necessary host environments
    . /etc/environ
fi

# pull down init script from launch-config/tlsproxy
aws s3 cp --region ${NODE_REGION} s3://devops.magv.com/launch-config/tlsproxy/$1 /tmp/proxy-init.sh

# launch proxy init
NODE_REGION=${NODE_REGION} sh /tmp/proxy-init.sh

# invoke stunnel with TLS proxy config
exec /usr/bin/stunnel4 /etc/stunnel/proxy.conf
