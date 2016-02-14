#!/bin/sh

ZM_VER=1.29.0

apt-get update; apt-get install -y libpolkit-gobject-1-dev build-essential libmysqlclient-dev libssl-dev libbz2-dev libpcre3-dev libdbi-perl libarchive-zip-perl libdate-manip-perl libdevice-serialport-perl libmime-perl libpcre3 libwww-perl libdbd-mysql-perl libsys-mmap-perl yasm automake autoconf libjpeg8-dev libtheora-dev libvorbis-dev libvpx-dev libx264-dev libmp4v2-dev libav-tools mysql-client apache2 php5 php5-mysql apache2-mpm-prefork libapache2-mod-php5 php5-cli php5-gd libvlc-dev libvlc5 libvlccore-dev libvlc5 libvlccore8 vlc-data libcurl4-openssl-dev libavformat-dev libswscale-dev libavutil-dev libavcodec-dev libavfilter-dev libavresample-dev libavdevice-dev libpostproc-dev libv4l-dev libtool libnetpbm10-dev libmime-lite-perl dh-autoreconf dpatch vim; apt-get clean

cd /
mkdir /ZoneMinder && curl -SL https://github.com/ZoneMinder/ZoneMinder/releases/download/v1.29.0/ZoneMinder-${ZM_VER}.tar.gz | tar -zxvf - -C /ZoneMinder --strip-components=1

cd /ZoneMinder

patch /ZoneMinder/src/CMakeLists.txt <<'EOF'
@@ -16,6 +16,12 @@
 add_executable(zms zms.cpp)
 add_executable(zmstreamer zmstreamer.cpp)

+FOREACH (LIB ${ZM_EXTRA_LIBS})
+    UNSET(FOUND_LIB CACHE)
+    FIND_LIBRARY(FOUND_LIB ${LIB})
+    list(APPEND ZM_BIN_LIBS ${FOUND_LIB})
+ENDFOREACH(LIB)
+
 target_link_libraries(zmc zm ${ZM_EXTRA_LIBS} ${ZM_BIN_LIBS})
 target_link_libraries(zma zm ${ZM_EXTRA_LIBS} ${ZM_BIN_LIBS})
 target_link_libraries(zmu zm ${ZM_EXTRA_LIBS} ${ZM_BIN_LIBS})
EOF

cmake -DCMAKE_INSTALL_PREFIX:PATH=/usr/local -DZM_DB_USER=zm -DZM_DB_PASS=zmpass -DZM_DB_HOST=zm-mysql -DZM_EXTRA_LIBS="fdk-aac;mp3lame;vorbis;vpx;opus;swresample;x264;vorbisenc;theoraenc;theoradec;ogg"  .
make -j4
make install

cd /ZoneMinder
/ZoneMinder/zmlinkcontent.sh -z /etc/zm.conf

chown -R www-data:www-data /usr/local/share/zoneminder /usr/local/libexec/zoneminder/cgi-bin
adduser www-data video
sed -i 's/\;date.timezone =/date.timezone = \"Asia\/Shanghai\"/' /etc/php5/apache2/php.ini

strip -s /usr/local/bin/zm?

apt-get clean
rm -rf /tmp/* /var/tmp/*
rm -rf /var/lib/apt/lists/*
