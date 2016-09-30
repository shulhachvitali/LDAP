#!/bin/sh
yum install epel-release -y
yum update -y
cat >> /etc/hosts <<EOF
192.168.33.95 ldapserver.mnt.lab
192.168.33.90 ldapclient.mnt.lab
EOF
