#!/bin/bash
CNIPS=`cat us.txt | sed -e 's/^/add list=usips address=/'`
cat > usips.rsc << EOF
/ip firewall address-list remove [/ip firewall address-list find list=usips]
/ip firewall address-list
$CNIPS
EOF
echo fetch us.txt ok
scp usips.rsc bigfei@ros:/
ssh bigfei@ros "/import usips.rsc"

