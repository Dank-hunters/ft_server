#!/bin/bash
	sed -i "s/autoindex on;/autoindex off;/" /etc/nginx/sites-available/default
	sed -i "s/index index.html;/try_files \$uri \$uri\/ =404;/" /etc/nginx/sites-available/default
	echo "autoindex off"
	service nginx reload
	service nginx restart
	service mysql start
	service php7.3-fpm start
	service php7.3-fpm restart
