## Routing traffic from a specific subnet to a different default gateway by using nmcli
![image](../images/policy-based-routing.png)

1. View network connections
```bash
nmcli
nmcli show conneciton
```

2. Rename the conneciton profile
```bash
sudo nmcli connection modify 'Wired connection 1' connection.id providerB
```

```bash
sudo nmcli connection modify 'Wired connection 2' connection.id internal-connection
```

## Check route table
```bash
ip route

```
## Remove extra default route
```bash
 sudo ip route del default via 192.168.3.1 dev eth1 metric 101
sudo ip route del default via 192.168.2.1 dev eth2 metric 102
```

To add the route with metric
```bash
sudo ip route add 192.168.10.0/24 via 192.168.1.1 dev eth0 metric 200
```


Add workstation network to igw

```bash
sudo nmcli connection add type ethernet con-name workstation-lan ifname enp8s0 ipv4.routes "192.168.2.0/24 table=5000" ipv4.routing-rules "priority 5 from 192.168.2.0/24 table 5000" connection.zone trusted

```

Delete conneciton with UUID
```bash
sudo nmcli connection delete d205f376-1d36-439c-8a1a-525392f40d56
```
```bash
ip route flush table 201
```
