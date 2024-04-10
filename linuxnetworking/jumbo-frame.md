## Configuring Jumbo Frames
- The **Maximum Transmission Unit (MTU)** setting determines the maximum amount of data transmitted with a single Ethernet frame.
- The default value is 1500
- Most switches support an MTU of at least 9000
### Test

```bash
 ip link set eth0 mtu 9000
 ```

```bash
ping -M do -c 4 -s 8196 10.1.1.21
```
```bash
ping -M do -c 4 -s 1408 10.1.1.21
```
```bash
ping -M want -s 8973 ph-rac-m002-node2p -I eth1
```
