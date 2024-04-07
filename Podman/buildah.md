## Creating a Container Image Using Buildah Native Commands
**Commands** 
* `buildah images`: lists locally stored images
* `buildah containers`: lists containers which appearto be Buildah working containers
* `buildah from`: creates a new working container, either from scratch or using a specified image as a starting point
* `buildah config`: modifies the configuration values which will be saved to the image
* `buildah run`:runs a specified command using the container's root filesystem as a root filesystem, using configuration settings inherited from the container's image or as specified using previous calls to the config command
* `buildah commit`: writes a new image using the container's * read-write layer and, if it is based on an image, the layers of that image
* `buildah rmi`:removes one or more locally stored images


We're going to use the following criteria tobuilda custom container image:
* Based on the `fedora:latest` containerimage
* Maintainer = “buildah@podman.rulez”
* Install httpd in the container
    * Clean up afterinstall
* Create five test text files in `/var/www/html`
    * Contents should be `"Test File <1-5>"`
    * Filenames should be `"test<1-5>.txt"`
* Expose port 80
* Run our httpd service using `"/usr/sbin/httpd -D FOREGROUND"`
* Name ourimage `my-fedora-httpd:latest`

Build Our Custom my-fedora-httpd Container Image
1. Create base container:
```bash
container=$(buildah from fedora:latest)
```
Checking our new working container:
```bash
buildah containers
```
Checking the value for $container:
```bash
echo $container
```
2. Add our maintainer information:
```bash
buildah config --label maintainer=“buildah@podman.rulez” $container```

3. Install httpd in our containerimage:
```bash
buildah run $container dnf install -y httpd
```

4. Clean up dnf cache:
```bash
buildah run $container dnf clean all
```
This gives us a smaller containerimage.

5. Create ourtest text files:
```bash
buildah run $container bash -c "echo \"Test File 1\" >
/var/www/html/test1.txt"
buildah run $container bash -c "echo \"Test File 2\" >
/var/www/html/test2.txt"
buildah run $container bash -c "echo \"Test File 3\" >
/var/www/html/test3.txt"
buildah run $container bash -c "echo \"Test File 4\" >
/var/www/html/test4.txt"
buildah run $container bash -c "echo \"Test File 5\" >
/var/www/html/test5.txt"
```

6. Expose port 80 for our web server, set the start command for our httpd service and commit  container image to my-fedora-httpd:latest:
```bash
buildah config --port 80 $container
```
```bash
buildah config --cmd "/usr/sbin/httpd -D FOREGROUND" $container
```
Before we commit, let's check our containers using buildah:
```bash
buildah containers
```
7. Commit our new image:
```bash
buildah commit --format docker $container my-fedora-httpd:latest
```
8. Check buildah images and containers:
```bash
buildah images
buildah containers
```

9. Run my-fedora-httpd Containers
```bash
podman run -d --name my-fedora-httpd-1 -p 8081:80 localhost/my-fedorahttpd
podman run -d --name my-fedora-httpd-2 -p 8082:80 localhost/my-fedorahttpd
podman run -d --name my-fedora-httpd-3 -p 8083:80 localhost/my-fedorahttpd
podman run -d --name my-fedora-httpd-4 -p 8084:80 localhost/my-fedorahttpd
podman run -d --name my-fedora-httpd-5 -p 8085:80 localhost/my-fedorahttpd
```
Checking our work:
```bash
podman ps -a
```
10. Testing Our my-fedora-httpd Containers
```bash
curl -s http://localhost:8081/test1.txt
curl -s http://localhost:8082/test2.txt
curl -s http://localhost:8083/test3.txt
curl -s http://localhost:8084/test4.txt
curl -s http://localhost:8085/test5.txt
```
