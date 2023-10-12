#!/bin/bash
zone="zone \"arjuna.f10.com\" {
	type master;
	file \"/etc/bind/jarkom/arjuna.f10.com\";
};"

echo "$zone" > /etc/bind/named.conf.local

mkdir /etc/bind/jarkom
cp /etc/bind/db.local /etc/bind/jarkom/arjuna.f10.com

conf=';
; BIND data file for local loopback interface
;
$TTL	604800
@	IN	SOA	arjuna.f10.com. root.arjuna.f10.com. (
			2022100601		; Serial
			604800		; Refresh
			86400			; Retry
			2419200		; Expire
			604800 )		; Negative Cache TTL
;
@	IN	NS		arjuna.f10.com.
@	IN	A		192.226.1.4		; IP ArjunaLoadBalancer
www	IN	CNAME	arjuna.f10.com.
@	IN	AAAA		::1'

echo "$conf" > /etc/bind/jarkom/arjuna.f10.com

service bind9 restart