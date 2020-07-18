# Zabbix SNMP unordered list LLD script
I have created this script in order to mitigate the SNMP LLD issue `"Invalid SNMP OID at position X"` that ocures when you walk down a tree that does not seem to return an ordered list that the snmplibrary does expect.

On the commandline the option `-Cc` does mitigate the option

### The issue
Example output with `snmpwalk` on affected SNMP tree that I have encountered wile trying to create a LLD for a Checkpoint Firewall.

    # snmpbulkwalk -v2c -c public -On hostname.example.org .1.3.6.1.4.1.2620.500.9002.1.2.1.3.6.1.4.1.2620.500.9002.1.2.19.11.10.1.0 = STRING: "peernameX"  
    .1.3.6.1.4.1.2620.500.9002.1.2.9.6.19.6.0 = STRING: "peernameX"  
    .1.3.6.1.4.1.2620.500.9002.1.2.21.7.8.6.0 = STRING: "peernameX"  
    .1.3.6.1.4.1.2620.500.9002.1.2.8.1.1.4.0 = STRING: "peernameX"  
    .1.3.6.1.4.1.2620.500.9002.1.2.1.1.9.5.0 = STRING: "peernameX"  
    .1.3.6.1.4.1.2620.500.9002.1.2.2.2.2.9.0 = STRING: "peernameX"  
    .1.3.6.1.4.1.2620.500.9002.1.2.2.3.4.100.0 = STRING: "peernameX"  
    .1.3.6.1.4.1.2620.500.9002.1.2.8.2.1.1.0 = STRING: "peernameX"  
    .1.3.6.1.4.1.2620.500.9002.1.2.192.14.38.3.0 = STRING: "peernameX"  
    .1.3.6.1.4.1.2620.500.9002.1.2.7.40.1.2.0 = STRING: "peernameX"  
    .1.3.6.1.4.1.2620.500.9002.1.2.1.39.11.78.0 = STRING: "peernameX"  
    .1.3.6.1.4.1.2620.500.9002.1.2.1.73.19.16.0 = STRING: "peernameX"  
    Error: OID not increasing: .1.3.6.1.4.1.2620.500.9002.1.2.7.40.1.2.0  
    {{ >= .1.3.6.1.4.1.2620.500.9002.1.2.1.73.19.16.0}}.1.3.6.1.4.1.2620.500.9002.1.2.5.93.10.27.0 = STRING: "peernameX"  
    .1.3.6.1.4.1.2620.500.9002.1.2.7.92.55.54.0 = STRING: "peernameX"

### Installation
Just put the script into your Servers and/or Proxies `ExternalScripts` Folder, and use it in a new LLD Discovery Rule

Type: `External check`

Key: `snmp_unorderd_mibs_discovery.sh[{HOST.CONN},{$SNMP_COMMUNITY},.1.3.6.1.4.1.2620.500.9002.1]`

**Thats it**
You can now use `{#OID}` as the *(in my case IP)* OID and `{#VALUE}` *(in my case the connection name)* in your Item prototypes.

