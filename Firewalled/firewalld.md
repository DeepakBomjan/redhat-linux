## Firewalld
- `firewalld` uses the concepts of zones and services
- Zones are predefined sets of rules.
- Network interfaces and sources can be assigned to a zone. 
- Statefull firewall

### When to use firewalld, nftables, or iptables
* `firewalld`: Use the `firewalld` utility for simple firewall use cases. The utility is easy to use and covers the typical use cases for these scenarios.
* `nftables`: Use the `nftables` utility to set up complex and performance-critical firewalls, such as for a whole network.
* `iptables`: The `iptables` utility on Red Hat Enterprise Linux uses the nf_tables kernel API instead of the legacy back end. 

### Firewall zones
You can assign zones to interfaces with the following utilities:

* `NetworkManager`
* `firewall-config` utility
* `firewall-cmd` utility

The `/usr/lib/firewalld/zones/` directory stores the predefined zones.

The default settings of the predefined zones are as follows:
`block`
* Accepts: Only network connections initiated from within the system

`dmz`
* Accepts: Only selected incoming connections.

`drop`
* Accepts: Only outgoing network connections.

`external`
* Accepts: Only selected incoming connections.

`home`
* Accepts: Only selected incoming connections.

`internal`
* Accepts: Only selected incoming connections.

`public`
* Suitable for: Public areas where you do not trust other computers on the network.
* Accepts: Only selected incoming connections.

`trusted`
* Accepts: All network connections.

`work`
* Accepts: Only selected incoming connections.

One of these zones is set as the _default_ zone.

### Firewall policies
The Firewall policies contain rules for the following types of traffic:

* Incoming traffic
* Outgoing traffic
* Forward traffic
* Specific services and applications
* Network address translations (NAT)


### Firewall rules

Firewall rules typically define certain criteria based on various attributes. The attributes can be as:

* Source IP addresses
* Destination IP addresses
* Transfer Protocols (TCP, UDP, …​)
* Ports
* Network interfaces

The `firewalld` utility organizes the firewall rules into zones (such as public, internal, and others) and policies. 


### Zone configuration files
The zone configuration files are located in the `/usr/lib/firewalld/zones/` and `/etc/firewalld/zones/` directories.

### Working with firewalld zones
#### Customizing firewall settings for a specific zone to enhance security

1. List the available firewall zones:
```bash
firewall-cmd --get-zones
```
```bash
firewall-cmd --list-all-zones
```
2. Choose the zone you want to use for this configuration.
3. Modify firewall settings for the chosen zone. For example, to allow the SSH service and remove the ftp service:
```bash
firewall-cmd --add-service=ssh --zone=<your_chosen_zone>
firewall-cmd --remove-service=ftp --zone=<same_chosen_zone>
```
4. Assign a network interface to the firewall zone:
    1. List the available network interfaces:
        ```bash
        firewall-cmd --get-active-zones
        ```
    2. Assign a network interface to the chosen zone:
        ```bash
        firewall-cmd --zone=<your_chosen_zone> --change-interface=<interface_name> --permanent
        ```
**Verification**
1. Display the updated settings for your chosen zone:
```bash
firewall-cmd --zone=<your_chosen_zone> --list-all
```

#### Changing the default zone
To set up the default zone:
1. Display the current default zone:
    ```bash
    firewall-cmd --get-default-zone
    ```
2. Set the new default zone:
    ```bash
    firewall-cmd --set-default-zone <zone_name>
    ```
#### Assigning a network interface to a zone
To assign the zone to a specific interface:
1. List the active zones and the interfaces assigned to them:
    ```bash
    firewall-cmd --get-active-zones
    ```
2. Assign the interface to a different zone:
    ```bash
    firewall-cmd --zone=zone_name --change-interface=interface_name --permanent
    ```
#### Assigning a zone to a connection using nmcli
You can add a `firewalld` zone to a NetworkManager connection using the `nmcli` utility.
1. Assign the zone to the `NetworkManager` connection profile:
```bash
nmcli connection modify profile connection.zone zone_name
```
2. Activate the connection:
```bash
nmcli connection up profile
```


### References
[Using and configuring firewalld](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/9/html/configuring_firewalls_and_packet_filters/using-and-configuring-firewalld_firewall-packet-filters)

