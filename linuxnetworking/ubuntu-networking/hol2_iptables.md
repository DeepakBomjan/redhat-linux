Certainly! Here's a comprehensive list of `iptables` commands for the various tasks you've mentioned:

### 1. Check Current iptables Rules
```bash
sudo iptables -L -v -n
```

### 2. List All the Chains
```bash
sudo iptables -S
```

### 3. List All the Tables
```bash
sudo iptables -t filter -L
sudo iptables -t nat -L
sudo iptables -t mangle -L
sudo iptables -t raw -L
sudo iptables -t security -L
```

### 4. Change Policy
```bash
# Change default policy to ACCEPT (example for INPUT chain)
sudo iptables -P INPUT ACCEPT

# Change default policy to DROP (example for INPUT chain)
sudo iptables -P INPUT DROP
```

### 5. Rules on INPUT Chain
#### a. Allow on Port 22 (SSH)
```bash
sudo iptables -A INPUT -p tcp --dport 22 -j ACCEPT
```

#### b. Allow ICMP v4 (Ping)
```bash
sudo iptables -A INPUT -p icmp -j ACCEPT
```

#### c. Deny ICMP
```bash
sudo iptables -A INPUT -p icmp -j DROP
```

#### d. Allow from Specific IP
```bash
sudo iptables -A INPUT -s <specific_ip_address> -j ACCEPT
```

#### e. Allow from Specific Network
```bash
sudo iptables -A INPUT -s <specific_network_address>/<subnet_mask> -j ACCEPT
```

### 6. OUTPUT Chain Rules
#### a. Deny Specific Destination
```bash
sudo iptables -A OUTPUT -d <specific_destination_ip> -j DROP
```

#### b. Deny All
```bash
sudo iptables -P OUTPUT DROP
```

### 7. DROP and REJECT
#### a. DROP a Packet
```bash
sudo iptables -A INPUT -s <specific_ip_address> -j DROP
```

#### b. REJECT a Packet
```bash
sudo iptables -A INPUT -s <specific_ip_address> -j REJECT
```

### 8. Log for Specific Rule
```bash
sudo iptables -A INPUT -s <specific_ip_address> -j LOG --log-prefix "IPTables-Dropped: "
```

### 9. Log for Whole Chain
```bash
sudo iptables -A INPUT -j LOG --log-prefix "IPTables-INPUT: "
```

### 10. Connection Track
#### Allow Established and Related Connections
```bash
sudo iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
```

### Other Useful Commands
#### Flush All Rules
```bash
sudo iptables -F
```

#### Delete Specific Rule
```bash
# List rules with line numbers
sudo iptables -L INPUT --line-numbers

# Delete rule (replace <line_number> with the actual number)
sudo iptables -D INPUT <line_number>
```

#### Save Current Rules
```bash
sudo iptables-save > /etc/iptables/rules.v4
```

#### Restore Saved Rules
```bash
sudo iptables-restore < /etc/iptables/rules.v4
```

#### Clear All Rules
```bash
sudo iptables -F
```

### Summary

This list covers a wide range of `iptables` commands for various tasks such as viewing rules, setting policies, adding rules, logging, and managing connections. Always be careful when applying these commands, especially on production systems or remote servers, to avoid losing access or disrupting services.
In `iptables`, you can either append or insert rules into a chain. Here's how you can use both commands:

### Append a Rule

Appending a rule adds it to the end of a chain.

```bash
sudo iptables -A <chain> <rule-specification>
```

### Insert a Rule

Inserting a rule places it at a specific position in a chain.

```bash
sudo iptables -I <chain> <position> <rule-specification>
```

### Examples

#### Append Rules

1. **Append a Rule to Allow SSH on Port 22**

```bash
sudo iptables -A INPUT -p tcp --dport 22 -j ACCEPT
```

2. **Append a Rule to Allow ICMP (Ping)**

```bash
sudo iptables -A INPUT -p icmp -j ACCEPT
```

3. **Append a Rule to Deny ICMP**

```bash
sudo iptables -A INPUT -p icmp -j DROP
```

4. **Append a Rule to Allow Traffic from a Specific IP**

```bash
sudo iptables -A INPUT -s <specific_ip_address> -j ACCEPT
```

5. **Append a Rule to Allow Traffic from a Specific Network**

```bash
sudo iptables -A INPUT -s <specific_network_address>/<subnet_mask> -j ACCEPT
```

#### Insert Rules

1. **Insert a Rule to Allow SSH on Port 22 at the First Position**

```bash
sudo iptables -I INPUT 1 -p tcp --dport 22 -j ACCEPT
```

2. **Insert a Rule to Allow ICMP (Ping) at the First Position**

```bash
sudo iptables -I INPUT 1 -p icmp -j ACCEPT
```

3. **Insert a Rule to Deny ICMP at the Second Position**

```bash
sudo iptables -I INPUT 2 -p icmp -j DROP
```

4. **Insert a Rule to Allow Traffic from a Specific IP at the Third Position**

```bash
sudo iptables -I INPUT 3 -s <specific_ip_address> -j ACCEPT
```

5. **Insert a Rule to Allow Traffic from a Specific Network at the Fourth Position**

```bash
sudo iptables -I INPUT 4 -s <specific_network_address>/<subnet_mask> -j ACCEPT
```

### Summary

- **Append (`-A`)**: Adds the rule to the end of the chain.
- **Insert (`-I`)**: Adds the rule at the specified position in the chain.

### Combining with Other Commands

#### Append to OUTPUT Chain to Deny Specific Destination

```bash
sudo iptables -A OUTPUT -d <specific_destination_ip> -j DROP
```

#### Insert to OUTPUT Chain to Deny Specific Destination at the First Position

```bash
sudo iptables -I OUTPUT 1 -d <specific_destination_ip> -j DROP
```

#### Append DROP Rule

```bash
sudo iptables -A INPUT -s <specific_ip_address> -j DROP
```

#### Insert DROP Rule at the Second Position

```bash
sudo iptables -I INPUT 2 -s <specific_ip_address> -j DROP
```

#### Append REJECT Rule

```bash
sudo iptables -A INPUT -s <specific_ip_address> -j REJECT
```

#### Insert REJECT Rule at the Third Position

```bash
sudo iptables -I INPUT 3 -s <specific_ip_address> -j REJECT
```

#### Append Log Rule

```bash
sudo iptables -A INPUT -s <specific_ip_address> -j LOG --log-prefix "IPTables-Dropped: "
```

#### Insert Log Rule at the Fourth Position

```bash
sudo iptables -I INPUT 4 -s <specific_ip_address> -j LOG --log-prefix "IPTables-Dropped: "
```

#### Append Connection Tracking Rule

```bash
sudo iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
```

#### Insert Connection Tracking Rule at the First Position

```bash
sudo iptables -I INPUT 1 -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
```

This should cover the majority of cases where you might need to use append or insert with `iptables`.
The order of `iptables` rules is crucial because `iptables` processes rules sequentially from top to bottom within each chain. The first rule that matches a packet will be applied, and no further rules in that chain will be checked. Therefore, the placement of rules can significantly impact the behavior of your firewall.

### Understanding Rule Order

1. **Top-to-Bottom Processing**: Rules are processed from the first to the last. The first rule that matches a packet dictates the action taken.
2. **Default Policy**: If no rules match, the default policy for the chain determines the packet's fate.

### Example of Rule Order Impact

Consider the following `iptables` rules:

1. **Allow All Traffic from a Specific IP**
   ```bash
   sudo iptables -A INPUT -s 192.168.1.100 -j ACCEPT
   ```

2. **Drop All ICMP Traffic**
   ```bash
   sudo iptables -A INPUT -p icmp -j DROP
   ```

3. **Allow All SSH Traffic**
   ```bash
   sudo iptables -A INPUT -p tcp --dport 22 -j ACCEPT
   ```

If a packet from IP `192.168.1.100` is received, it will be accepted by the first rule, regardless of whether it is an ICMP packet or an SSH packet. If a packet is ICMP from any other IP, it will be dropped by the second rule. An SSH packet from any other IP would be accepted by the third rule.

### Examples of Rule Order

1. **Allow Established and Related Connections First**
   ```bash
   sudo iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
   ```

2. **Allow SSH Traffic on Port 22**
   ```bash
   sudo iptables -A INPUT -p tcp --dport 22 -j ACCEPT
   ```

3. **Allow HTTP Traffic on Port 80**
   ```bash
   sudo iptables -A INPUT -p tcp --dport 80 -j ACCEPT
   ```

4. **Allow HTTPS Traffic on Port 443**
   ```bash
   sudo iptables -A INPUT -p tcp --dport 443 -j ACCEPT
   ```

5. **Drop All Other Incoming Traffic**
   ```bash
   sudo iptables -A INPUT -j DROP
   ```

### Insert vs. Append for Order Management

- **Append (`-A`)**: Adds a rule at the end of the chain.
- **Insert (`-I`)**: Adds a rule at a specific position in the chain.

### Example of Using Insert for Order Control

1. **Insert Rule to Allow SSH Traffic at the Top**
   ```bash
   sudo iptables -I INPUT 1 -p tcp --dport 22 -j ACCEPT
   ```

2. **Insert Rule to Allow Established and Related Connections at the Top**
   ```bash
   sudo iptables -I INPUT 1 -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
   ```

3. **Append Rule to Drop All Other Incoming Traffic**
   ```bash
   sudo iptables -A INPUT -j DROP
   ```

### Checking the Order of Rules

You can list the rules with line numbers to see the order:

```bash
sudo iptables -L INPUT --line-numbers
```

### Example Scenario

1. **Allow All Established and Related Connections**
   ```bash
   sudo iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
   ```

2. **Allow Incoming SSH Traffic**
   ```bash
   sudo iptables -A INPUT -p tcp --dport 22 -j ACCEPT
   ```

3. **Allow Incoming HTTP Traffic**
   ```bash
   sudo iptables -A INPUT -p tcp --dport 80 -j ACCEPT
   ```

4. **Drop All Other Incoming Traffic**
   ```bash
   sudo iptables -A INPUT -j DROP
   ```

In this scenario, established and related connections are prioritized. Then, specific ports for SSH and HTTP are allowed. Finally, any other incoming traffic is dropped, ensuring a secure and controlled flow of packets.

### Summary

The order of `iptables` rules is essential for defining the behavior of your firewall. Using `-A` to append rules and `-I` to insert rules at specific positions allows you to control the order and ensure that the most critical rules are evaluated first. Regularly reviewing the rules with line numbers can help maintain the desired order and functionality.

### References
[iptables syntax](https://www.ellipsix.net/geninfo/firewall/iptables/reference.html)
Rate limiting in `iptables` is used to control the number of packets processed over a period of time, which can help mitigate various types of attacks like Denial of Service (DoS) or brute-force attempts. The `limit` module in `iptables` allows you to set rate limits on rules.

### Basic Syntax for Rate Limiting

The `limit` module uses the following options:
- `--limit`: Specifies the maximum average matching rate.
- `--limit-burst`: Specifies the maximum initial number of packets to match. After this number is reached, the rate specified by `--limit` applies.

### Examples of Rate Limiting

1. **Limit SSH Connections to 3 per Minute**
   ```bash
   sudo iptables -A INPUT -p tcp --dport 22 -m limit --limit 3/minute --limit-burst 5 -j ACCEPT
   ```

2. **Limit ICMP (Ping) Requests to 1 per Second**
   ```bash
   sudo iptables -A INPUT -p icmp -m limit --limit 1/second --limit-burst 3 -j ACCEPT
   ```

3. **Log Dropped Packets at a Rate of 2 per Minute**
   ```bash
   sudo iptables -A INPUT -m limit --limit 2/minute --limit-burst 10 -j LOG --log-prefix "IPTables-Dropped: "
   ```

4. **Drop Excessive ICMP Requests**
   ```bash
   sudo iptables -A INPUT -p icmp -m limit --limit 1/second --limit-burst 3 -j ACCEPT
   sudo iptables -A INPUT -p icmp -j DROP
   ```

5. **Limit Connections from a Specific IP to 10 per Minute**
   ```bash
   sudo iptables -A INPUT -s 192.168.1.100 -m limit --limit 10/minute --limit-burst 20 -j ACCEPT
   ```

### Detailed Examples

#### 1. Rate Limiting SSH Connections

To protect against brute-force attacks on SSH, limit the number of connections:
```bash
sudo iptables -A INPUT -p tcp --dport 22 -m state --state NEW -m recent --set
sudo iptables -A INPUT -p tcp --dport 22 -m state --state NEW -m recent --update --seconds 60 --hitcount 4 -j DROP
```

Explanation:
- The first rule marks new SSH connection attempts.
- The second rule drops any new SSH connections if there are more than 3 attempts in the last 60 seconds.

#### 2. Rate Limiting HTTP Requests

To prevent abuse of HTTP services, limit the rate of incoming HTTP requests:
```bash
sudo iptables -A INPUT -p tcp --dport 80 -m limit --limit 25/minute --limit-burst 100 -j ACCEPT
```

Explanation:
- This rule allows up to 100 requests initially and then 25 requests per minute.

### Combining Rate Limiting with Logging

To log packets that exceed the rate limit before dropping them:
```bash
sudo iptables -A INPUT -p icmp -m limit --limit 1/second --limit-burst 3 -j ACCEPT
sudo iptables -A INPUT -p icmp -m limit --limit 1/minute -j LOG --log-prefix "Excessive ICMP: "
sudo iptables -A INPUT -p icmp -j DROP
```

### Using `hashlimit` for More Granular Control

The `hashlimit` module provides more granular control by allowing limits per source IP, destination IP, etc.

Example to limit connections per source IP:
```bash
sudo iptables -A INPUT -p tcp --dport 80 -m hashlimit --hashlimit 10/minute --hashlimit-burst 20 --hashlimit-mode srcip --hashlimit-name http_limit -j ACCEPT
```

### Summary

Rate limiting with `iptables` helps in mitigating attacks by controlling the number of packets processed over time. Using the `limit` and `hashlimit` modules, you can set fine-grained rules to protect services like SSH, HTTP, and ICMP from being overwhelmed. Always test your rules to ensure they work as expected without blocking legitimate traffic.


## References
[IP Accounting](https://www.cyberciti.biz/faq/linux-configuring-ip-traffic-accounting/)
[IP Tables rules](https://www.cyberciti.biz/tips/linux-iptables-examples.html)
