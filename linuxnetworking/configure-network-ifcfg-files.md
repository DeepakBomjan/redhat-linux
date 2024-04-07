## Configuring IP Networking with ifcfg Files
### Configuring an Interface with Static Network Settings Using ifcfg Files

> Configuration directory: `/etc/sysconfig/network-scripts/`
* For `IPv4` configuration
    ```bash
    DEVICE=enp1s0
    BOOTPROTO=none
    ONBOOT=yes
    PREFIX=24
    IPADDR=10.0.1.27
    ```
* For IPv6 configuration
    ```bash
    DEVICE=enp1s0
    BOOTPROTO=none
    ONBOOT=yes
    IPV6INIT=yes
    IPV6ADDR=2001:db8::2/48
    ```

### Configuring an Interface with Dynamic Network Settings Using ifcfg Files
1. Create a file with the name `ifcfg-em1` in the `/etc/sysconfig/network-scripts/` directory, that contains:
    ```bash
    DEVICE=em1
    BOOTPROTO=dhcp
    ONBOOT=yes
    ```
2. Configure DNS servers:
    ```bash
      PEERDNS=no
      DNS1=ip-address
      DNS2=ip-address
    ```
3. Configure Static Routes 
    ```bash
    ADDRESS0=10.10.10.0
    NETMASK0=255.255.255.0
    GATEWAY0=192.168.1.1
    ```
    Example: The following is an example of a route-interface file using the network/netmask directives format.

    ```bash
    ADDRESS0=10.10.10.0
    NETMASK0=255.255.255.0
    GATEWAY0=192.168.0.10
    ADDRESS1=172.16.1.10
    NETMASK1=255.255.255.0
    GATEWAY1=192.168.0.10
    ```
4. To apply the configuration:
    1. Reload the updated connection files:
       ```bash
       nmcli connection reload
       ```
    2. Re-activate the connection:
       ```bash
       nmcli connection up connection_name
       ```
    



### References
1. [Configuring Static Routes in ifcfg files](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/networking_guide/sec-configuring_static_routes_in_ifcfg_files)
