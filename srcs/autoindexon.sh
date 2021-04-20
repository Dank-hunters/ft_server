#!/bin/bash
	sed -i "s/autoindex off;/autoindex on;/" /etc/nginx/sites-available/default
	sed -i "s/try_files \$uri \$uri\/ =404;/index index.html;/" /etc/nginx/sites-available/default
echo "autoindex on"
service nginx reload
service nginx restart
service mysql start
service php7.3-fpm restart
