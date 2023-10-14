apt-get update && apt install nginx php php-fpm -y
wget -O '/var/www/arjuna.f10.com.zip' 'https://drive.usercontent.google.com/download?id=17tAM_XDKYWDvF-JJix1x7txvTBEax7vX'
unzip /var/www/arjuna.f10.com.zip -d /var/www/
mv /var/www/arjuna.yyy.com /var/www/arjuna.f10
rm /var/www/arjuna.f10.com.zip

service php7.0-fpm start

conf='server {

	listen 8002;

	root /var/www/arjuna.f10;

	index index.php index.html index.htm;
	server_name _;

	location / {
			try_files $uri $uri/ /index.php?$query_string;
	}

	# pass PHP scripts to FastCGI server
	location ~ \.php$ {
	include snippets/fastcgi-php.conf;
	fastcgi_pass unix:/run/php/php7.0-fpm.sock;
	}

location ~ /\.ht {
			deny all;
	}

	error_log /var/log/nginx/jarkom_error.log;
	access_log /var/log/nginx/jarkom_access.log;
}'

echo "$conf" > /etc/nginx/sites-available/arjuna

ln -s /etc/nginx/sites-available/arjuna /etc/nginx/sites-enabled
rm /etc/nginx/site-enabled/default

service nginx restart