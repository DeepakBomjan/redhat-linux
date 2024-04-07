## - Running Your First Podman Container
Commands Covered
- `podman ps`: list podman containers
- `podman images`: displays local containerimages
- `podman search`: search registrie(s) forimages
- `podman run`:runs a command in a new containerfrom a given image
- `podman exec`: executes a command in a running container
- `podman stop`: stops a running container
- `podman rm`:removes a container
- `podman rmi`:removes a containerimage from local storage
1. Run Your FirstPodman Container!

```bash
podman ps -a
```
As root:
```bash
sudo podman ps -a
```
There should be no containers running.
2. Let's check our containerimages:
```bash
podman images
```
As you can see, we don't have any images yet.
3. Run a `httpd-24` container. Let's search for one:
```bash
podman search httpd-24 | more
```
Let's use the `docker.io/centos/httpd-24-centos8` image.
4. Run our container in detached mode, with a `tty` to run commands:
```bash
podman run -dt docker.io/centos/httpd-24-centos8
```
Note that we didn't have to pull the containerimage to run it. When we ran the container, podman pulled the
containerimage for us.
5. Let's check our containers now:
```bash
podman ps -a
```

6. Let's check our containerimages:
```bash
podman images
```


7. Open a bash shell in our container:
```bash
podman exec -it <container_ID> /bin/bash
```

8. Check the version of the operating system our containeridentifies as:
```bash
cat /etc/redhat-release
```
The container identifies itself as CentOS 8.
If we try accessing the Apache web serverrunning on port 8080 using curl:
```bash
curl http://localhost:8080
```
We see that we get the CentOS Apache servertest page, albeit in text.
9. Let's exit our container shell:
```bash
exit
```
Back in our server, if we try accessing the Apache web serverrunning on port 8080 in our container using
curl:
```bash
curl http://localhost:8080
```
We see that we can't access the Apache web serverrunning in the container. This is because we haven't published those ports to the host. We're going to get into that in an upcoming lesson.
10. Let's check our containers again:
```bash
podman ps -a
```
We can see our running httpd-24-centos8:latest container.
11. Stop our container:
```bash
podman stop <container_ID>
```
12. Check our containers again:
```bash
podman ps -a
```
We can see our containeris stopped now. We're done with our container.
13. Remove it:
```bash
podman rm <container_ID>
```
14. Check our containers again:
```bash
podman ps -a
```

15. Remove our httpd-24-centos8:latest image:
```bash
podman rmi httpd-24-centos8:latest
```

## Tutorial 2

1. Run a pms-docker Plex Media Server container:
```bash
podman run -dt docker.io/plexinc/pms-docker
```
2. Check forthe container:
```bash
podman ps -a
```
Note that the container has been assigned a containerID.
3. Stop our pms-docker container:
```bash
podman stop <container_ID>
```
4. Check the container:
```bash
podman ps -a
```
Our containeris stopped.
5. Start it back up:
```bash
podman start <container_ID>
```
6. Check the container:
```bash
podman ps -a
```
Our containeris running again!
7. Restart our container:
```bash
podman restart <container_ID>
```
8. Check the container:
```bash
podman ps -a
```
9. Kill the command
We can see that our container has been restarted.
Occasionally, our container may stop behaving, and we may need to kill it. We can do that using the podman 
kill command:
```bash
podman kill <container_ID>
```
10. Check the container:
```bash
podman ps -a
```
11. Create a nginx container, but not start it:
```bash
podman create -t --name mynginx docker.io/library/nginx
```
12. Check the container:
```bash
podman ps -a
```
We see our nginx container, with the name mynginx,ready for us to call it to action. 
13. Start it:
```bash
podman start mynginx
```
14. Check the container:
```bash
podman ps -a
```
The mynginx containeris up and running!
There are a couple of operations we can only run on root containers. Let's try them using sudo.
15. Start a ubi8 container as root, using sudo:
```bash
sudo podman run -dt --name rootubi8 registry.access.redhat.com/ubi8
```
16. Check the container:
```bash
sudo podman ps -a
```
We can see the rootubi8 container,running as root.
17. Pause the rootubi8 container:
```bash
sudo podman pause rootubi8
```
18. Check the container:
```bash
sudo podman ps -a
```
The rootubi8 containeris paused!
19. Unpause the container, using podman unpause with sudo:
```bash
sudo podman unpause rootubi8
```
20. Check the container:
```bash
sudo podman ps -a
```
The rootubi8 containeris running again!
### Working With Running Containers

1. podman container start command:
```bash
podman container start <container_ID>
```

2. Interact with our container. One way is to use the podman exec command to run a
bash shell:
```bash
podman exec -it mynginx /bin/bash
```

3. Run a command inside a container, but not interact. 
```bash
sudo podman exec rootubi8 cat /etc/redhat-release
```
