# Linux Routing
![image](../images/light-road-landscape-sign-routing.jpeg)


### Displaying existing routes
```bash
ip route  show
```
### Adding new routes
```bash
ip route add 10.0.2.0/24 via 192.168.0.1 dev enp0s3
```
### Removing routes
```bash
sudo ip route del 10.0.2.0/24 via 192.168.0.1 dev enp0s3
```

### Adding a new default gateway
```bash
ip route add default via 192.168.0.1
```

## Example of a network that requires static routes

###  Configuring a static route by using nmcli

### References:

https://tldp.org/HOWTO/Adv-Routing-HOWTO/lartc.rpdb.html

[Configure Linux as a Router (IP Forwarding)](https://www.linode.com/docs/guides/linux-router-and-ip-forwarding/?tabs=iptables)

[Setting Up Ubuntu as a Router with Advanced Routing Features](https://medium.com/@lfoster49203/setting-up-ubuntu-as-a-router-with-advanced-routing-features-4511abc5e1eb)

[Configuring policy-based routing to define alternative routes](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/8/html/configuring_and_managing_networking/configuring-policy-based-routing-to-define-alternative-routes_configuring-and-managing-networking#routing-traffic-from-a-specific-subnet-to-a-different-default-gateway-by-using-nmcli_configuring-policy-based-routing-to-define-alternative-routes)
![image](../images/policy-based-routing.png)