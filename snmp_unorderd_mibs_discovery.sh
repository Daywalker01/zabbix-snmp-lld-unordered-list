#!/bin/bash

snmp_community=$2
host=$1
snmp_oid=$3


if [ -z ${host} ]; then host=hostname.example.org; fi
if [ -z ${snmp_community} ]; then snmp_community=public; fi
if [ -z ${snmp_oid} ]; then snmp_oid=".1.3.6.1.4.1.2620.500.9002.1"; fi

first=1
echo "["
IFS='
' # split on newline
for entrie in $(snmpbulkwalk -v2c -Cc -On -c ${snmp_community} ${host} ${snmp_oid}.2); do
        if [[ ${first} -eq 0 ]]; then echo -e "\t,\n"; fi
        first=0

        echo "${entrie}" | awk -F= '{gsub('/${snmp_vpn_oid}\.2\./',"",$1); 
        gsub(/\.0 /,"",$1); 
        gsub(/ STRING: /,"",$2); 
        gsub(/"/,"",$2); 
        print "\t{\n\t\t\"{#OID}\":\""$1"\",\n\t\t\"{#VALUE}\":\""$2"\"\n\t}\n"}'

done

echo "]"
