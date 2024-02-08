# Systemd
![image](../images/systemd_startup.webp)
## Managing Services with systemd
1. Provides a number of features
    * parallel startup of system services at boot time
    * on-demand activation of daemons
    * dependency-based service control logic


Systemd introduces the concept of systemd units

## To get available systemd Unit Types

## Systemd Unit Files Locations
1. `/etc/systemd/system/` This directory takes precedence over the directory with runtime unit files
2. `/run/systemd/system/` 
3. `/usr/lib/systemd/system/`

## Managing System Services
1. Start a service
    ```bash
    systemctl start name.service
     ```
2. Stops a service.
    ```bash
    systemctl stop name.service
    ```
3. Restarts a service.
    ```bash
    systemctl restart name.service
    ```
4. Reloads configuration.
    ```bash
    systemctl reload name.service
    ```
5. Checks if a service is running.
    ```bash
    systemctl status name.service
    systemctl is-active name.service
    ```
6. Displays the status of all services.
    ```bash
    systemctl list-units --type service --all
    ```
7. Enables a service.
    ```bash
    systemctl enable name.service
    ```
8. Disables a service.
    ```bash
    systemctl disable name.service
    ```
9. systemctl status name.service
    ```bash
    systemctl is-enabled name.service
    ```
10. Lists services that are ordered to start before the specified unit.
    ```bash
    systemctl list-dependencies --after
    ```
11. Lists services that are ordered to start after the specified unit.
    ```bash
    systemctl list-dependencies --before
    ```
12. To list all installed service unit files to determine if they are enabled
    ```bash
    systemctl list-unit-files --type service
    ```

13. Viewing the Default Target
    ```bash
    systemctl get-default
    ```
14. To list all currently loaded target units
    ```bash
    systemctl list-units --type target
    ```
15. Changing the Default Target
    ```bash
    systemctl set-default multi-user.target
    ```
16. Changing to Rescue Mode
    ```bash
    systemctl rescue
    ```
17. Changing to Emergency Mode
    ```bash
    systemctl emergency
    ```
### Shutting Down, Suspending, and Hibernating the System
Halt
```bash
systemctl halt
```
Poweroff
```bash
systemctl poweroff
```
Reboot
```bash
systemctl reboot
```

## Creating and Modifying systemd Unit Files

Unit file names take the following form:
`unit_name.type_extension`

### Understanding the Unit File Structure
Unit files typically consist of three sections:

* [Unit] — contains generic options that are not dependent on the type of the unit. These options provide unit description, specify the unit’s behavior, and set dependencies to other units. For a list of most frequently used [Unit] options.
* [unit type] — if a unit has type-specific directives, these are grouped under a section named after the unit type. For example, service unit files contain the [Service] section, 

* [Install] — contains information about unit installation used by systemctl enable and disable commands,

### Creating Custom Unit Files

The **Type= directive** can be one of the following:

* **simple**: The main process of the service is specified in the start line. This is the default if the Type= and Busname= directives are not set, but the ExecStart= is set. Any communication should be handled outside of the unit through a second unit of the appropriate type (like through a .socket unit if this unit must communicate using sockets).
2. **forking**: This service type is used when the service forks a child process, exiting the parent process almost immediately. This tells systemd that the process is still running even though the parent exited.
3. **oneshot**: This type indicates that the process will be short-lived and that systemd should wait for the process to exit before continuing on with other units. This is the default Type= and ExecStart= are not set. It is used for one-off tasks.



1. Create a unit file 
```bash
touch /etc/systemd/system/name.service
chmod 664 /etc/systemd/system/name.service
```
Replace name with a name of the service to be created

2. Unit file content
```bash
[Unit]
Description=service_description
After=network.target

[Service]
ExecStart=path_to_executable
Type=forking
PIDFile=path_to_pidfile

[Install]
WantedBy=default.target
```
3. Start the service
```bash
systemctl daemon-reload
systemctl start name.service
```

## Displaying the Execution Tree of systemd
1. Check startup time
```bash
systemd-analyze
```
2. retrieve a tree of the critical-chain of units:
```bash
systemd-analyze critical-chain
```
```bash
sudo systemctl status
```

## Listing the Dependencies
```bash
sudo systemctl list-dependencies
```
```bash
sudo systemctl list-dependencies default.target
```
## Sample unitfile with different log files
```bash
[Unit]
Description=Bird watching service

[Service]
Type=oneshot
ExecStart=/etc/systemd/system/hello.sh

StandardOutput=append:/var/log/hello.log
StandardError=append:/var/log/hello.log

[Install]
WantedBy=multi-user.target
```

## journalctl
```bash
journalctl -u unit_name -f
```
```bash
journalctl -b -t systemd
journalctl -b -t systemd -g "hello"

```
### To get all the logs for the current boot
```bash
journalctl -b
```
### Boots
```bash
journalctl --list­-boots
```
### To get all the log entries from the previous boot
```bash
journalctl -b -1
```
### Filtering by Date or Time
```bash
journalctl --since="2024-02-7 10:54:00"
journalctl --since="2024-02-7 10:54:35" --until="2024-02-7 10:55:00"
journalctl --since "20 min ago"

```
### Units
```bash
journalctl -u netcfg
```
### Tailing and Following Logs
```bash
journalctl -f
journalctl -f -u apache
```
### By Process, User, or Group ID
```bash
journalctl _PID=8088
journalctl _UID=33 --since today
```
### By Priority
```bash
journalctl -p err -b
```
In order of highest to lowest priority, these are:

* **0**: emerg
* **1**: alert
* **2**: crit
* **3**: err
* **4**: warning
* **5**: notice
* **6**: info
* **7**: debug

## References

1. [Managing Services with systemd](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/system_administrators_guide/chap-managing_services_with_systemd)

2. [How To Use Journalctl to View and Manipulate Systemd Logs](https://www.digitalocean.com/community/tutorials/how-to-use-journalctl-to-view-and-manipulate-systemd-logs)