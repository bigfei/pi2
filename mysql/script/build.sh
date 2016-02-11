#!/bin/sh
MYSQL_VERSION=5.5
apt-get update
apt-get dist-upgrade

apt-get install -y perl --no-install-recommends 
apt-get install -y libaio1 pwgen 

{ \
		echo mysql-server mysql-server/data-dir select ''; \
		echo mysql-server mysql-server/root-pass password ''; \
		echo mysql-server mysql-server/re-root-pass password ''; \
		echo mysql-server mysql-server/remove-test-db select false; \
	} | debconf-set-selections 
apt-get install -y mysql-server="${MYSQL_VERSION}"* 
apt-get clean && rm -rf /var/lib/apt/lists/*

rm -rf /var/lib/mysql && mkdir -p /var/lib/mysql && chown -R mysql:mysql /var/lib/mysql
sed -Ei 's/^(bind-address|log)/#&/' /etc/mysql/my.cnf
