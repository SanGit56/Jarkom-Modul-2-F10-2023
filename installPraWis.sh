#!/bin/bash
echo nameserver 192.226.122.1 > /etc/resolv.conf
apt-get update
apt-get install dnsutils -y
apt-get install nginx -y
apt-get install php php-fpm -y
apt-get install wget unzip -y