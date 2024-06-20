Setting up and configuring UFW (Uncomplicated Firewall) provides a simple way to manage firewall rules on Ubuntu and other Debian-based Linux distributions. Here’s a comprehensive tutorial on using UFW:

### 1. Installing UFW

UFW is installed by default on most Ubuntu installations. If it's not installed, you can install it using the following command:
```bash
sudo apt-get install ufw
```

### 2. Basic Usage

#### Enabling UFW
To enable UFW, use:
```bash
sudo ufw enable
```

#### Disabling UFW
To disable UFW, use:
```bash
sudo ufw disable
```

#### Checking Status
To check the status of UFW:
```bash
sudo ufw status verbose
```

### 3. Setting Default Policies

#### Default Policies
By default, UFW denies all incoming connections and allows all outgoing connections. You can change these defaults:
```bash
sudo ufw default deny incoming
sudo ufw default allow outgoing
```

### 4. Allowing and Denying Connections

#### Allowing Connections
To allow connections on a specific port:
```bash
sudo ufw allow 22/tcp     # Allow SSH
sudo ufw allow 80/tcp     # Allow HTTP
```
To allow connections from a specific IP address:
```bash
sudo ufw allow from 192.168.1.100
```

#### Denying Connections
To deny connections on a specific port:
```bash
sudo ufw deny 22/tcp      # Deny SSH
```
To deny connections from a specific IP address:
```bash
sudo ufw deny from 192.168.1.100
```

### 5. Deleting Rules

#### Deleting Rules
To delete a rule:
```bash
sudo ufw delete allow 80/tcp
```

### 6. Application Profiles

#### Application Profiles
UFW provides pre-defined application profiles which can be enabled:
```bash
sudo ufw app list       # List available application profiles
sudo ufw allow 'Nginx Full'
```

### 7. Advanced Configuration

#### Logging
You can enable logging for UFW to monitor connections:
```bash
sudo ufw logging on
```

#### Limiting Connections
To limit the rate of connections:
```bash
sudo ufw limit 22/tcp
```

### 8. Reload UFW

#### Reloading UFW
After making changes to UFW rules, reload the firewall for changes to take effect:
```bash
sudo ufw reload
```

### 9. Resetting UFW

#### Resetting UFW
To reset UFW to default settings:
```bash
sudo ufw reset
```

### Conclusion

UFW provides a straightforward way to manage firewall rules on Ubuntu systems. By following this tutorial, you can configure UFW to allow or deny connections based on your specific requirements. Always be cautious when modifying firewall rules to avoid unintended consequences.

Certainly! You can allow or deny specific IP addresses, specific network ranges, and custom ports using UFW. Here's how to do it:

### Allowing/Denying Specific IP Addresses

#### Allowing Specific IP Address
To allow incoming connections from a specific IP address (e.g., `192.168.1.100`) on a specific port (e.g., `SSH - Port 22`):
```bash
sudo ufw allow from 192.168.1.100 to any port 22
```

#### Denying Specific IP Address
To deny incoming connections from a specific IP address (e.g., `192.168.1.100`) on all ports:
```bash
sudo ufw deny from 192.168.1.100
```

### Allowing/Denying Specific Network Ranges

#### Allowing Specific Network Range
To allow incoming connections from a specific network range (e.g., `192.168.1.0/24`) on a specific port (e.g., `HTTP - Port 80`):
```bash
sudo ufw allow from 192.168.1.0/24 to any port 80
```

#### Denying Specific Network Range
To deny incoming connections from a specific network range (e.g., `192.168.1.0/24`) on all ports:
```bash
sudo ufw deny from 192.168.1.0/24
```

### Allowing/Denying Custom Ports

#### Allowing Custom Port
To allow incoming connections on a custom port (e.g., `5000`) from any IP address:
```bash
sudo ufw allow 5000
```

#### Denying Custom Port
To deny incoming connections on a custom port (e.g., `5000`) from any IP address:
```bash
sudo ufw deny 5000
```

### Combining Rules

You can also combine rules to allow or deny specific IP addresses or network ranges on custom ports:
```bash
sudo ufw allow from 192.168.1.100 to any port 5000
```
This command allows incoming connections from `192.168.1.100` on port `5000`.

### Note
- Ensure that you replace `192.168.1.100`, `192.168.1.0/24`, and `5000` with your actual IP address, network range, and port number respectively.
- After adding or modifying rules, remember to reload UFW for changes to take effect:
```bash
sudo ufw reload
```

By following these examples, you can fine-tune your UFW rules to allow or deny specific IP addresses, network ranges, and custom ports according to your security requirements.

Sure, here's an advanced example of using UFW to set up a firewall on a Ubuntu server with multiple network interfaces, allowing specific services from certain IP addresses or networks while denying others:

### Scenario:

- **Server Setup**: The server has two network interfaces (`eth0` and `eth1`).
- **Requirements**:
  - Allow SSH (Port 22) access only from a specific IP address range (`192.168.1.0/24`) on both interfaces.
  - Allow HTTP (Port 80) and HTTPS (Port 443) access from any IP address on `eth0`, but deny access on `eth1`.
  - Allow MySQL (Port 3306) access from a specific IP address (`10.0.0.5`) on `eth1`.
  - Deny all other incoming connections.

### Steps:

1. **Enable UFW**:
   ```bash
   sudo ufw enable
   ```

2. **Set Default Policies**:
   ```bash
   sudo ufw default deny incoming
   sudo ufw default allow outgoing
   ```

3. **Allow SSH from Specific IP Range on Both Interfaces**:
   ```bash
   sudo ufw allow in on eth0 from 192.168.1.0/24 to any port 22
   sudo ufw allow in on eth1 from 192.168.1.0/24 to any port 22
   ```

4. **Allow HTTP and HTTPS on `eth0`**:
   ```bash
   sudo ufw allow in on eth0 to any port 80
   sudo ufw allow in on eth0 to any port 443
   ```

5. **Deny HTTP and HTTPS on `eth1`**:
   ```bash
   sudo ufw deny in on eth1 to any port 80
   sudo ufw deny in on eth1 to any port 443
   ```

6. **Allow MySQL from Specific IP Address on `eth1`**:
   ```bash
   sudo ufw allow in on eth1 from 10.0.0.5 to any port 3306
   ```

7. **Check Rules**:
   ```bash
   sudo ufw status verbose
   ```

8. **Reload UFW**:
   ```bash
   sudo ufw reload
   ```

### Conclusion:

This advanced example demonstrates how to configure UFW to implement a firewall with specific rules tailored to your server's requirements. By following these steps, you can create a secure firewall setup that allows only necessary traffic while blocking unauthorized access. Remember to test your firewall rules thoroughly to ensure they meet your security needs without inadvertently blocking legitimate traffic.
