#!/bin/bash
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
@		IN	NS	abimanyu.f10.com.
@		IN	A	192.226.3.3		; IP AbimanyuWebServer
www		IN	CNAME	abimanyu.f10.com.
parikesit	IN	A	192.226.3.3		; IP AbimanyuWebServer
ns1		IN	A	192.226.2.2		; IP WerkudaraDNSSlave
baratayuda	IN	NS	ns1
@		IN	AAAA	::1'

echo "$conf" > /etc/bind/jarkom/abimanyu.f10.com

option="options {
        directory \"/var/cache/bind\";

        // If there is a firewall between you and nameservers you want
        // to talk to, you may need to fix the firewall to allow multiple
        // ports to talk.  See http://www.kb.cert.org/vuls/id/800113

        // If your ISP provided one or more IP addresses for stable
        // nameservers, you probably want to use them as forwarders.
        // Uncomment the following block, and insert the addresses replacing
        // the all-0\'s placeholder.

        // forwarders {
        //      0.0.0.0;
        // };

        //========================================================================
        // If BIND logs error messages about the root key being expired,
        // you will need to update your keys.  See https://www.isc.org/bind-keys
        //========================================================================
        //dnssec-validation auto;
	    allow-query{any;};

        auth-nxdomain no;    # conform to RFC1035
        listen-on-v6 { any; };
};"

echo "$option" > /etc/bind/named.conf.options

service bind9 restart