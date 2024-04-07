## Working with Container Images Using Podman and Skopeo
1. Let's grab an image to work with. We'll search for the latest Red Hat ubi image:
```bash
podman search ubi:latest | more
```
2. This will search the configured registries for the ubi:latest image.
podman pull registry.access.redhat.com/ubi8/ubi:latest

3. Sometimes podman will have commands that do the same thing as another command, such as listing container images:
```bash
podman images
podman image list
```
4. Or, drilling down into a container image's metadata:
```bash
podman inspect ubi | more
podman image inspect ubi | more
```


5. Change tag:
```bash
podman tag ubi:latest ubi8
```
6. List images:
```bash
podman images
```
7. We can see the container image registry that's running on the server using podman ps:
```bash
sudo podman ps -a
```
The registry itself is a Podman container, running on the lab server!

8. Log in to the local registry
```bash
curl -u registryuser:registryuserpassword
podman login localhost:5000
```
9. We're going to push the ubi:latest image in our local container image storage to the registry running on our lab server. First, we need to tag the image:
```bash
podman tag registry.access.redhat.com/ubi8/ubi:latest localhost:5000/ubi8/ubi
```
10. Next, we'll push the image to our local registry:
```bash
podman push localhost:5000/ubi8/ubi:latest
```
11. Checking the contents of the local container registry, using curl:
```bash
curl -u registryuser:registryuserpassword https://localhost:5000/v2/_catalog
```

We can see the repository for ubi8/ubi.

12. Let's remove the ubi8 tag we assigned earlier:
```bash
podman untag ubi8
```
13. Checking our local container images:
```bash
podman image list
```
14. Notice that we now have an untagged image. Let's remove it by using the imageID:
```bash
podman rmi <imageID>
```
15. Checking our local container images:
```bash
podman image list
```
16. We're all cleaned up now! Let's log out of our local container image repository:
```bash
podman logout localhost:5000
```
## Using skopeo
```bash
skopeo --version
```
1. Grab the latest ubi7 image from the registry.access.redhat.com registry:
```bash
podman pull registry.access.redhat.com/ubi7/ubi:latest
```
2. Checking our local container images:
```bash
podman image list
```
We now have a local image to work with.

3. Let's log in to our local registry, using registryuser and registryuserpassword:
```bash
skopeo login localhost:5000
```
4. We can use skopeo to copy a container image directly from one registry to another:
```bash
skopeo copy docker://registry.access.redhat.com/ubi7/ubi:latest docker://localhost:5000/ubi7/ubi
```
In this case, we are copying the ubi7/ubi:latest image from the Red Hat registry to our local registry, using the Docker transport.

5. We can use skopeo sync to copy images from one location to another:
```bash
skopeo sync --src docker --dest docker --scoped registry.access.redhat.com/ubi7/ubi:latest localhost:5000/ubi7/ubi
```
6. We can use skopeo inspect to get more information on a container image:
```bash
skopeo inspect docker://localhost:5000/ubi7/ubi:latest | more
```
7. We can also use skopeo to list the tags on an image:
```bash
skopeo list-tags docker://localhost:5000/ubi8/ubi
```
8. So, using podman to search our local registry:
```bash
podman search localhost:5000/ubi
```
We can see our ubi images.

9. Let's wrap it up and log out:
```bash
skopeo logout localhost:5000
```



## References
[How to implement a simple personal/private Linux container image registry for internal use](https://www.redhat.com/sysadmin/simple-container-registry)

