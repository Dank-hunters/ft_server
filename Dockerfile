FROM debian:buster

RUN apt-get update -y && \
	apt-get install -y php7.3 \
	php7.3-fpm \
	php7.3-mysql \
	php-common \
	php7.3-cli \
	php7.3-common \
	php7.3-json \
	php7.3-opcache \
	php7.3-readline \
	php7.3-xm 

RUN apt-get install nginx -y \
	&& apt-get install mariadb-server mariadb-client -y 
