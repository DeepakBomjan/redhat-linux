## Using Buildah to Manage Container Images

### Content Management Using Buildah
These commands are used to add content (file/URL/directory) to a container.
**Commands**: add/copy
1. Add some more content to our my-fedora-httpd containerimage.

```bash
mkdir ~/testfiles
for i in `seq 1 5` ; do echo "Add Test File "$i > ~/testfiles/add$i.txt ;
echo "Copy Test File "$i > ~/testfiles/copy$i.txt ; done
cat ~/testfiles/*
```
Two commands:
```bash
buildah add --help | more
buildah copy --help | more
```
2. Copy the files using buildah add. We'll need to create a container first:
```bash
container=$(buildah from fedora:latest)
echo $container
```
```bash
buildah containers
```
3. Adding the files:
```bash
buildah add fedora-working-container 'testfiles/add*.txt' '/var/www/html/'
```
4. Try the same using buildah copy:
```bash
buildah copy fedora-working-container 'testfiles/copy*.txt'
'/var/www/html/'
```
They appear to work the same. Remember, your source can be a file, directory, or URL. We'll view the results in
a second.

#### Filesystem Management Using Buildah
Sometimes we want to interact directly with a container's filesystem when creating or modifying container
images. The following commands allow you to do this.
**Commands**: mount/umount
1. Mount our container filesystem to confirm that we were able to add/copy those files:
```bash
buildah unshare
```
```bash
buildah mount fedora-working-container
```
We see our mount point.
Let's check for those files:
```bash
ls -la <mountpoint>/var/www/html
cat <mountpoint>/var/www/html *.txt
```
We see ourfiles!
Let's unmount our containerfilesystem and exit from our buildah unshare session:
```bash
buildah umount fedora-working-container
```
```bash
exit
```


**Dockerfile**:
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

## Using Buildah to Manage Container Images

### Image Management Using Buildah
The following buildah commands are used to manage images.
**Commands**: images/login/logout/pull/push/rmi/tag
```bash
buildah images
```

