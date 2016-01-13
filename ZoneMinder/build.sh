#!/bin/sh

ZM_VER=1.29.0

apt-get update; apt-get install -y libpolkit-gobject-1-dev build-essential libmysqlclient-dev libssl-dev libbz2-dev libpcre3-dev libdbi-perl libarchive-zip-perl libdate-manip-perl libdevice-serialport-perl libmime-perl libpcre3 libwww-perl libdbd-mysql-perl libsys-mmap-perl yasm automake autoconf libjpeg8-dev libtheora-dev libvorbis-dev libvpx-dev libx264-dev libmp4v2-dev libav-tools mysql-client apache2 php5 php5-mysql apache2-mpm-prefork libapache2-mod-php5 php5-cli openssh-server mysql-server libvlc-dev libvlc5 libvlccore-dev libvlc5 libvlccore8 vlc-data libcurl4-openssl-dev libavformat-dev libswscale-dev libavutil-dev libavcodec-dev libavfilter-dev libavresample-dev libavdevice-dev libpostproc-dev libv4l-dev libtool libnetpbm10-dev libmime-lite-perl dh-autoreconf dpatch; apt-get clean

cd /
mkdir /ZoneMinder && curl -SL https://github.com/ZoneMinder/ZoneMinder/releases/download/v1.29.0-rc2/ZoneMinder-${ZM_VER}.tar.gz | tar -zxvf - -C /ZoneMinder --strip-components=1

cd /ZoneMinder
aclocal && autoheader && automake --force-missing --add-missing && autoconf
./configure --with-mariadb --with-polkit --enable-onvif=yes --with-webdir=/var/www/zm --with-ffmpeg=/usr/local --with-extralibs="-L/usr/local/lib" --with-cgidir=/usr/lib/cgi-bin --with-webuser=www-data --with-webgroup=www-data --enable-mmap=yes --disable-debug --with-libarch=lib --with-mysql=/usr ZM_SSL_LIB=openssl ZM_DB_USER=zm ZM_DB_PASS=zm LIBS='-lx265 -lfdk-aac -lmp3lame -lvorbis -lvpx -lopus -ltheora -lswresample -lm -lz -ldl  -ltheoraenc -lvorbisenc -ltheoradec -ldl'
make -j8 
make install 
make clean

strip -s /usr/local/bin/zm?
