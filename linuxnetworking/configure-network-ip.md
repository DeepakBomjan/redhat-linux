## Configuring IP Networking with ip Commands

1. To bring an interface down:
    ```bash
    ip link set ifname down
    ```
    The ip utility can be used to assign IP addresses to an interface with the following form:
    ```bash
    ip addr [add | del] address dev ifname
    ```
2. To assign an IP address to an interface:
    ```bash
    ip address add 10.0.0.3/24 dev enp1s0
    ip addr show dev enp1s0
    ```
3. Configuring Multiple Addresses Using ip Commands
    > As the ip utility supports assigning multiple addresses to the same interface it is no longer necessary to use the alias interface method of binding multiple addresses to the same interface. 
    ```bash
    ip address add 192.168.2.223/24 dev enp1s0
    ip address add 192.168.4.223/24 dev enp1s0
    ip addr
    ```

### Configuring Static Routes with ip commands
1. To display the IP routing table
    ```bash
    ip route
    ```
The ip route commands take the following form:
```
ip route [add | del | change | append | replace] destination-address
```
2. To add a static route to a host address
    ```bash
    ip route add 192.0.2.1 via 10.0.0.1 [dev interface]
    ```
3. To add a static route to a network
    ```bash
    ip route add 192.0.2.0/24 via 10.0.0.1 [dev interface]
    ```
4. To remove the assigned static route
    ```bash
    ip route del 192.0.2.1
    ```
