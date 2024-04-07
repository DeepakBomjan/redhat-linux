## Understanding Policy-routing
`Policy-routing` allows more flexibility to select routes based on other routing properties, such as source IP address, source port, protocol type. 
Routing table id are stored in the file: `/etc/iproute2/rt_tables`. The default table is identified with 254.

`ip route `format 
```bash
10.10.10.0/24 via 192.168.0.10 table 1
10.10.10.0/24 via 192.168.0.10 table 2
```
