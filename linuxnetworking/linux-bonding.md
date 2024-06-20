1. List Connection Profiles:
```bash
nmcli connection show
```
2. Rename the Connection Profile
```bash
sudo nmcli connection modify 'Wired connection 1' connection.id 'New Connection Name'

```
3. Apply Changes:
```bash
sudo nmcli connection up 'New Connection Name'
```

5. Verify Changes
```bash
nmcli connection show

```

Rename the connection profile
```bash
sudo nmcli connection modify 'Wired connection 1' connection.id 'New Connection Name'
```

## Tutorial
```bash
sudo nmcli connection modify 'Wired connection 1' connection.id 'bond-slave-1'
sudo nmcli connection modify 'Wired connection 2' connection.id 'bond-slave-2'
```
###  Show devices
```bash
nmcli device show

```
### Remove IP Address:
```bash
sudo nmcli connection modify 'bond-slave-1' ipv4.addresses ''
sudo nmcli connection modify 'bond-slave-2' ipv4.addresses ''
```

### Using ip
```bash
ip addr del 172.31.92.121/20 dev eth1
ip addr del 172.31.88.209/20 dev eth2
```

```bash
ip link add bond0 type bond
ip link set bond0 type bond miimon 100 mode active-backup
ip link set eth1 down
ip link set eth1 master bond0
ip link set eth2 down
ip link set eth2 master bond0
ip link set bond0 up
```
## Set VLAN on the bond device:
```bash
ip link add link bond0 name bond0.2 type vlan id 2
ip link set bond0.2 up
```
## Add the bridge device and attach VLAN to it:
```bash
ip link add br0 type bridge
ip link set bond0.2 master br0
ip link set br0 up
```

```bash
# /etc/sysconfig/network-scripts/ifcfg-bond0

DEVICE=bond0
IPADDR=192.168.1.100
NETMASK=255.255.255.0
ONBOOT=yes
BOOTPROTO=none
BONDING_OPTS="mode=1 miimon=100"

```

## Configure IP
```bash
ip addr add 172.31.88.209/20 dev bond0
```

## make link up
```bash
sudo ip link set dev bond0 up

```

## Remove Bridge Interface (br0):
```bash
sudo ip link set dev br0 down
sudo ip addr flush dev br0
sudo brctl delbr br0  # If using bridge control commands (brctl)

```
```bash
sudo ip link delete br0 type bridge

```


### Reference:
https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/networking_guide/sec-vlan_on_bond_and_bridge_using_ip_commands


