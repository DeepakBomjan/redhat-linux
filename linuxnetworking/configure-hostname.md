## Configure Hostname
### Configuring Host Names Using hostnamectl
1. To view all the current host names
    ```bash
    hostnamectl status
    ```
2. To set the hostname
    ```bash
    hostnamectl set-hostname name
    ```
### Configuring Host Names Using nmcli
1. To query the static host name
    ```bash
    nmcli general hostname
    ```
2. To set the static host name to my-server
    ```bash
    nmcli general hostname my-server
    ```
### Manually Editing `/etc/hostname` file