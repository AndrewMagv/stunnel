#!/bin/sh

if [ -f /etc/environ ]; then
    # setup necessary host environments
    . /etc/environ
fi

# pull down init script from launch-config/tlsproxy
URL="https://raw.githubusercontent.com/AndrewMagv/aws-devops/${REF}"
curl -sSL -O ${URL}/proxy-init.sh
chmod +x proxy-init.sh

# launch proxy init
NODE_REGION=${NODE_REGION} ./proxy-init.sh $@

# invoke stunnel with TLS proxy config
exec /usr/bin/stunnel4 /proxy.conf
