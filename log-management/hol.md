1. Create logrotate configuration
```bash
cat << EOF | sudo tee -a /etc/logrotate.d/myapp
# Rotate myapp logs when they reach 1 KB
/var/log/myapp/*.log {
    size 1k
    rotate 5
    compress
    delaycompress
    missingok
    notifempty
    create 0644 root root
}
EOF
```
```bash
sudo mkdir /var/log/myapp
sudo chmod 777 /var/log/myapp
```
2. Script to generate logfile
```bash
while true; do
    echo "$(date +"%Y-%m-%d %H:%M:%S") - Writing 1 KB of random data to the log file"
    dd if=/dev/urandom bs=1024 count=1 >> /var/log/myapp/random.log
    sleep 5
done
```

3. Run
```bash
logrotate /etc/logrotate.d/myapp
```

To make log rotation automatic, you can set up a cron job or a systemd timer depending on your system's configuration. Here are steps for both methods:
### Using Cron Job (for systems with cron)
1. Open the crontab file for editing:
```bash
crontab -e
```
2. Add a cron job entry to run logrotate daily:
```bash
@daily /usr/sbin/logrotate /etc/logrotate.d/myapp --verbose
```
3. Save and exit the crontab editor. The cron job will now run logrotate daily at midnight by default.
### Using Systemd Timer (for systems using systemd)
1. Create a systemd timer unit file:
```bash
sudo nano /etc/systemd/system/myapp-logrotate.timer
```
2. Add the following content to the file (`myapp-logrotate.timer`):
```bash
[Unit]
Description=Daily log rotation for myapp

[Timer]
OnCalendar=daily
Persistent=true

[Install]
WantedBy=timers.target

```
3. Create a corresponding systemd service unit file:
```bash
sudo nano /etc/systemd/system/myapp-logrotate.service

```
4. Add the following content to the file (`myapp-logrotate.service`):
```bash
[Unit]
Description=Log rotation for myapp

[Service]
Type=oneshot
ExecStart=/usr/sbin/logrotate /etc/logrotate.d/myapp --verbose
```
5. Reload systemd to detect the new timer and service files:
```bash
sudo systemctl daemon-reload

```
6. Enable and start the timer:
```bash
sudo systemctl enable --now myapp-logrotate.timer

```


In systemd, a timer unit (**.timer** file) is associated with a service unit (**.service** file) using a naming convention. When you create a timer unit with a specific name like **myapp-logrotate.timer**, systemd expects that there is a corresponding service unit named **myapp-logrotate.service**. This linkage is established implicitly based on the naming scheme.


To run every minute
```bash
[Unit]
Description=Run myapp-logrotate.service every minute

[Timer]
OnCalendar=*:0/1
Persistent=true

[Install]
WantedBy=timers.target

```

## rsyslog configuration
### Server-side Configuration (rsyslog server)
1. Edit rsyslog configuration file:

Open the rsyslog configuration file (`/etc/rsyslog.conf` or `/etc/rsyslog.d/*.conf`) on your rsyslog server.
2. Enable UDP or TCP listener:
Uncomment or add lines to enable receiving logs over UDP or TCP. For example:
```bash
# Enable UDP listener (port 514)
module(load="imudp")
input(type="imudp" port="514")

# Enable TCP listener (port 514)
module(load="imtcp")
input(type="imtcp" port="514")

```
3. Configure rules to store incoming logs:
Add rules to store incoming logs into specific log files or directories. For example:
```bash
# Store logs from remote systems in a separate file
if $fromhost-ip != "127.0.0.1" then /var/log/remote.log
& ~

```
This rule stores logs from remote systems (excluding localhost) in /var/log/remote.log. Adjust the path and rules according to your needs.
4. Restart rsyslog service:
```bash
sudo systemctl restart rsyslog

```
### Client-side Configuration (system sending logs)
1. Edit rsyslog configuration file:
Open the rsyslog configuration file (`/etc/rsyslog.conf` or `/etc/rsyslog.d/*.conf`) on the system that will send logs to the rsyslog server.
2. Configure remote logging:
Add a directive to send logs to the remote rsyslog server. For example:
```bash
*.* @rsyslog-server-ip:514

```
3. Restart rsyslog service:
```bash
sudo systemctl restart rsyslog

```

### Testing
To send a log message  over UDP using `nc`
```bash
echo "This is a sample log message" | nc -u <rsyslog-server-ip> 514

```

Send multiline messages
```bash
nc -u <rsyslog-server-ip> 514 <<<"First line of log
Second line of log
Third line of log"

```

To send a log message over TCP using `nc`
```bash
echo "This is a sample log message" | nc <rsyslog-server-ip> 514

```
```bash
nc <rsyslog-server-ip> 514 <<<"First line of log
Second line of log
Third line of log"

```

### Custom log format
1. Define a custom log format:
Add a new template definition at the top or bottom of your rsyslog configuration file. This template will specify the format for your log messages, including the sending hostname and IP address.
```bash
$template CustomFormat,"%fromhost% %fromhost-ip% %syslogtag%%msg%\n"

```
In this template:

- `%fromhost%`: Represents the hostname of the system sending the log message.
- `%fromhost-ip%`: Represents the IP address of the system sending the log message.
- `%syslogtag%`: Represents the syslog tag (program name or identifier) of the message.
- `%msg%`: Represents the actual log message.

2. Configure a rule to use the custom log format:
```bash
sudo nano /etc/rsyslog.d/99-custom-logs.conf

```
3. Define a Custom Log Format Template

```bash
if $fromhost-ip != "127.0.0.1" then {
    action(type="omfile" file="/var/log/remote.log" template="CustomFormat")
}

```
3. Configure Log Routing:
```bash
# Route logs from remote systems to a custom log file
if $fromhost-ip != "127.0.0.1" then {
    action(type="omfile" file="/var/log/remote-custom.log" template="CustomFormat")
}

```

4. Check Syntax
```bash
sudo rsyslogd -N1

```

5. Restart Service
```bash
sudo systemctl restart rsyslog
```

## Forward only `/var/log/messages` to remote syslog
1. Create a new rsyslog configuration file
```bash
sudo nano /etc/rsyslog.d/50-messages-forward.conf

```
2. Configure rsyslog to forward /var/log/messages
```bash
# Forward /var/log/messages to remote syslog server
if $programname == 'messages' then {
    action(type="omfwd" target="your-remote-syslog-server" port="514" protocol="udp")
}

```
3. Restart rsyslog service
```bash
sudo systemctl restart rsyslog
```

### Log rotation with rsyslog
Log rotation based on a fixed log size
```bash
# start log rotation via outchannel
# outchannel definition
$outchannel log_rotation,/var/log/log_rotation.log, 52428800,/home/me/./log_rotation_script
#  activate the channel and log everything to it
*.* :omfile:$log_rotation
# end log rotation via outchannel
```
```bash
mv -f /var/log/log_rotation.log /var/log/log_rotation.log.1
```

### Troubleshooting
1. Test logging manually
```bash
logger -p local6.info "Test log message"
```

```bash
logger -n 172.31.88.239 -p user.info "Test message"
```

### How to configure logging in application
```python
import logging
from logging.handlers import SysLogHandler
from flask import Flask

app = Flask(__name__)

# Configure logging to send logs to remote syslog server
syslog_handler = SysLogHandler(address=('your-rsyslog-server-ip', 514))  # Adjust IP and port
syslog_handler.setFormatter(logging.Formatter('%(asctime)s %(levelname)s: %(message)s'))
app.logger.addHandler(syslog_handler)

@app.route('/')
def hello_world():
    app.logger.info('Accessed / endpoint')  # Example log message
    return 'Hello, World!'

if __name__ == '__main__':
    app.run(debug=True)

```


### References
[Configuring a remote logging solution](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/9/html/security_hardening/assembly_configuring-a-remote-logging-solution_security-hardening#the-rsyslog-logging-service_assembly_configuring-a-remote-logging-solution)

[Rsyslog Configuration](https://www.rsyslog.com/doc/configuration/index.html#)
