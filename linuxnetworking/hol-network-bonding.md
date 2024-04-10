## Enabling and Configuring Network Bonding or Teaming
1. Enable bonding module
```bash
 lsmod | grep bond
 ```
```bash
modprobe --first-time bonding
```
```bash
modinfo bonding
```
2. To load permanently, create file inside `/etc/modules-load.d`
```bash

echo "# Load the bonding kernel module at boot" > /etc/modules-load.d/bonding.conf
echo "bonding" >> /etc/modules-load.d/bonding.conf
```

3. Create bonding using `nmtui`
4. Bring up the `bond0` interface
```bash
ip link set dev bond0 up
```
## Testing Network Bonding or Teaming in Linux
1. ping the bond interface ip
2. Monitor the traffic in bond0 interface
```bash
watch -d -n1 netstat -i
```
3. Change bond mode and observe the packet 

## Example Configuration 
1. bonding master: `/etc/sysconfig/network-scripts/ifcfg-bond0`
```bash
DEVICE=bond0
TYPE=Bond
NAME=bond0
BONDING_MASTER=yes
IPADDR=192.0.2.0
PREFIX=24
DEFROUTE=yes
IPV4_FAILURE_FATAL=no
IPV6INIT=no
UUID=7099226a-66ac-42a3-a41f-da8284e34838
ONBOOT=yes
BOOTPROTO=none
BONDING_OPTS="<bonding options>"
```

2. Slave configuration: `/etc/sysconfig/network-scripts/ifcfg-eth1`
```bash
MACADDR=02:00:00:D3:FE:A0
SLAVE=yes
DEVICE=enccw0.0.b230
TYPE=Ethernet
NAME=eth1
UUID=4a8e29c7-fb39-457b-8edd-46cbc6ed49f9
ONBOOT=yes
MASTER=7099226a-66ac-42a3-a41f-da8284e34838
```

### Example 2
```bash
cat ifcfg-bond0
```
```bash
DEVICE=bond0
NAME=bond0
TYPE=Bond
BONDING_MASTER=yes
ONBOOT=yes
BOOTPROTO=none
BONDING_OPTS="mode=4 miion=100 lacp_rate=1"
NM_CONTROLLED=no
IPADDR=20.10.10.2
PREFIX=24
```

```bash
cat ifcfg-ens1f0
```
DEVICE=ens1f0
HWADDR=90:e2:ba:cc:27:70
TYPE=ethernet
ONBOOT=yes
NM_CONTROLLED=no
MASTER=bond0
SLAVE=yes
```
```bash
cat ifcfg-ens1f1
```
```bash
DEVICE=ens1f1
HWADDR=90:e2:ba:cc:27:71
TYPE=ethernet
ONBOOT=yes
NM_CONTROLLED=no
MASTER=bond0
SLAVE=yes
```
