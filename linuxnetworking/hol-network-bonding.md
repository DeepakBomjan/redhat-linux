## Enabling and Configuring Network Bonding or Teaming
1. Enable bonding module
```bash
modprobe --first-time bonding
```

2. To load permanently, create file inside `/etc/modules-load.d`
```bash

echo "# Load the bonding kernel module at boot" > /etc/modules-load.d/bonding.conf
echo "bonding" >> /etc/modules-load.d/bonding.conf
```

3. Create bonding using `nmtui`
4. Bring up the `bond0` interface
```bash
ip link set dev bond0 up
```
## Testing Network Bonding or Teaming in Linux
1. ping the bond interface ip
2. Monitor the traffic in bond0 interface
```bash
watch -d -n1 netstat -i
```
3. Change bond mode and observe the packet 

