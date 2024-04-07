## Installing and Configuring Podman on RHEL
1. Installing Podman Using yum
```bash
sudo yum -y install podman
```
2. Installing Podman UsingApplication Streams
```bash
sudo yum module list container-tools
```
Let's say that we want to try a different stream, say 2.0. We would enable that stream with:
```bash
sudo yum module enable container-tools:2.0
```
Checking our configured stream:
```bash
sudo yum module list container-tools
```
```bash
podman --version
```
## Configuring Podman

The configuration files forthe Podman environment are located in `/etc/containers`.
Important files include:
* `/etc/containers/registries.conf`
    * This file contains configuration information for containerregistries and registry mirrors.
* `/etc/containers/storage.conf`
    * This file contains configuration information for all tools that use the `containers/storage`
library. You can specify storage locations, UID/GID mappings, thinpool storage options, and more.

