# Basic Syntax for iptables Commands and Options
Here is a list of some common iptables options:

* `-A --append` – Add a rule to a chain(at the end).
* `-C --check` – Look for a rule that matches the chain’s requirements.
* `-D --delete` – Remove specified rules from a chain.
* `-F --flush` – Remove all rules.
* `-I --insert` – Add a rule to a chain at a given position.
* `-L --list` – Show all rules in a chain.
* `-N -new-chain` – Create a new chain.
* `-v --verbose` – Show more information * when using a list option.
* `-X --delete-chain` – Delete the * provided chain.

1. Check Current iptables Status
```bash
sudo iptables -L
```
2. Enable Loopback Traffic
```bash
sudo iptables -A INPUT -i lo -j ACCEPT
```
```bash
sudo iptables -A INPUT -i lo -j ACCEPT
sudo iptables -A OUTPUT -o lo -j ACCEPT
```

3. Allow Traffic on Specific Ports
```bash
sudo iptables -A INPUT -p tcp --dport 80 -j ACCEPT
```
```bash
sudo iptables -A INPUT -p tcp --dport 22 -j ACCEPT
```
```bash
sudo iptables -A INPUT -p tcp --dport 443 -j ACCEPT
```
4. Control Traffic by IP Address
```bash
sudo iptables -A INPUT -s 192.168.0.27 -j ACCEPT
```
```bash
sudo iptables -A INPUT -s 192.168.0.27 -j DROP
```
```bash
sudo iptables -A INPUT -m iprange --src-range 192.168.0.1-192.168.0.255 -j REJECT
```
5. Dropping Unwanted Traffic
```bash
sudo iptables -A INPUT -j DROP
```
6. Delete a Rule
```bash
sudo iptables -L --line-numbers
```
```bash
sudo iptables -D INPUT <Number>
```
7. Save Your Changes
```bash
sudo /sbin/iptables–save
```

8. Allowing Established and Related Incoming Connections
```bash
sudo iptables -A INPUT -m conntrack --ctstate ESTABLISHED,RELATED -j ACCEPT
```
9. Allowing Established Outgoing Connections
```bash
sudo iptables -A OUTPUT -m conntrack --ctstate ESTABLISHED -j ACCEPT
```
10. Allowing Internal Network to access External
```bash
sudo iptables -A FORWARD -i eth1 -o eth0 -j ACCEPT
```

11. Blocking Connections to a Network Interface
```bash
iptables -A INPUT -i eth0 -s 203.0.113.51 -j DROP
```
12. Allowing All Incoming SSH
```bash
sudo iptables -A INPUT -p tcp --dport 22 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
sudo iptables -A OUTPUT -p tcp --sport 22 -m conntrack --ctstate ESTABLISHED -j ACCEPT
```
13. Allowing Incoming SSH from Specific IP address or subnet
```bash
sudo iptables -A INPUT -p tcp -s 203.0.113.0/24 --dport 22 -m conntrack --ctstate NEW,ESTABLISHED -j ACCEPT
sudo iptables -A OUTPUT -p tcp --sport 22 -m conntrack --ctstate ESTABLISHED -j ACCEPT
```

14. Change policy
```bash
sudo iptables —policy INPUT ACCEPT
sudo iptables —policy OUTPUT ACCEPT
sudo iptables —policy FORWARD ACCEPT
```
15. Enable logging
```bash
sudo iptables -A INPUT -j LOG 
sudo iptables -A INPUT -p TCP -s 192.168.10.0/24 -j LOG 
sudo iptables -A INPUT -s 192.168.10.0/24 -j LOG --log-level 4 
```