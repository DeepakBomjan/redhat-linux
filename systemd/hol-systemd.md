## Creating a second instance of the sshd service
1. Create a copy of the `sshd_config` file that will be used by the second daemon:

```bash
cp /etc/ssh/sshd{,-second}_config
```
2. Edit the `sshd-second_config` file created in the previous step to assign a different port number and PID file to the second daemon:
```bash
Port 22220
PidFile /var/run/sshd-second.pid
```
3. Create a copy of the systemd unit file for the `sshd` service:
```bash
cp /usr/lib/systemd/system/sshd.service /etc/systemd/system/sshd-second.service
```
4. Alter the `sshd-second.service` created in the previous step as follows:
    * Modify the Description option:
    ```bash
    Description=OpenSSH server second instance daemon
    ```
    * Add sshd.service to services specified in the After option, so that the second instance starts only after the first one has already started:
    ```bash
    After=syslog.target network.target auditd.service sshd.service
    ```
    * The first instance of sshd includes key generation, therefore remove the _ExecStartPre=/usr/sbin/sshd-keygen_ line.
    * Add the `-f /etc/ssh/sshd-second_config` parameter to the `sshd` command, so that the alternative configuration file is used:
    ```bash
    ExecStart=/usr/sbin/sshd -D -f /etc/ssh/sshd-second_config $OPTIONS
    ```
    * After the above modifications, the sshd-second.service should look as follows:
    ```bash
    [Unit]
    Description=OpenSSH server second instance daemon
    After=syslog.target network.target auditd.service sshd.service

    [Service]
    EnvironmentFile=/etc/sysconfig/sshd
    ExecStart=/usr/sbin/sshd -D -f /etc/ssh/sshd-second_config $OPTIONS
    ExecReload=/bin/kill -HUP $MAINPID
    KillMode=process
    Restart=on-failure
    RestartSec=42s

    [Install]
    WantedBy=multi-user.target
    ```
5. Enable sshd-second.service, so that it starts automatically upon boot
    ```bash
    systemctl enable sshd-second.service
    ```
    Verify if the sshd-second.service is running by using the `systemctl status` command. Also, verify if the port is enabled correctly by connecting to the service:
    ```bash
    ssh -p 22220 user@server
    ```


