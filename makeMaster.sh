#!/bin/bash
zone="zone \"arjuna.f10.com\" {
	type master;
    notify yes;
	also-notify { 192.226.2.2; };	// IP WerkudaraDNSSlave
    allow-transfer { 192.226.2.2; };	// IP WerkudaraDNSSlave
	file \"/etc/bind/jarkom/arjuna.f10.com\";
};

zone \"abimanyu.f10.com\" {
	type master;
    notify yes;
	also-notify { 192.226.2.2; };	// IP WerkudaraDNSSlave
    allow-transfer { 192.226.2.2; };	// IP WerkudaraDNSSlave
	file \"/etc/bind/jarkom/abimanyu.f10.com\";
};

zone \"3.226.192.in-addr.arpa\" {
    type master;
	notify yes;
	also-notify { 192.226.2.2; };	// IP WerkudaraDNSSlave
    allow-transfer { 192.226.2.2; };	// IP WerkudaraDNSSlave
    file \"/etc/bind/jarkom/3.226.192.in-addr.arpa\";
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

cp /etc/bind/db.local /etc/bind/jarkom/3.226.192.in-addr.arpa

revConf=';
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
3.226.192.in-addr.arpa.	IN	NS	abimanyu.f10.com.
3				IN	PTR	abimanyu.f10.com.	; Byte ke-4 AbimanyuWebServer'

echo "$revConf" > /etc/bind/jarkom/3.226.192.in-addr.arpa

service bind9 restart