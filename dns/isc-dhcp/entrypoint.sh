#!/bin/sh
# set -x

rm -f /var/lib/dhcp/dhchp.leases
touch /var/lib/dhcp/dhcpd.leases
chown root:root /var/lib/dhcp/dhcpd.leases
chmod 666 /var/lib/dhcp/dhcpd.leases

dhcpd -d -f -cf /etc/dhcp/dhcpd.conf -lf /var/lib/dhcp/dhcpd.leases --no-pid
