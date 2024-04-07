## Creating Your First Podman Pod
### Commands Covered
* `podman pod`: manages Podman pods
* `podman run`:runs a command in a new containerfrom the given image
* `podman ps`: displays information about containers
### Creating Our First Podman Pod!
Create WordPress instance in a pod.
1. Check for exising containers and pods:
```bash
podman ps -a --pod
```
We can use the --pod option to show the ID and name of the pod the containers belong to.
We can display pods using:
```bash
podman pod ls
```
2. Publish port `80` in the pod to `8080` on the host. Name the pod `wp-pod`.
```bash
podman pod create --name wp-pod -p 8080:80
```
Checking for pods now:
```bash
podman pod ls
```
Checking for containers:
```bash
podman ps -a --pod
```
We now see our Infra container! You can see that the pod's published ports are listed along with the container.
2. First, let's start the mariadb container:
```bash
podman run -d --restart=always --pod=wp-pod -e
MYSQL_ROOT_PASSWORD="dbpass" -e MYSQL_DATABASE="wp" -e
MYSQL_USER="wordpress" -e MYSQL_PASSWORD="wppass" --name=wp-db mariadb
```
Checking for containers again:
```bash
podman ps -a --pod
```
3. Start the WordPress container:
```bash
podman run -d --restart=always --pod=wp-pod -e WORDPRESS_DB_NAME="wp" -e
WORDPRESS_DB_USER="wordpress" -e WORDPRESS_DB_PASSWORD="wppass" -e
WORDPRESS_DB_HOST="127.0.0.1" --name wp-web wordpress
```
Checking for containers again:
```bash
podman ps -a --pod
```

Checking with a curl command:
```bash
curl -s http://localhost:8080
echo $?
```
We can see that the WordPress login page is working! We can now log in with our web browser, using port `8080`.

## Managing Pods Using Podman

### Commands Covered
* `podman pod`: manages Podman pods
* `podman ps`: displays information about containers and pods
### WorkingWith Rootless Pods
**Commands Used**: start/stop/restart/kill/inspect/ps/top
.
1. Check running pods and containers:
```bash
podman pod ps
podman ps -a --pod
```
We see our `wp-pod` pod, with the `wp-web` and `wp-db` containers, as well as our Infra container. Everything is up and running.
We can stop the pod, along with all its containers, using the podman pod stop command:
```bash
podman pod stop wp-pod
```
Checking the status of our pod and its containers:
```bash
podman ps -a --pod
```
We can see our `wp-pod` pod, and its containers, stopped.
We can start our pod using podman pod start:
```bash
podman pod start wp-pod
```
Checking the status of our pod and its containers:
```bash
podman ps -a --pod
```
We see that our `wp-pod` and its containers are back up!
Similarly, we can restart our pod using podman pod restart:
```bash
podman pod restart wp-pod
```
Checking the status of our pod and its containers:
```bash
podman ps -a --pod
```
We see that our wp-pod and its containers are back up!
We can get information about our pod using `podman pod inspect`:
```bash
podman pod inspect wp-pod
```
This provides detailed information on our `wp-pod` pod.
For a listing of the `wp-pod` pod's processes, use:
```bash
podman pod top wp-pod
```
Now that we've covered the `podman pod` commands that work with both rootless and rootfull pods, let's take
a look at some operations forrootfull pods.
### WorkingWith RootfulPods
**Commands Used**: create/prune/pause/unpause/stats
There are a number of additional commands we can use with rootfull pods. Before we can explore these, we
need to deploy a rootful pod.
**Deploy a RootfulPod**:
Become root:
```bash
sudo -i
```
We're going to create our rootfull pod, then add one `nginx` container and one `mariadb` container. We want to publish port `80` in the pod to `8081` on the host. We want to name the pod `root-pod`.
To do this, we run:
```bash
podman pod create --name root-pod -p 8081:80
```
Again, we can use the `podman pod create` command with rootless containers as well.
Next, let's start a `mariadb` container:
```bash
podman run -d --restart=always --pod=root-pod -e
MYSQL_ROOT_PASSWORD="dbpass" -e MYSQL_DATABASE="rootdb" -e
MYSQL_USER="dba" -e MYSQL_PASSWORD="dbapass" --name=root-db mariadb
```
Finally, we'll start the `nginx` container:
```bash
podman run -d --restart=always --pod=root-pod --name root-web nginx
```
Checking our pods and containers:
```bash
podman ps -a --pod
```
Our rootfull pod is fully running!
Checking with a curl command:
```bash
curl -s http://localhost:8081
```
We see the default nginx index page!
**Manage a rootfull pod:**
We can pause rootfull pods:
```bash
podman pod pause root-pod
```
Checking our pods and containers:
```bash
podman ps -a --pod
podman pod ps
```
We see that both our pod and its containers are in the `paused` status.
We can resume our pod and its containers with the `podman pod unpause` command:
```bash
podman pod unpause root-pod
```
Checking our pods and containers:
```bash
podman ps -a --pod
podman pod ps
```
We see that our root-pod pod and its containers are running again!
We can get performance statistics for rootful pods and its containers using:
```bash
podman pod stats root-pod
```
We can see the statistics for our `root-pod` pod and its containers. We can use `CTRL-C` to break out of the
statistics display.
Let's stop our `root-pod` pod:
```bash
podman pod stop root-pod
```
Checking forreclaimable space:
```bash
podman system df
```
We see we have some reclaimable space.
Let's try the `podman pod prune` command to reclaim that space:
```bash
podman pod prune
```
We can see we freed up some space.
Checking our pods and containers:
```bash
podman ps -a --pod
podman pod ps
```
There are no more root full containers or pods!
Let's exit root:
```bash
exit
```
#### Cleaning Up Our RootlessPods and Containers

Let's clean upour rootless podandits containers:
Checking our pods and containers:
```bash
podman ps -a --pod
podman pod ps
```
We see our `wp-pod` pod and its containers.
Let's stop and remove the wp-pod pod and its containers:
```bash
podman pod stop wp-pod
podman pod rm wp-pod
```
Checking our pods and containers one more time:
```bash
podman ps -a --pod
podman pod ps
```
The `wp-pod` pod and its containers have been removed.
Let's clean up the rest of the mess:
```bash
podman system prune -a
```
Checking our work:
```bash
podman system df
```