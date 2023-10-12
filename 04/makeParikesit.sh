#!/bin/bash
zone="zone \"arjuna.f10.com\" {
	type master;
	file \"/etc/bind/jarkom/arjuna.f10.com\";
};

zone \"abimanyu.f10.com\" {
	type master;
	file \"/etc/bind/jarkom/abimanyu.f10.com\";
};"

echo "$zone" > /etc/bind/named.conf.local

cp /etc/bind/db.local /etc/bind/jarkom/abimanyu.f10.com

conf=';
; BIND data file for local loopback interface
;
$TTL	604800
@	IN	SOA	abimanyu.f10.com. root.abimanyu.f10.com. (
			2023101101		; Serial
			604800		; Refresh
			86400			; Retry
			2419200		; Expire
			604800 )		; Negative Cache TTL
;
@		IN	NS		abimanyu.f10.com.
@		IN	A		192.226.3.3		; IP AbimanyuWebServer
www		IN	CNAME	abimanyu.f10.com.
parikesit	IN	A		192.226.3.3		; IP AbimanyuWebServer
@		IN	AAAA		::1'

echo "$conf" > /etc/bind/jarkom/abimanyu.f10.com

service bind9 restart