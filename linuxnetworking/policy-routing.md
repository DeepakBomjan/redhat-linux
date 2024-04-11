## Understanding Policy-routing
`Policy-routing` allows more flexibility to select routes based on other routing properties, such as source IP address, source port, protocol type. 
Routing table id are stored in the file: `/etc/iproute2/rt_tables`. The default table is identified with 254.

`ip route `format 
```bash
10.10.10.0/24 via 192.168.0.10 table 1
10.10.10.0/24 via 192.168.0.10 table 2
```

### Configure policy routing
```bash
# echo 200 John >> /etc/iproute2/rt_tables
# ip rule add from 10.0.0.10 table John
# ip rule ls
0:	from all lookup local 
32765:	from 10.0.0.10 lookup John
32766:	from all lookup main 
32767:	from all lookup default
```
### Add the route
```bash
ip route add default via 195.96.98.253 dev ppp2 table John
# ip route flush cache
```

