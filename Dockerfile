FROM debian:buster
#     //// update for fonctionalities  \\\\\\\
RUN apt-get update -y 

RUN apt-get install -y	systemd \
						wget \
						unzip \
						nginx \
						mariadb-server


#		////insltall php7.3 and all dependencies needed \\\\\\\\\

RUN	apt-get install -y php7.3 \
	php7.3-fpm \
	php7.3-mysql \
	php-common \
	php7.3-cli \
	php7.3-common \
	php7.3-json \
	php7.3-opcache \
	php7.3-readline \
	php7.3-xml \
	php7.3-mbstring 

#			////////// install phpmyadmin \\\\\\\\\\\\

RUN cd var/www/html && \
	wget https://www.phpmyadmin.net/downloads/phpMyAdmin-latest-all-languages.tar.gz && \
	tar -xf phpMyAdmin*.tar.gz && \
	mv phpMyAdmin-*-all-languages phpmyadmin && \
	rm phpMyAdmin-latest-all-languages.tar.gz


#			///////////install wordpress\\\\\\\\\\\\\
RUN cd var/www/html && \
	wget https://wordpress.org/latest.zip && \
	unzip latest.zip && \
	rm latest.zip

#		//////copy all config data to right folders\\\\\

RUN mkdir init

COPY srcs/init.sh init/init.sh
COPY srcs/default etc/nginx/sites-available/default
COPY srcs/default init/
COPY srcs/default_NA init/
COPY srcs/config.sample.inc.php var/www/html/phpmyadmin/config.inc.php
COPY srcs/wp-config-sample.php var/www/html/Wordpress/wp-config.php


run chmod 660 var/www/html/phpmyadmin/config.inc.php && \
	chown -R www-data:www-data /var/www/html/phpmyadmin && \
	chmod +x init/init.sh

EXPOSE 80 443

ENTRYPOINT bash init/init.sh && /bin/sh
