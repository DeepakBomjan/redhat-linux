`iptables` is a command-line utility used to configure the packet filtering rules of the Linux kernel firewall. Here's a basic introduction to some common `iptables` commands:

### Basic Concepts

- **Tables**: `iptables` uses tables to organize rules. The most common tables are `filter`, `nat`, and `mangle`.
- **Chains**: Each table contains chains, which are lists of rules. Common chains include `INPUT`, `OUTPUT`, and `FORWARD`.
- **Rules**: Each rule specifies what to do with a packet (e.g., accept, drop, log).

### Common `iptables` Commands

1. **List Current Rules**
   ```bash
   sudo iptables -L
   ```

2. **Allow Incoming SSH Connections**
   ```bash
   sudo iptables -A INPUT -p tcp --dport 22 -j ACCEPT
   ```

3. **Allow Outgoing Connections**
   ```bash
   sudo iptables -A OUTPUT -j ACCEPT
   ```

4. **Allow Incoming HTTP Connections**
   ```bash
   sudo iptables -A INPUT -p tcp --dport 80 -j ACCEPT
   ```

5. **Allow Incoming HTTPS Connections**
   ```bash
   sudo iptables -A INPUT -p tcp --dport 443 -j ACCEPT
   ```

6. **Block an IP Address**
   ```bash
   sudo iptables -A INPUT -s 192.168.1.100 -j DROP
   ```

7. **Delete a Rule**
   ```bash
   sudo iptables -D INPUT -s 192.168.1.100 -j DROP
   ```

8. **Save Current Rules**
   ```bash
   sudo iptables-save > /etc/iptables/rules.v4
   ```

9. **Restore Saved Rules**
   ```bash
   sudo iptables-restore < /etc/iptables/rules.v4
   ```

10. **Flush All Rules**
    ```bash
    sudo iptables -F
    ```

### Basic Example

To set up a simple firewall that allows SSH, HTTP, and HTTPS, and blocks all other incoming traffic:

```bash
# Flush all existing rules
sudo iptables -F

# Default policy to drop all incoming and forwarding traffic
sudo iptables -P INPUT DROP
sudo iptables -P FORWARD DROP

# Allow all outgoing traffic
sudo iptables -P OUTPUT ACCEPT

# Allow incoming SSH
sudo iptables -A INPUT -p tcp --dport 22 -j ACCEPT

# Allow incoming HTTP
sudo iptables -A INPUT -p tcp --dport 80 -j ACCEPT

# Allow incoming HTTPS
sudo iptables -A INPUT -p tcp --dport 443 -j ACCEPT

# Allow incoming traffic on the loopback interface
sudo iptables -A INPUT -i lo -j ACCEPT

# Allow established connections
sudo iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
```

### Note

- Use `sudo` if you're not running as the root user.
- Be cautious when applying `iptables` rules, as incorrect rules can lock you out of your system, especially if you are working on a remote server.
