Certainly! `systemd-resolved` is a system service in Linux that provides network name resolution to local applications. It is responsible for DNS caching and resolves domain names, making network connections more efficient. Here’s a tutorial on how to use and configure `systemd-resolved` effectively:

### 1. **Introduction to `systemd-resolved`**

`systemd-resolved` operates as a local DNS stub resolver and DNS cache. It handles DNS queries from local applications and forwards them to DNS servers configured in your system's network settings.

### 2. **Basic Commands**

#### Checking `systemd-resolved` Status

You can check the status of `systemd-resolved` using the following command:

```bash
systemctl status systemd-resolved
```

#### Restarting `systemd-resolved`

If needed, you can restart the `systemd-resolved` service:

```bash
sudo systemctl restart systemd-resolved
```

### 3. **Configuration**

#### Default Configuration File

The main configuration file for `systemd-resolved` is `/etc/systemd/resolved.conf`. This file typically contains default settings and can be modified as needed.

#### Viewing `systemd-resolved` Configuration

To view the current configuration settings:

```bash
sudo systemd-resolve --status
```

### 4. **Using `systemd-resolve` Command**

#### Resolving DNS Queries

You can use the `systemd-resolve` command to resolve DNS queries directly from the command line:

```bash
systemd-resolve google.com
```

#### Displaying DNS Cache

To display the current DNS cache maintained by `systemd-resolved`:

```bash
systemd-resolve --statistics
```

### 5. **Configuration Options**

#### Changing DNS Servers

To change the DNS servers used by `systemd-resolved`, edit the `/etc/systemd/resolved.conf` file:

```conf
[Resolve]
DNS=8.8.8.8 8.8.4.4
```

After editing, restart `systemd-resolved` for changes to take effect:

```bash
sudo systemctl restart systemd-resolved
```

#### Using DHCP DNS Configuration

If your system obtains DNS servers dynamically via DHCP, `systemd-resolved` will use these settings by default.

### 6. **Integration with `systemd-networkd`**

`systemd-resolved` integrates with `systemd-networkd`, which is used for network configuration. Together, they provide a streamlined approach to managing network connections and DNS resolution.

### 7. **Troubleshooting**

#### Check `systemd-resolved` Logs

To troubleshoot issues, check the logs for `systemd-resolved`:

```bash
journalctl -u systemd-resolved.service
```

### 8. **Using `resolvectl`**

`resolvectl` is a utility that interacts with `systemd-resolved` and provides additional management options:

#### Listing DNS Servers

To list configured DNS servers:

```bash
resolvectl status
```

#### Setting DNS Servers

To dynamically set DNS servers:

```bash
sudo resolvectl dns eth0 8.8.8.8 8.8.4.4
```

Replace `eth0` with your network interface.

### Summary

`systemd-resolved` simplifies DNS management on Linux systems by providing caching and stub resolver functionalities. By understanding its configuration options and commands, you can effectively manage DNS resolution and troubleshoot DNS-related issues in your network environment.

Advanced configuration of `systemd-resolved` involves more detailed settings and customization options beyond basic DNS server management. Here are some advanced configurations and techniques for `systemd-resolved`:

### 1. **DNSSEC Validation**

DNS Security Extensions (DNSSEC) ensures authenticity and integrity of DNS responses. `systemd-resolved` supports DNSSEC validation, which can be enabled in its configuration file.

#### Enable DNSSEC Validation

Edit `/etc/systemd/resolved.conf` and add or uncomment the following lines:

```conf
[Resolve]
DNSSEC=yes
```

After editing, restart `systemd-resolved`:

```bash
sudo systemctl restart systemd-resolved
```

#### Verify DNSSEC Status

You can check the DNSSEC validation status using `resolvectl`:

```bash
resolvectl status
```

Look for `DNSSEC setting` in the output.

### 2. **DNS Over TLS (DoT)**

DNS over TLS encrypts DNS queries and responses, enhancing privacy and security. `systemd-resolved` supports configuring DoT servers.

#### Configure DNS Over TLS

Edit `/etc/systemd/resolved.conf` and add or modify the following lines:

```conf
[Resolve]
DNSOverTLS=yes
DNS=1.1.1.1 1.0.0.1 # Example Cloudflare DoT servers
```

After editing, restart `systemd-resolved`:

```bash
sudo systemctl restart systemd-resolved
```

### 3. **Custom DNS Search Domains**

You can specify custom DNS search domains for domain name resolution.

#### Add Custom Search Domains

Edit `/etc/systemd/resolved.conf` and add or modify the following lines:

```conf
[Resolve]
Domains=mydomain.com example.com
```

### 4. **Fallback DNS Servers**

Specify fallback DNS servers to use if the primary DNS servers are unavailable.

#### Configure Fallback DNS Servers

Edit `/etc/systemd/resolved.conf` and add or modify the following lines:

```conf
[Resolve]
FallbackDNS=8.8.8.8 8.8.4.4
```

### 5. **DNS Stub Listener**

By default, `systemd-resolved` listens on `127.0.0.53:53` for DNS queries from local applications. You can configure it to listen on other interfaces and ports.

#### Configure DNS Stub Listener

Edit `/etc/systemd/resolved.conf` and add or modify the following lines:

```conf
[Resolve]
DNSStubListener=yes
# Uncomment and modify the following to listen on specific interfaces and ports:
# DNSStubListenerExtra=eth0 192.168.1.1:53
```

### 6. **Multicast DNS (mDNS) Support**

`systemd-resolved` supports multicast DNS for local name resolution.

#### Enable mDNS

Edit `/etc/systemd/resolved.conf` and add or modify the following lines:

```conf
[Resolve]
MulticastDNS=yes
```

### 7. **Advanced `resolvectl` Usage**

`resolvectl` provides additional management capabilities for `systemd-resolved`.

#### Flush DNS Cache

Flush the DNS cache maintained by `systemd-resolved`:

```bash
sudo resolvectl flush-caches
```

#### Set Global DNS Servers

Set global DNS servers for all interfaces:

```bash
sudo resolvectl dns --set 8.8.8.8 8.8.4.4
```

### Summary

`systemd-resolved` offers advanced configurations such as DNSSEC validation, DNS over TLS, custom search domains, fallback DNS servers, DNS stub listener customization, mDNS support, and more. By leveraging these advanced features, you can enhance DNS security, privacy, and network name resolution capabilities on your Linux system effectively.
