Netplan is the network configuration utility used in Ubuntu 18.04 and later. It uses YAML files to configure network interfaces and works with both `networkd` and `NetworkManager` as backends. Below are some common examples of Netplan configurations.

### 1. DHCP Configuration

#### Example: Configuring an Ethernet Interface with DHCP
```yaml
network:
  version: 2
  renderer: networkd
  ethernets:
    eth0:
      dhcp4: true
```

### 2. Static IP Configuration

#### Example: Configuring a Static IP Address for an Ethernet Interface
```yaml
network:
  version: 2
  renderer: networkd
  ethernets:
    eth0:
      addresses:
        - 192.168.1.100/24
      gateway4: 192.168.1.1
      nameservers:
        addresses:
          - 8.8.8.8
          - 8.8.4.4
```

### 3. Configuring Multiple Interfaces

#### Example: Multiple Ethernet Interfaces
```yaml
network:
  version: 2
  renderer: networkd
  ethernets:
    eth0:
      dhcp4: true
    eth1:
      addresses:
        - 192.168.2.100/24
      gateway4: 192.168.2.1
      nameservers:
        addresses:
          - 8.8.8.8
          - 8.8.4.4
```

### 4. Bridged Interface

#### Example: Configuring a Bridged Interface
```yaml
network:
  version: 2
  renderer: networkd
  bridges:
    br0:
      interfaces:
        - eth0
        - eth1
      addresses:
        - 192.168.1.100/24
      gateway4: 192.168.1.1
      nameservers:
        addresses:
          - 8.8.8.8
          - 8.8.4.4
```

### 5. VLAN Configuration

#### Example: Configuring a VLAN
```yaml
network:
  version: 2
  renderer: networkd
  ethernets:
    eth0:
      dhcp4: no
  vlans:
    vlan10:
      id: 10
      link: eth0
      addresses:
        - 192.168.10.100/24
      gateway4: 192.168.10.1
      nameservers:
        addresses:
          - 8.8.8.8
          - 8.8.4.4
```

### 6. Bonding (Link Aggregation)

#### Example: Configuring Bonded Interfaces
```yaml
network:
  version: 2
  renderer: networkd
  ethernets:
    eth0:
      dhcp4: no
    eth1:
      dhcp4: no
  bonds:
    bond0:
      interfaces:
        - eth0
        - eth1
      addresses:
        - 192.168.1.100/24
      gateway4: 192.168.1.1
      parameters:
        mode: active-backup
        primary: eth0
      nameservers:
        addresses:
          - 8.8.8.8
          - 8.8.4.4
```

### 7. Wi-Fi Configuration

#### Example: Configuring a Wi-Fi Connection
```yaml
network:
  version: 2
  renderer: NetworkManager
  wifis:
    wlan0:
      dhcp4: true
      access-points:
        "MyWiFiNetwork":
          password: "mysecurepassword"
```

### Applying the Configuration

After creating or editing the Netplan configuration file (usually located in `/etc/netplan/`), apply the configuration with:
```bash
sudo netplan apply
```

### Conclusion

Netplan makes network configuration straightforward with YAML files. The examples provided cover common scenarios, but Netplan can be configured for more complex setups as well. Always ensure your YAML syntax is correct, as improper formatting can cause errors.


For versions of Ubuntu prior to 18.04, networking is often managed using the `ifupdown` system with configurations specified in `/etc/network/interfaces`. Here are some examples and explanations for common networking configurations using the older method.

### Basic Configuration File

The main configuration file is `/etc/network/interfaces`.

### 1. DHCP Configuration

#### Example: Configuring an Ethernet Interface with DHCP
```plaintext
auto eth0
iface eth0 inet dhcp
```

### 2. Static IP Configuration

#### Example: Configuring a Static IP Address for an Ethernet Interface
```plaintext
auto eth0
iface eth0 inet static
  address 192.168.1.100
  netmask 255.255.255.0
  gateway 192.168.1.1
  dns-nameservers 8.8.8.8 8.8.4.4
```

### 3. Configuring Multiple Interfaces

#### Example: Multiple Ethernet Interfaces
```plaintext
auto eth0
iface eth0 inet dhcp

auto eth1
iface eth1 inet static
  address 192.168.2.100
  netmask 255.255.255.0
  gateway 192.168.2.1
  dns-nameservers 8.8.8.8 8.8.4.4
```

### 4. Bridged Interface

#### Example: Configuring a Bridged Interface
```plaintext
auto br0
iface br0 inet static
  address 192.168.1.100
  netmask 255.255.255.0
  gateway 192.168.1.1
  bridge_ports eth0 eth1
  dns-nameservers 8.8.8.8 8.8.4.4
```

### 5. VLAN Configuration

#### Example: Configuring a VLAN
```plaintext
auto eth0
iface eth0 inet manual

auto eth0.10
iface eth0.10 inet static
  address 192.168.10.100
  netmask 255.255.255.0
  vlan-raw-device eth0
```
This requires the `vlan` package. Install it with:
```bash
sudo apt-get install vlan
```
Ensure 8021q module is loaded:
```bash
sudo modprobe 8021q
```

### 6. Bonding (Link Aggregation)

#### Example: Configuring Bonded Interfaces
```plaintext
auto bond0
iface bond0 inet static
  address 192.168.1.100
  netmask 255.255.255.0
  gateway 192.168.1.1
  dns-nameservers 8.8.8.8 8.8.4.4
  bond-slaves eth0 eth1
  bond-mode 1
  bond-miimon 100
```
This requires the `ifenslave` package. Install it with:
```bash
sudo apt-get install ifenslave
```
Ensure bonding module is loaded:
```bash
sudo modprobe bonding
```

### 7. Wi-Fi Configuration

#### Example: Configuring a Wi-Fi Connection (WPA)
```plaintext
auto wlan0
iface wlan0 inet dhcp
  wpa-ssid "MyWiFiNetwork"
  wpa-psk "mysecurepassword"
```

### Applying the Configuration

After editing `/etc/network/interfaces`, apply the configuration by restarting the networking service:
```bash
sudo systemctl restart networking
```
or on older systems:
```bash
sudo service networking restart
```

### Additional Commands

#### Bringing Up and Down Interfaces Manually
To bring up an interface:
```bash
sudo ifup eth0
```

To bring down an interface:
```bash
sudo ifdown eth0
```

#### Checking Network Configuration
To view the current network configuration:
```bash
ifconfig
```
or
```bash
ip address
```

### Conclusion

This guide covers the basics of network configuration in older versions of Ubuntu using the `ifupdown` system. These configurations are written in the `/etc/network/interfaces` file and managed using commands like `ifup` and `ifdown`. This system is straightforward but requires manual editing of configuration files and service restarts for changes to take effect.


Network bonding (also known as link aggregation) allows multiple network interfaces to be combined into a single logical interface, providing redundancy and/or increased throughput. Below are examples of configuring network bonding on both Netplan (used in Ubuntu 18.04 and later) and the older `ifupdown` system (used in versions prior to 18.04).

### Bonding with Netplan

Netplan configurations are written in YAML and stored in `/etc/netplan/`. Here’s an example of how to configure network bonding with Netplan:

#### Example: Configuring Bonded Interfaces with Netplan

1. **Create or edit a Netplan configuration file** (e.g., `/etc/netplan/01-netcfg.yaml`):
    ```yaml
    network:
      version: 2
      renderer: networkd
      ethernets:
        eth0:
          dhcp4: no
        eth1:
          dhcp4: no
      bonds:
        bond0:
          interfaces:
            - eth0
            - eth1
          addresses:
            - 192.168.1.100/24
          gateway4: 192.168.1.1
          nameservers:
            addresses:
              - 8.8.8.8
              - 8.8.4.4
          parameters:
            mode: active-backup
            primary: eth0
            mii-monitor-interval: 100
    ```

2. **Apply the configuration**:
    ```bash
    sudo netplan apply
    ```

### Bonding with `ifupdown`

For older versions of Ubuntu using the `ifupdown` system, configurations are done in the `/etc/network/interfaces` file. You also need to ensure the `ifenslave` package is installed.

#### Example: Configuring Bonded Interfaces with `ifupdown`

1. **Install the `ifenslave` package**:
    ```bash
    sudo apt-get install ifenslave
    ```

2. **Ensure the bonding kernel module is loaded**:
    ```bash
    sudo modprobe bonding
    ```

3. **Edit the `/etc/network/interfaces` file** to include bonding configuration:
    ```plaintext
    auto bond0
    iface bond0 inet static
      address 192.168.1.100
      netmask 255.255.255.0
      gateway 192.168.1.1
      dns-nameservers 8.8.8.8 8.8.4.4
      bond-slaves eth0 eth1
      bond-mode active-backup
      bond-miimon 100

    auto eth0
    iface eth0 inet manual
      bond-master bond0

    auto eth1
    iface eth1 inet manual
      bond-master bond0
    ```

4. **Restart the networking service** to apply the changes:
    ```bash
    sudo systemctl restart networking
    ```
    or on older systems:
    ```bash
    sudo service networking restart
    ```

### Explanation of Parameters

- **`bond-slaves`**: Lists the interfaces that will be part of the bond.
- **`bond-mode`**: Specifies the bonding mode. Common modes include:
  - `active-backup`: One interface is active, others are backup.
  - `balance-rr`: Round-robin mode for load balancing.
  - `802.3ad`: IEEE 802.3ad dynamic link aggregation (requires switch support).
- **`bond-miimon`**: Specifies the MII link monitoring frequency in milliseconds.

### Conclusion

Configuring network bonding in both Netplan and the older `ifupdown` system involves setting up interfaces and specifying bonding parameters. Netplan uses YAML for configuration, while `ifupdown` uses the `/etc/network/interfaces` file. Both methods require you to ensure the bonding kernel module is loaded and, for `ifupdown`, the `ifenslave` package is installed.
