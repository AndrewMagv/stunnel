#!/bin/sh

PREFIX=s3://devops.magv.com/launch-config/tlsproxy

# configuration for connecting to REDIS
aws s3 cp --region ${NODE_REGION} ${PREFIX}/redis-server.conf /etc/stunnel/proxy.conf

# obtain TLS connection options
aws s3 cp --region ${NODE_REGION} ${PREFIX}/ca.pem /cert/ca.pem
aws s3 cp --region ${NODE_REGION} ${PREFIX}/server-key.pem /cert/server-key.pem
aws s3 cp --region ${NODE_REGION} ${PREFIX}/server-cert.pem /cert/server-cert.pem

# download trusted cert and hash
rm -f /trusted/*
aws s3 cp --region ${NODE_REGION} ${PREFIX}/cert.pem /trusted/cert.pem
HASHVALUE=$(openssl x509 -noout -hash -in /trusted/cert.pem)
ln -s /trusted/cert.pem /trusted/${HASHVALUE}.0
