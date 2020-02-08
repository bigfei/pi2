#!/bin/bash
ssh bigfei@ros ":put [/ip address get [find where interface=pppoe-uni] value-name=network]" >  whitelist-uni.txt
ssh bigfei@ros ":put [/ip address get [find where interface=pppoe-uni] value-name=address]" >>  whitelist-uni.txt
echo "whitelist is: "
cat whitelist-uni.txt

UNI=`curl -fsSL https://raw.githubusercontent.com/gaoyifan/china-operator-ip/ip-lists/unicom.txt | cidrmerge whitelist-uni.txt | sed -e 's/^/add list=uni address=/'`
cat > uni.rsc << EOF
/ip firewall address-list remove [/ip firewall address-list find list=uni]
/ip firewall address-list
$UNI
EOF

scp uni.rsc bigfei@ros:/
ssh bigfei@ros "/import uni.rsc"

