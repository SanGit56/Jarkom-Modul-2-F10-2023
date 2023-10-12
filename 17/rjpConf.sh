#!/bin/bash
cp /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/rjp.baratayuda.abimanyu.f10.conf
wget -O '/var/www/rjp.baratayuda.abimanyu.f10.com.zip' 'https://drive.usercontent.google.com/download?id=1pPSP7yIR05JhSFG67RVzgkb-VcW9vQO6'
unzip /var/www/rjp.baratayuda.abimanyu.f10.com.zip -d /var/www/
rm -r /var/www/rjp.baratayuda.abimanyu.f10
mv /var/www/rjp.baratayuda.abimanyu.yyy.com /var/www/rjp.baratayuda.abimanyu.f10
rm /var/www/rjp.baratayuda.abimanyu.f10.com.zip

conf="<VirtualHost *:14000 *:14400>
        # The ServerName directive sets the request scheme, hostname and port that
        # the server uses to identify itself. This is used when creating
        # redirection URLs. In the context of virtual hosts, the ServerName
        # specifies what hostname must appear in the request's Host: header to
        # match this virtual host. For the default virtual host (this file) this
        # value is not decisive as it is used as a last resort host regardless.
        # However, you must set it for any further virtual host explicitly.
        #ServerName www.example.com

        ServerAdmin webmaster@localhost
        DocumentRoot /var/www/rjp.baratayuda.abimanyu.f10
	ServerName rjp.baratayuda.abimanyu.f10.com
	ServerAlias www.rjp.baratayuda.abimanyu.f10.com	

        # Available loglevels: trace8, ..., trace1, debug, info, notice, warn,
        # error, crit, alert, emerg.
        # It is also possible to configure the loglevel for particular
        # modules, e.g.
        #LogLevel info ssl:warn

        ErrorLog \${APACHE_LOG_DIR}/error.log
        CustomLog \${APACHE_LOG_DIR}/access.log combined

        # For most configuration files from conf-available/, which are
        # enabled or disabled at a global level, it is possible to
        # include a line for only one particular virtual host. For example the
        # following line enables the CGI configuration for this host only
        # after it has been globally disabled with \"a2disconf\".
        #Include conf-available/serve-cgi-bin.conf
</VirtualHost>

# vim: syntax=apache ts=4 sw=4 sts=4 sr noet"

echo "$conf" > /etc/apache2/sites-available/rjp.baratayuda.abimanyu.f10.conf

port="# If you just change the port or add more ports here, you will likely also
# have to change the VirtualHost statement in
# /etc/apache2/sites-enabled/000-default.conf

Listen 80
Listen 14000
Listen 14400

<IfModule ssl_module>
        Listen 443
</IfModule>

<IfModule mod_gnutls.c>
        Listen 443
</IfModule>

# vim: syntax=apache ts=4 sw=4 sts=4 sr noet"

echo "$port" > /etc/apache2/ports.conf

a2ensite rjp.baratayuda.abimanyu.f10.conf
service apache2 restart