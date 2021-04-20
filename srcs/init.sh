#!/bin/bash
if [ "$INDEX" == "0" ]
then
	bash start/autoindexoff.sh
else 
	echo "autoindex on"
	service nginx reload
	service nginx restart
	service mysql start
	service php7.3-fpm start
fi
