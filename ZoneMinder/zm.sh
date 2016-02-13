#!/bin/sh

umount /dev/shm
mount -t tmpfs -o rw,nosuid,nodev,noexec,relatime,size=${MEM:-512M} tmpfs /dev/shm

# Apache
a2enconf zoneminder
a2enmod cgi
a2enmod rewrite

service apache2 restart
/usr/local/bin/zmpkg.pl start

