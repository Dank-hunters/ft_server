FROM debian:buster
#     //// update for fonctionalities  \\\\\\\
RUN mkdir start
RUN apt-get update -y 

RUN apt-get install -y	wget  -y\
						unzip -y\
						nginx -y\
						mariadb-server -y\
						systemd -y


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
COPY srcs/config.sample.inc.php var/www/html/phpmyadmin/config.inc.php

#         //////////initialisation base de donnee \\\\\\\\\\\\\\
COPY srcs/wordpressdb.sql /etc/init.d/wordpressdb.sql
RUN    service mysql start && \
    mysql -u root < /etc/init.d/wordpressdb.sql


#			///////////install wordpress\\\\\\\\\\\\\
RUN cd var/www/html && \
	wget https://wordpress.org/latest.zip && \
	unzip latest.zip && \
	rm latest.zip
COPY srcs/wp-config-sample.php var/www/html/wordpress/wp-config.php

#		///////Place certivicate and key for ssl\\\\\\
COPY srcs/server.crt /etc/ssl/certs/server.crt 
COPY srcs/server.key /etc/ssl/private/server.key
	

#		//////copy config data to right folders\\\\\
COPY srcs/default etc/nginx/sites-available/default
COPY srcs/init.sh start/init.sh
COPY srcs/autoindexon.sh start/
COPY srcs/autoindexoff.sh start/

RUN chmod 660 var/www/html/phpmyadmin/config.inc.php && \
	chown -R www-data:www-data /var/www/html/phpmyadmin 

EXPOSE 80 443

ENTRYPOINT bash start/init.sh && /bin/bash
