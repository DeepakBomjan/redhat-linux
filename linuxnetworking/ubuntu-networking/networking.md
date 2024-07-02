
## Networking key concepts

#### The Transmission Control Protocol and Internet Protocol (TCP/IP)
1. **TCP/IP overview**  
    * **Internet Protocol**:  
        a connectionless protocol that deals only with network packet routing using the IP Datagram as the basic unit of networking information. 
    * **Transmission Control Protocol**:   
        enables network hosts to establish connections that may be used to exchange data streams

2. **TCP/IP configuration**  
The common configuration elements of TCP/IP
    1. IP address
    2. Netmask
    3. Network address
    4. Broadcast address
    5. Gateway address
    6. Nameserver address
3. **IP routing**  
4. **About TCP and UDP**
5. **Internet Control Messaging Protocol (ICMP)**
6. **About daemons**


## Configure Network Interface Using Command-Line
## Identify Ethernet interfaces

```sh
ls /sys/class/net
```
or
```sh
ip a
```

or
```sh
sudo lshw -class network
```


## Configuring Static IP Address For Your Network Card

1. Legacy network configuration
Configure a Static IP address by editing `/etc/network/interfaces`. Replace `eth0` with your network interface card (see Find Network Interface Card).

```sh
sudo nano /etc/network/interfaces
```
Add the following lines:

```
# The primary network interface
auto eth0
iface eth0 inet static
address 192.168.2.33
gateway 192.168.2.1
netmask 255.255.255.0
network 192.168.2.0
broadcast 192.168.2.255
```

For these settings to take effect, you need to restart your networking services.

```sh
sudo /etc/init.d/networking restart
```
2. Using Netplan
```yaml
network:
  version: 2
  renderer: networkd
  ethernets:
    eth_lan0:
      dhcp4: true
      match:
        macaddress: 00:11:22:33:44:55
      set-name: eth_lan0
```

## [YAML](https://yaml.org/)

3. Setting Your Hostname
```bash
sudo /bin/hostname
```
```bash
sudo /bin/hostname newname
```

4. Setting up DNS
You can add hostname and IP addresses to the file `/etc/hosts` for static lookups.
```bash
sudo nano /etc/resolv.conf
```
enter the following details

`search myaddress.com nameserver 192.168.3.2`

5. Configuring DHCP Address for Your Network Card
```bash
sudo nano /etc/network/interfaces
```
```bash
# The primary network interface – use DHCP to find our address
auto eth0
iface eth0 inet dhcp
```

### [Ubuntu Legacy Networking](https://help.ubuntu.com/community/NetworkConfigurationCommandLine)

6. Ethernet Interface settings
```bash
sudo ethtool eth4
```

### IP addressing
#### Temporary IP address assignment

```bash
sudo ip addr add 10.102.66.200/24 dev enp0s25
```
The ip can then be used to set the link up or down.
```bash
ip link set dev enp0s25 up
ip link set dev enp0s25 down
```
To verify the IP address configuration of enp0s25
```bash
ip address show dev enp0s25
```
To configure a default gateway
```bash
sudo ip route add default via 10.102.66.1
```
You can also use the ip command to verify your default gateway configuration
```bash
ip route show
```
If you no longer need this configuration and wish to purge all IP configuration from an interface
```bash
ip addr flush eth0
```

#### Dynamic IP address assignment
create a Netplan configuration in the file` /etc/netplan/99_config.yaml`.
```yaml
network:
  version: 2
  renderer: networkd
  ethernets:
    enp3s0:
      dhcp4: true
```
The configuration can then be applied using the netplan command:
```bash
sudo netplan apply
```

#### Static IP address assignment
To configure your system to use static address assignment, create a netplan configuration in the file `/etc/netplan/99_config.yaml`.

```yaml
network:
  version: 2
  renderer: networkd
  ethernets:
    eth0:
      addresses:
        - 10.10.10.2/24
      routes:
        - to: default
          via: 10.10.10.1
      nameservers:
          search: [mydomain, otherdomain]
          addresses: [10.10.10.1, 1.1.1.1]
```
```bash
sudo netplan try

```

```bash
sudo netplan apply
```
> NOTE
netplan in Ubuntu Bionic 18.04 LTS doesn’t understand the “`to: default`” syntax to specify a default route, and should use the older `gateway4: 10.10.10.1` key instead of the whole routes: block.


## Name resolution
### DNS client configuration
```yaml
network:
  version: 2
  renderer: networkd
  ethernets:
    enp0s25:
      addresses:
        - 192.168.0.100/24
      routes:
        - to: default
          via: 192.168.0.1
      nameservers:
          search: [mydomain, otherdomain]
          addresses: [1.1.1.1, 8.8.8.8, 4.4.4.4]
```

The _search_ option can also be used with multiple domain names so that DNS queries will be appended in the order in which they are entered. For example, your network may have multiple sub-domains to search; a parent domain of `example.com`, and two sub-domains, `sales.example.com` and `dev.example.com`.

### Static hostnames
Static hostnames are locally defined hostname-to-IP mappings located in the file `/etc/hosts`. Entries in the `hosts` file will have precedence over DNS by default. This means that if your system tries to resolve a hostname and it matches an entry in `/etc/hosts`, it will not attempt to look up the record in DNS. 

The following is an example of a `hosts` file where a number of local servers have been identified by simple hostnames, aliases and their equivalent Fully Qualified Domain Names (FQDN’s):

```bash

127.0.0.1   localhost
127.0.1.1   ubuntu-server
10.0.0.11   server1 server1.example.com vpn
10.0.0.12   server2 server2.example.com mail
10.0.0.13   server3 server3.example.com www
10.0.0.14   server4 server4.example.com file
```
> **Note**  
In this example, notice that each of the servers were given aliases in addition to their proper names and FQDN’s. _Server1_ has been mapped to the name _vpn_, _server2_ is referred to as _mail_, _server3_ as _www_, and _server4_ as _file_.


### [Configuring networks](https://ubuntu.com/server/docs/configuring-networks)
