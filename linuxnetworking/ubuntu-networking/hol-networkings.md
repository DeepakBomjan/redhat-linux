Sure, here's a concise exercise for configuring a static IP address using the `ip` command and ensuring it persists across reboots by editing `/etc/network/interfaces`.

### Static IP Configuration Using `ip` Command

1. **Assign a Static IP Address**: Use the `ip` command to assign a static IP address temporarily.

    ```sh
    sudo ip addr add 192.168.1.100/24 dev eth0
    sudo ip link set dev eth0 up
    sudo ip route add default via 192.168.1.1
    ```

2. **Verify the Configuration**: Check the new settings.

    ```sh
    ip addr show eth0
    ip route show
    ```

3. **Test Connectivity**: Ensure the network is working by pinging a known address.

    ```sh
    ping 8.8.8.8
    ```

### Persisting the Configuration

1. **Edit the Network Interfaces File**: Open the `/etc/network/interfaces` file in a text editor.

    ```sh
    sudo nano /etc/network/interfaces
    ```

2. **Add the Static IP Configuration**: Add the following lines, replacing `eth0` with your network interface name if different.

    ```plaintext
    auto eth0
    iface eth0 inet static
        address 192.168.1.100
        netmask 255.255.255.0
        gateway 192.168.1.1
    ```

3. **Restart Networking Services**: Restart the networking service to apply the changes.

    ```sh
    sudo systemctl restart networking
    ```

4. **Verify the Configuration**: Check the new settings again.

    ```sh
    ip addr show eth0
    ip route show
    ```

5. **Test Connectivity**: Ensure the network is working by pinging a known address.

    ```sh
    ping 8.8.8.8
    ```

### Summary

- Assign a static IP temporarily using `ip` command.
- Persist the configuration by editing `/etc/network/interfaces`.
- Restart networking services to apply changes.
- Verify and test connectivity.

This exercise demonstrates how to configure a static IP address using the `ip` command and make the changes persistent across reboots.


### Netplan Static IP Configuration

1. **Create/Edit the Netplan Configuration File**: Open the Netplan configuration file in a text editor.

    ```sh
    sudo nano /etc/netplan/01-netcfg.yaml
    ```

2. **Add Configuration**: Add the following configuration, replacing `eth0` with your network interface name if different.

    ```yaml
    network:
      version: 2
      ethernets:
        eth0:
          dhcp4: no
          addresses:
            - 192.168.1.100/24
          gateway4: 192.168.1.1
          nameservers:
            addresses:
              - 8.8.8.8
              - 8.8.4.4
    ```

3. **Test the Configuration**: Test the new configuration.

    ```sh
    sudo netplan try
    ```

4. **Apply the Configuration**: If the test is successful, apply the configuration.

    ```sh
    sudo netplan apply
    ```

5. **Verify the Configuration**: Check the new settings.

    ```sh
    ip addr show eth0
    ```

6. **Test Connectivity**: Ensure the network is working by pinging a known address.

    ```sh
    ping 8.8.8.8
    ```

### Summary

- Edit `/etc/netplan/01-netcfg.yaml`.
- Add static IP configuration.
- Test with `sudo netplan try`.
- Apply with `sudo netplan apply`.
- Verify and test connectivity.

This exercise sets a static IP address for your network interface using Netplan in a few simple steps.

Sure, here's a concise guide for setting up the hostname, editing the `/etc/hosts` file, and configuring the DNS server:

### Setting Up Hostname

1. **Set the Hostname Temporarily**: Use the `hostnamectl` command to set the hostname temporarily.

    ```sh
    sudo hostnamectl set-hostname your-new-hostname
    ```

2. **Verify the Hostname**: Check the new hostname.

    ```sh
    hostnamectl
    ```

### Configuring the hostname using the `/etc/hostname` file and the `hostname` command.


1. **Set the Hostname Temporarily**: Use the `hostname` command to set the hostname temporarily.

    ```sh
    sudo hostname your-new-hostname
    ```

2. **Edit the `/etc/hostname` File**: Open the `/etc/hostname` file in a text editor to make the change persistent across reboots.

    ```sh
    sudo nano /etc/hostname
    ```

3. **Add the New Hostname**: Replace the existing hostname with your new hostname.

    ```plaintext
    your-new-hostname
    ```

4. **Update the `/etc/hosts` File**: Open the `/etc/hosts` file in a text editor to update the hostname mapping.

    ```sh
    sudo nano /etc/hosts
    ```

5. **Add Hostname Entry**: Ensure there is an entry that maps the new hostname to the loopback address.

    ```plaintext
    127.0.0.1   localhost
    127.0.1.1   your-new-hostname

    ```

6. **Reboot the System**: Reboot the system to apply the changes persistently.

    ```sh
    sudo reboot
    ```

### Verify the Configuration

1. **Check the Hostname**: After rebooting, verify that the hostname is correctly set.

    ```sh
    hostname
    ```

2. **Verify `/etc/hostname`**: Ensure that the `/etc/hostname` file contains the correct hostname.

    ```sh
    cat /etc/hostname
    ```

3. **Verify `/etc/hosts`**: Ensure that the `/etc/hosts` file contains the correct mappings.

    ```sh
    cat /etc/hosts
    ```

### Summary

- Temporarily set the hostname using `hostname`.
- Persistently set the hostname by editing `/etc/hostname`.
- Update `/etc/hosts` with the new hostname.
- Reboot the system to apply changes.
- Verify the new hostname settings.

This guide helps you set up the hostname using both the `hostname` command and by editing the `/etc/hostname` file.
### Editing `/etc/hosts` File

1. **Edit the `/etc/hosts` File**: Open the `/etc/hosts` file in a text editor.

    ```sh
    sudo nano /etc/hosts
    ```

2. **Add Hostname Entry**: Add an entry for the new hostname.

    ```plaintext
    127.0.0.1   localhost
    127.0.1.1   your-new-hostname

    ```

### Configuring DNS Server

Sure, here's a concise guide for configuring the DNS server the traditional way, by editing the `/etc/resolv.conf` file.

### Configuring DNS Server Using `/etc/resolv.conf`

1. **Edit the `/etc/resolv.conf` File**: Open the `/etc/resolv.conf` file in a text editor.

    ```sh
    sudo nano /etc/resolv.conf
    ```

2. **Add DNS Server Addresses**: Add the nameserver entries to the file. Replace the IP addresses with your desired DNS servers.

    ```plaintext
    nameserver 8.8.8.8
    nameserver 8.8.4.4
    ```

3. **Save and Exit**: Save the file and exit the editor.

### Verify DNS Configuration

1. **Check DNS Configuration**: Ensure that the DNS servers are set correctly.

    ```sh
    cat /etc/resolv.conf
    ```

2. **Test DNS Resolution**: Test if the DNS resolution is working.

    ```sh
    ping google.com
    ```


Sure, here is a concise guide for checking network connectivity using the `ping`, `nc` (netcat), and `nmap` commands.

### Checking Network Connectivity

#### Using `ping`

The `ping` command is used to test the reachability of a host on an IP network.

1. **Ping a Host**: This command sends ICMP ECHO_REQUEST packets to the specified host.

    ```sh
    ping google.com
    ```

    Output Example:
    ```plaintext
    PING google.com (142.250.72.14): 56 data bytes
    64 bytes from 142.250.72.14: icmp_seq=0 ttl=113 time=17.5 ms
    ```

2. **Ping with Specific Count**: Send a specific number of packets and then stop.

    ```sh
    ping -c 4 google.com
    ```

#### Using `nc` (netcat)

The `nc` (netcat) command is a versatile networking tool that can be used for checking the connectivity to a specific port.

1. **Check Connectivity to a Specific Port**: Use the `-z` option to scan for listening daemons without sending any data, and `-v` for verbose output.

    ```sh
    nc -zv google.com 80
    ```

    Output Example:
    ```plaintext
    Connection to google.com 80 port [tcp/http] succeeded!
    ```


#### Using `nmap`

The `nmap` (Network Mapper) command is a powerful tool for network discovery and security auditing.

1. **Basic Port Scan**: Scan a host for open ports.

    ```sh
    nmap google.com
    ```

2. **Scan Specific Ports**: Scan specific ports on a host.

    ```sh
    nmap -p 22,80 google.com
    ```

3. **Scan a Range of IP Addresses**: Scan a range of IP addresses for open ports.

    ```sh
    nmap 192.168.1.1-254
    ```

4. **Verbose Output**: Use `-v` for verbose output.

    ```sh
    nmap -v google.com
    ```

Sure, here are more advanced uses of the `ping` command and additional troubleshooting commands.

### Advanced `ping` Command Usage

1. **Ping with a Specific Packet Size**: Use the `-s` option to specify the size of the packet to send.

    ```sh
    ping -s 1000 google.com
    ```

    This sends ICMP packets with a size of 1000 bytes.

2. **Ping with a Specific Count**: Use the `-c` option to specify the number of packets to send.

    ```sh
    ping -c 5 google.com
    ```

    This sends 5 ICMP packets to the specified host.

3. **Ping Continuously**: Use the `-i` option to set the interval between packets sent (default is 1 second).

    ```sh
    ping -i 0.5 google.com
    ```

    This sends packets every 0.5 seconds.

4. **Ping with a Time Limit**: Use the `-w` option to specify the time to wait before stopping.

    ```sh
    ping -w 10 google.com
    ```

    This sends packets for 10 seconds and then stops.

5. **Ping a Host Until Stopped**: Ping a host continuously until you manually stop it (usually with `Ctrl+C`).

    ```sh
    ping google.com
    ```

6. **Flood Ping (Super User Only)**: Use the `-f` option to send packets as fast as possible. This is used for stress testing.

    ```sh
    sudo ping -f google.com
    ```

    **Warning**: This can be disruptive and should be used with caution.

7. **Do Not Fragment (IPv4 Only)**: Use the `-M do` option to set the Don't Fragment bit.

    ```sh
    ping -M do -s 1472 google.com
    ```

    This tests the maximum transmission unit (MTU) without fragmentation.

### Additional Troubleshooting Commands

#### `traceroute`

The `traceroute` command traces the route packets take to a network host.

1. **Basic Usage**: Run `traceroute` followed by the hostname or IP address.

    ```sh
    traceroute google.com
    ```

    This displays the path packets take to reach the specified host.

#### `mtr`

The `mtr` (My Traceroute) command combines the functionality of `ping` and `traceroute`.

1. **Install `mtr`**: If not already installed, you can install it using your package manager.

    ```sh
    sudo apt-get install mtr  # Debian/Ubuntu
    sudo yum install mtr      # CentOS/RHEL
    ```

2. **Run `mtr`**: Run `mtr` followed by the hostname or IP address.

    ```sh
    mtr google.com
    ```

    This provides a continuous update of the route and packet loss statistics.

#### `dig`

The `dig` command is used for DNS queries.

1. **Basic DNS Query**: Run `dig` followed by the hostname.

    ```sh
    dig google.com
    ```

2. **Query for Specific Record Type**: Use the `@` symbol to specify the DNS server and query type (e.g., `A`, `MX`, `NS`).

    ```sh
    dig @8.8.8.8 google.com A
    ```

    This queries the A record for `google.com` using Google's public DNS server.

#### `nslookup`

The `nslookup` command queries the DNS to obtain domain name or IP address mapping.

1. **Basic Usage**: Run `nslookup` followed by the hostname.

    ```sh
    nslookup google.com
    ```
2. **Specify DNS Server**: Use `nslookup` to query a specific DNS server.

    ```sh
    nslookup google.com 8.8.8.8
    ```

### Network Statistics
Certainly! `ss` and `netstat` are both useful commands for checking network statistics and connections on a Linux system. Here’s how you can use each command:

### Using `ss` Command

`ss` (socket statistics) is a replacement for `netstat` that provides more detailed information about network connections.

1. **List All Sockets**: Display all sockets (both listening and non-listening).

    ```sh
    ss -a
    ```

2. **List Listening Sockets**: Display only listening sockets.

    ```sh
    ss -l
    ```

3. **List TCP Sockets**: Display TCP sockets.

    ```sh
    ss -t
    ```

4. **List UDP Sockets**: Display UDP sockets.

    ```sh
    ss -u
    ```

5. **Display Summary Statistics**: Show summary statistics for each protocol.

    ```sh
    ss -s
    ```

6. **Display Process Using Sockets**: Show processes associated with sockets.

    ```sh
    ss -p
    ```

### Using `netstat` Command

`netstat` is an older command but still widely used for displaying network connections and statistics.

1. **List All Connections**: Display all connections (both listening and non-listening).

    ```sh
    netstat -a
    ```

2. **List Listening Sockets**: Display only listening sockets.

    ```sh
    netstat -l
    ```

3. **List TCP Connections**: Display TCP connections.

    ```sh
    netstat -t
    ```

4. **List UDP Connections**: Display UDP connections.

    ```sh
    netstat -u
    ```

5. **Display Summary Statistics**: Show summary statistics for each protocol.

    ```sh
    netstat -s
    ```

6. **Display Process Using Sockets**: Show processes associated with sockets.

    ```sh
    netstat -p
    ```

### Example Usages

#### Using `ss`

```sh
# Display TCP sockets
ss -t

# Display listening UDP sockets
ss -lu

# Display summary statistics
ss -s
```

#### Using `netstat`

```sh
# Display all sockets
netstat -a

# Display listening TCP sockets
netstat -lt

# Display summary statistics
netstat -s
```


### Monitoring and Analysing network Traffic
To monitor network packets on Ubuntu, you can use various command-line tools that provide real-time or capture-based packet monitoring capabilities. Here are some commonly used tools:

### 1. **tcpdump**

**tcpdump** is a powerful command-line packet analyzer that allows you to capture and display TCP/IP and other packets being transmitted or received over a network.

- **Installation**: If not already installed, you can install `tcpdump` using:

  ```bash
  sudo apt-get install tcpdump
  ```

- **Basic Usage**: Capture packets on a specific network interface (`eth0` in this example):

  ```bash
  sudo tcpdump -i eth0
  ```

- **Filtering**: You can apply filters to capture specific packets. For example, to capture only TCP packets to or from port 80:

  ```bash
  sudo tcpdump -i eth0 tcp port 80
  ```

- **Writing Captured Packets to a File**: Save captured packets to a file for later analysis:

  ```bash
  sudo tcpdump -i eth0 -w capture.pcap
  ```

- **Reading Captured Packets from a File**: Analyze previously captured packets from a file:

  ```bash
  sudo tcpdump -r capture.pcap
  ```


- **Capture TCP Packets to or from a Specific IP Address**:

  ```bash
  sudo tcpdump -i eth0 tcp host 192.168.1.100
  ```

- **Capture UDP Packets to or from a Specific Port**:

  ```bash
  sudo tcpdump -i eth0 udp port 53
  ```

- **Combine Filters**: Use logical operators (`and`, `or`, `not`) to create complex filters.

  ```bash
  sudo tcpdump -i eth0 'tcp port 80 and host 192.168.1.100'
  ```

### 2. **Capture and Display Options**

- **Capture Packets to a File (`-w`)**: Save captured packets to a file for later analysis.

  ```bash
  sudo tcpdump -i eth0 -w capture.pcap
  ```

- **Read Packets from a File (`-r`)**: Analyze previously captured packets from a file.

  ```bash
  sudo tcpdump -r capture.pcap
  ```

- **Limit the Number of Packets (`-c`)**: Capture a specified number of packets and then exit.

  ```bash
  sudo tcpdump -i eth0 -c 100
  ```

### 3. **Advanced Output Control**

- **Print Timestamps (`-tttt`)**: Display absolute timestamps for each packet.

  ```bash
  sudo tcpdump -i eth0 -tttt
  ```

- **Print Packet Bytes (`-X`)**: Print the full packet in both hexadecimal and ASCII format.

  ```bash
  sudo tcpdump -i eth0 -X
  ```

### 4. **Protocol-Specific Options**

- **Capture HTTP Traffic**:

  ```bash
  sudo tcpdump -i eth0 -s 0 -A 'tcp port 80'
  ```

  - `-s 0` sets the snapshot length to unlimited (`-s 65535` for maximum).

- **Capture DNS Queries and Responses**:

  ```bash
  sudo tcpdump -i eth0 'udp port 53 or tcp port 53'
  ```

- **Capture ICMP (Ping) Packets**:

  ```bash
  sudo tcpdump -i eth0 icmp
  ```


### 6. **Monitoring Specific Interfaces**

- **Capture on a Specific Interface**:

  ```bash
  sudo tcpdump -i eth0
  ```

- **Monitor All Interfaces**:

  ```bash
  sudo tcpdump -i any
  ```



### 2. **iftop**

**iftop** is a real-time console-based network bandwidth monitoring tool.

- **Installation**: Install iftop using:

  ```bash
  sudo apt-get install iftop
  ```

- **Basic Usage**: Monitor bandwidth usage by hosts on `eth0`:

  ```bash
  sudo iftop -i eth0
  ```

- **Filtering**: Use arrow keys to navigate and `n` to switch DNS resolution on/off.

