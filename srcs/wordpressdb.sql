CREATE DATABASE wordpressdb;
CREATE USER "wpadmin" IDENTIFIED BY 'wpadmin';
GRANT ALL PRIVILEGES ON wordpressdb.* TO 'wpadmin';
FLUSH PRIVILEGES;
