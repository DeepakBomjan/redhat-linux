## Configuring an Ethernet connection
### Configuring an Ethernet connection by using nmcli
1. List the NetworkManager connection profiles:
    ```bash
    nmcli connection show
    ```
2. If you want to create an additional connection profile, enter:
    ```bash 
    nmcli connection add con-name <connection-name> ifname  <device-name> type ethernet
    ```
3. Optional: Rename the connection profile:
    ```bash
    nmcli connection modify "Wired connection 1" connection.id  "Internal-LAN"
    ```
4. Display the current settings of the connection profile:
    ```bash
    nmcli connection show Internal-LAN
    ```
5. Configure the IPv4 settings:
    ```bash
    nmcli connection modify Internal-LAN ipv4.method auto
    ```
6. To set a static IPv4 address, network mask, default gateway,     DNS servers, and search domain, enter:
    ```bash
    nmcli connection modify Internal-LAN ipv4.method manual ipv4.   addresses 192.0.2.1/24 ipv4.gateway 192.0.2.254 ipv4.dns 192.0.2.  200 ipv4.dns-search example.com
    ```
7. Configure the IPv6 settings:
    ```bash
    nmcli connection modify Internal-LAN ipv6.method auto
    ```
8. To set a static IPv6 address, network mask, default gateway,     DNS servers, and search domain, enter:
    ```bash
    nmcli connection modify Internal-LAN ipv6.method manual ipv6.   addresses 2001:db8:1::fffe/64 ipv6.gateway 2001:db8:1::fffe ipv6.  dns 2001:db8:1::ffbb ipv6.dns-search example.com
    ```
9. To customize other settings in the profile, use the following    command:
    ```bash
    nmcli connection modify <connection-name> <setting> <value>
    ```
10. Activate the profile:
    ```bash
    nmcli connection up Internal-LAN
    ```
**Verification**

1. Display the IP settings of the NIC:
    ```bash
    ip address show enp1s0
    ```
2. Display the IPv4 default gateway:
    ```bash
    ip route show default
    ```
3. Display the IPv6 default gateway:
    ```bash
    ip -6 route show default
    ```
4. Display the DNS settings:
    ```bash
    cat /etc/resolv.conf
    ```
5. Use the ping utility to verify that this host can send packets   to other hosts:
    ```bash
    ping <host-name-or-IP-address>
    ```
### Tutorial 2

1. Adding network connections
```bash
 sudo nmcli connection add type ethernet ifname enp0s8
```
```bash
nmcli connection up ethernet-enp0s8
```
2. Adjusting connections
Configuring static ip address
```bash
nmcli connection modify ethernet-enp0s8 ipv4.address 192.168.4.26/24
nmcli connection modify ethernet-enp0s8 ipv4.method manual
```
For your changes to take effect, you need to bounce the connection by stopping it and bringing it back up again. 
```bash
nmcli connection down ethernet-enp0s8
```
```bash
nmcli connection up ethernet-enp0s8

```
3. Device management
    1. Checking device status
```bash
nmcli device status
```
    2. Showing device details
    ```bash
    nmcli device show enp0s8
    ```
    