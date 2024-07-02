Firewalld is a firewall management tool used primarily in Red Hat-based Linux distributions such as CentOS, Fedora, and RHEL. It provides a dynamically managed firewall with support for network zones and allows for runtime changes without disrupting active connections. Here’s a tutorial to get you started with Firewalld:

### 1. **Installing Firewalld**

If Firewalld is not already installed on your system, you can install it using your package manager:

```bash
sudo yum install firewalld    # For CentOS/RHEL
sudo dnf install firewalld    # For Fedora
```

### 2. **Basic Firewalld Usage**

#### Starting and Enabling Firewalld

To start Firewalld and enable it to start on boot:

```bash
sudo systemctl start firewalld
sudo systemctl enable firewalld
```

#### Checking Firewalld Status

To check the status of Firewalld and view active zones and rules:

```bash
sudo firewall-cmd --state
sudo firewall-cmd --get-active-zones
sudo firewall-cmd --list-all
```

### 3. **Managing Zones**

Firewalld uses zones to define the level of trust for network connections. Each zone has its own set of predefined rules. Common zones include `public`, `internal`, `trusted`, `home`, `work`, and `block`.

#### Listing Available Zones

To list available zones:

```bash
sudo firewall-cmd --get-zones
```

#### Assigning Interfaces to Zones

To assign an interface to a specific zone (e.g., `public`):

```bash
sudo firewall-cmd --zone=public --change-interface=eth0
```

### 4. **Managing Services**

Firewalld provides predefined service definitions that simplify rule management for commonly used services.

#### Listing Available Services

To list available services:

```bash
sudo firewall-cmd --get-services
```

#### Adding Services to Zones

To allow a service (e.g., `ssh`) in a specific zone (e.g., `public`):

```bash
sudo firewall-cmd --zone=public --add-service=ssh --permanent
```

### 5. **Managing Ports**

Firewalld allows you to manage ports and port ranges for specific zones.

#### Opening Ports

To open a specific port (e.g., `80/tcp`) in a zone (e.g., `public`):

```bash
sudo firewall-cmd --zone=public --add-port=80/tcp --permanent
```

#### Reloading Firewalld

After making changes, reload Firewalld to apply them:

```bash
sudo firewall-cmd --reload
```

### 6. **Rich Rules**

Firewalld supports rich rules, which are more complex rules that allow greater flexibility in defining packet matching criteria.

#### Adding Rich Rules

To add a rich rule to allow traffic from a specific IP address (`192.168.1.100`) to a specific port (`8080/tcp`) in a zone (`public`):

```bash
sudo firewall-cmd --zone=public --add-rich-rule='rule family="ipv4" source address="192.168.1.100" port protocol="tcp" port="8080" accept' --permanent
```

### 7. **Handling Masquerading and NAT**

Firewalld supports masquerading (SNAT) and port forwarding (DNAT) through zone configurations and rich rules.

#### Masquerading

To enable masquerading (SNAT) for outgoing traffic in a zone (e.g., `public`):

```bash
sudo firewall-cmd --zone=public --add-masquerade --permanent
```

#### Port Forwarding (DNAT)

To configure port forwarding (DNAT) in a zone (e.g., `public`):

```bash
sudo firewall-cmd --zone=public --add-forward-port=port=8080:proto=tcp:toport=80 --permanent
```

### 8. **Managing Firewalld Services**

Firewalld is controlled using the `firewall-cmd` command-line tool. Use `man firewall-cmd` for comprehensive documentation and explore additional options and commands available.

### Summary

Firewalld provides a flexible and user-friendly way to manage firewall rules, zones, services, and advanced configurations on Linux systems. By using its command-line tools effectively, you can configure robust firewall settings tailored to your network security requirements. Regularly review and adjust firewall rules to ensure optimal protection and performance.

Certainly! Here are more advanced tutorials and configurations for using Firewalld on your CentOS, Fedora, or RHEL-based Linux system:

### 1. **Logging Configuration**

Firewalld supports logging of firewall activities, which can be helpful for troubleshooting and monitoring security events.

#### Enabling Logging

To enable logging for specific zones:

```bash
sudo firewall-cmd --zone=public --set-log-denied=all
```

#### Viewing Logs

View firewall logs to monitor denied packets:

```bash
sudo journalctl -u firewalld
```

### 2. **Creating Custom Zones**

You can create custom zones in Firewalld to define specific firewall rules tailored to your network setup.

#### Creating a Custom Zone

Create a new custom zone named `myzone`:

```bash
sudo firewall-cmd --permanent --new-zone=myzone
```

#### Assigning Interfaces to Custom Zones

Assign interfaces to your custom zone (`myzone`):

```bash
sudo firewall-cmd --zone=myzone --add-interface=eth1 --permanent
```

### 3. **Using Aliases**

Firewalld allows you to define aliases for commonly used IP addresses, ports, or services, simplifying rule management.

#### Creating Aliases

Create an alias for a specific IP address:

```bash
sudo firewall-cmd --permanent --new-ipset=my-alias --type=hash:ip --option=family=inet --option=hashsize=4096 --option=maxelem=200
```

#### Adding Entries to Aliases

Add IP addresses to the alias:

```bash
sudo firewall-cmd --permanent --ipset=my-alias --add-entry=192.168.1.100
```

### 4. **Using Zones for Different Network Scenarios**

Firewalld zones allow you to define different levels of trust for network connections. Here’s how to use zones effectively:

#### Setting Default Zone

Set the default zone for incoming connections:

```bash
sudo firewall-cmd --set-default-zone=public
```

### 5. **Dynamic Updates and Runtime Changes**

Firewalld allows for dynamic updates and runtime changes without disrupting active connections, making it flexible for adapting to network changes.

#### Applying Changes

Apply changes to Firewalld configurations:

```bash
sudo firewall-cmd --reload
```

### 6. **Managing Services**

Firewalld provides predefined service definitions for commonly used services, making it easier to manage firewall rules.

#### Creating Custom Services

Create a custom service definition for a specific application (e.g., `myapp`):

```bash
sudo firewall-cmd --permanent --new-service=myapp
```

#### Adding Ports to Custom Services

Add ports to your custom service (`myapp`):

```bash
sudo firewall-cmd --permanent --service=myapp --add-port=8080/tcp
```

### 7. **Rich Rules for Complex Configurations**

Rich rules in Firewalld allow you to create more complex firewall rules based on packet matching criteria.

#### Adding Rich Rules

Add a rich rule to allow traffic from a specific IP address (`192.168.1.100`) to a specific port (`8080/tcp`):

```bash
sudo firewall-cmd --zone=public --add-rich-rule='rule family="ipv4" source address="192.168.1.100" port protocol="tcp" port="8080" accept' --permanent
```

### 8. **Port Forwarding and Masquerading**

Firewalld supports port forwarding (DNAT) and masquerading (SNAT) configurations through zone settings and rich rules.

#### Port Forwarding

Configure port forwarding (DNAT) in a specific zone (`public`):

```bash
sudo firewall-cmd --zone=public --add-forward-port=port=8080:proto=tcp:toport=80 --permanent
```

#### Masquerading

Enable masquerading (SNAT) for outgoing traffic in a zone (`public`):

```bash
sudo firewall-cmd --zone=public --add-masquerade --permanent
```

### Summary

Firewalld provides powerful capabilities for managing firewall rules, zones, services, and advanced configurations on Linux systems. By leveraging its features effectively, you can enhance network security, manage access controls, and adapt to changing network environments with ease. Regularly review and update your Firewalld configurations to maintain optimal security and performance for your infrastructure.

