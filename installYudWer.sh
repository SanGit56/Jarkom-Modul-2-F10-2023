#!/bin/bash
echo nameserver 192.226.122.1 > /etc/resolv.conf
apt-get update
apt-get install bind9 -y