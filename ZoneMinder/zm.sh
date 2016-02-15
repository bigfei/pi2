#!/bin/bash
mkdir -p /var/tmp/zm
chown www-data:www-data /var/tmp/zm

umount /dev/shm
mount -t tmpfs -o rw,nosuid,nodev,noexec,relatime,size=${MEM:-512M} tmpfs /dev/shm

# Apache
a2enconf zoneminder
a2enmod cgi
a2enmod rewrite

/usr/local/bin/zmpkg.pl start
source /etc/apache2/envvars
exec apache2ctl -D FOREGROUND >>/var/log/apache2.log 
