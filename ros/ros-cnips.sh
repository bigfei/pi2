#!/bin/bash
CNIPS=`curl -fsSL https://raw.githubusercontent.com/gaoyifan/china-operator-ip/ip-lists/china.txt | sed -e 's/^/add list=chnips address=/'`
cat > cnips.rsc << EOF
/ip firewall address-list remove [/ip firewall address-list find list=chnips]
/ip firewall address-list
$CNIPS
EOF
echo fetch china.txt ok
scp cnips.rsc bigfei@ros:/
ssh bigfei@ros "/import cnips.rsc"

scp cnips.rsc bigfei@hap:/
ssh bigfei@hap "/import cnips.rsc"

scp cnips.rsc admin@test-gw:/
ssh admin@test-gw "/import cnips.rsc"

