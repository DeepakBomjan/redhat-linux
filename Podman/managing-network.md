## Managing Container Networking Using Podman

### Commands Covered
* `podman network`: execute Podman networking commands
* `podman port`: display published Podman ports
* `podman inspect`: display detailed information on an object
* `Podman Networking` - Rootless Containers

### Podman Networking - Rootless Containers
Generally, when we want to make a service or application available on Podman rootless containers, we do it by publishing that application's ports.

1. Publish the container's ports, using `-P` or `--publish-all` option. 
```bash
podman run -dt --name web1 --publish-all nginx
```
2. Checking our containers:
```bash
podman ps -a
```
We see our running container, and that port 80 on the container has been published to a random port that's
been chosen by podman.
2. Connect the webserver:
```bash
curl http://localhost:<port>
```
3. view all published ports:
```bash
podman port -a
```

4. Start another nginx container, but publish port 80 in the containerto port 8080 on the host:
```bash
podman run -dt --name web2 -p 8080:80 nginx
```

```bash
podman ps -a
```
5. Checking our published ports:
```bash
podman port -a
```
6. Start one more nginx container, but publish port 80 in the containerto port 8081 on the host:
```bash
podman run -dt --name web3 -p 8081:80 nginx
```
Checking our containers:
```bash
podman ps -a
```
Checking our published ports:
```bash
podman port -a
```
7. Connect to our just-launched web servers on ports 8080 and 8081:
```bash
curl http://localhost:8080
curl http://localhost:8081
```

## Podman Networking - Rootfull Containers
Podman containers that are run with root privileges, either directly or using sudo, enjoy additional network functionality. These containers are given an IP address.
1. Become root and explore:
```bash
sudo su -
```
2. List networks:
```bash
podman network ls
```
We can see the default `podman` network.
3. To get information about the podman network:
```bash
podman network inspect podman | more
```
Podman returns detailed information, including the network,routing and firewall information.
4. Launch a container and see how it works:
```bash
podman run -dt --name rootweb1 --publish-all nginx
```
Checking our containers:
```bash
podman ps -a
```
Checking our published ports:
```bash
podman port -a
```
We can see our container and the random port that our nginx web server has been published to.
5. Connect to our web server on the port that podman has chosen for us:
```bash
curl http://localhost:<port>
```
We see our default index page for nginx.
6. Get the IP address of our rootweb1 container, we can use:
```bash
podman inspect rootweb1 | grep IPAddress
```
Now, we can try to access our nginx web server using the IP address of our container:
```bash
curl http://<ip_address>
```

7. Create a second podman network called `test-net`, we can do that using:
```bash
podman network create `test-net`
```
Pulling a list of its networks again:
```bash
podman network ls
```
8. Connect our `rootweb1` container to our new `test-net` network using:
```bash 
podman network connect test-net rootweb1
```
9. Check `rootweb1` container's IP addresses now:
```bash
podman inspect rootweb1 | grep IPAddress
```
We can see two IP addresses now!
Accessing our web server via the new IP address:
```bash
curl http://<ip_address>
```

10. Disconnect and remove the test-net network:
```bash
podman network disconnect test-net rootweb1
podman network rm test-net
```
Checking our networks now:
```bash
podman network ls
```
