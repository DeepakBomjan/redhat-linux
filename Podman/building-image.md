## Introducing Buildah and Dockerfiles
[Podman and Buildah for Docker users](https://developers.redhat.com/blog/2019/02/21/)

[Building with Buildah: Dockerfiles, command line, or scripts](https://www.redhat.com/sysadmin/building-buildah)

[Getting started with Buildah](https://www.redhat.com/sysadmin/getting-started-buildah)

[Buildah](https://buildah.io/)

## Creating a Container Image Using **Buildah** and a **Dockerfile**

1. Check the status of our Podman environment:
```bash
podman ps -a
```
```bash
buildah images
```
```bash
buildah containers
```

2. Dockerfile:
```Dockerfile
FROM fedora:latest
LABEL maintainer fedora-apache-container <apache@podman.rulez>
RUN dnf install -y httpd && dnf clean all
RUN echo "Test File 1" > /var/www/html/test1.txt
RUN echo "Test File 2" > /var/www/html/test2.txt
RUN echo "Test File 3" > /var/www/html/test3.txt
RUN echo "Test File 4" > /var/www/html/test4.txt
RUN echo "Test File 5" > /var/www/html/test5.txt
EXPOSE 80
CMD mkdir /run/httpd ; /usr/sbin/httpd -D FOREGROUND
```
3. Build images
```bash
buildah bud -t my-fedora-httpd:latest .
```
Checking our work:
```bash
buildah images
```
```bash
buildah containers
```

4. Run my-fedora-httpd Containers
```bash
podman run -d --name my-fedora-httpd-1 -p 8081:80 localhost/my-fedorahttpd
```
```bash
podman run -d --name my-fedora-httpd-2 -p 8082:80 localhost/my-fedorahttpd
```
```bash
podman run -d --name my-fedora-httpd-3 -p 8083:80 localhost/my-fedorahttpd
```
```bash
podman run -d --name my-fedora-httpd-4 -p 8084:80 localhost/my-fedorahttpd
```
```bash
podman run -d --name my-fedora-httpd-5 -p 8085:80 localhost/my-fedorahttpd
```
Checking our work:
```bash
podman ps -a
```
5. Testing Our my-fedora-httpd Containers
```bash
curl -s http://localhost:8081/test1.txt
curl -s http://localhost:8082/test2.txt
curl -s http://localhost:8083/test3.txt
curl -s http://localhost:8084/test4.txt
curl -s http://localhost:8085/test5.txt
```

