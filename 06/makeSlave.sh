#!/bin/bash
zone="zone \"arjuna.f10.com\" {
	type slave;
    masters { 192.226.2.3; }; // IP YudhistiraDNSMaster
	file \"/etc/bind/jarkom/arjuna.f10.com\";
};

zone \"abimanyu.f10.com\" {
	type slave;
    masters { 192.226.2.3; }; // IP YudhistiraDNSMaster
	file \"/etc/bind/jarkom/abimanyu.f10.com\";
};

zone \"3.226.192.in-addr.arpa\" {
	type slave;
    masters { 192.226.2.3; }; // IP YudhistiraDNSMaster
	file \"/etc/bind/jarkom/3.226.192.in-addr.arpa\";
};"

echo "$zone" > /etc/bind/named.conf.local

service bind9 restart