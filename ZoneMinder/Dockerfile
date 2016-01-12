# ZoneMinder

FROM bigfei/rpi-ffmpeg:latest 
MAINTAINER Felix Xu <xuchenfei@gmail.com> 

# Let the container know that there is no tty
ENV DEBIAN_FRONTEND noninteractive
ENV ZM_VER 1.29.0

RUN mkdir /ZoneMinder && curl -SL https://github.com/ZoneMinder/ZoneMinder/releases/download/v1.29.0-rc2/ZoneMinder-$ZM_VER.tar.gz | tar -zxvf - -C /ZoneMinder --strip-components=1

# Resynchronize the package index files 
RUN apt-get update; apt-get install -y libpolkit-gobject-1-dev build-essential libmysqlclient-dev libssl-dev libbz2-dev libpcre3-dev libdbi-perl libarchive-zip-perl libdate-manip-perl libdevice-serialport-perl libmime-perl libpcre3 libwww-perl libdbd-mysql-perl libsys-mmap-perl yasm automake autoconf libjpeg8-dev libtheora-dev libvorbis-dev libvpx-dev libx264-dev libmp4v2-dev libav-tools mysql-client apache2 php5 php5-mysql apache2-mpm-prefork libapache2-mod-php5 php5-cli openssh-server mysql-server libvlc-dev libvlc5 libvlccore-dev libvlc5 libvlccore8 vlc-data libcurl4-openssl-dev libavformat-dev libswscale-dev libavutil-dev libavcodec-dev libavfilter-dev libavresample-dev libavdevice-dev libpostproc-dev libv4l-dev libtool libnetpbm10-dev libmime-lite-perl dh-autoreconf dpatch; apt-get clean

# Change into the ZoneMinder directory
WORKDIR /ZoneMinder

# Setup the ZoneMinder build environment
RUN aclocal && autoheader && automake --force-missing --add-missing && autoconf

# Configure ZoneMinder
RUN ./configure --with-mariadb --with-polkit --enable-onvif=yes --with-webdir=/var/www/zm --with-ffmpeg=/usr/local --with-extralibs="-L/usr/local/lib" --with-cgidir=/usr/lib/cgi-bin --with-webuser=www-data --with-webgroup=www-data --enable-mmap=yes --disable-debug --with-libarch=lib --with-mysql=/usr ZM_SSL_LIB=openssl ZM_DB_USER=zm ZM_DB_PASS=zm LIBS='-lx265 -lfdk-aac -lmp3lame -lvorbis -lvpx -lopus -ltheora -lswresample -lm -lz -ldl  -ltheoraenc -lvorbisenc -ltheoradec -ldl'

# Build ZoneMinder
RUN make &&  make install && make clean

## Adding the start script
#ADD utils/docker/start.sh /tmp/start.sh
#
## Ensure we can run this
## TODO - Files ADD'ed have 755 already...why do we need this?
#RUN chmod 755 /tmp/start.sh
#
## Creating SSH privledge escalation dir
#RUN mkdir /var/run/sshd
#
## Adding apache virtual hosts file
#ADD utils/docker/apache-vhost /etc/apache2/sites-enabled/000-default
#
## Set the root passwd
#RUN echo 'root:root' | chpasswd
#
## Expose ssh and http ports
#EXPOSE 80
#EXPOSE 22
#
#CMD "/tmp/start.sh"
