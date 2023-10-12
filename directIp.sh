#!/bin/bash
conf="<VirtualHost *:80>
        ServerAdmin webmaster@localhost
        DocumentRoot /var/www/abimanyu.f10
	ServerName abimanyu.f10.com

        ErrorLog \${APACHE_LOG_DIR}/error.log
        CustomLog \${APACHE_LOG_DIR}/access.log combined

</VirtualHost>

# vim: syntax=apache ts=4 sw=4 sts=4 sr noet"

echo "$conf" > /etc/apache2/sites-available/000-default.conf

service apache2 restart