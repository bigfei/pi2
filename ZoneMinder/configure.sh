#!/bin/sh
cd /ZoneMinder

#Mysql
service mysql restart


# Apache
a2enmod cgi
service apache2 restart

