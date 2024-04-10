**logrotate** is a log managing command-line tool in Linux. 

### Installation
```bash
sudo yum update
sudo yum install -y logrotate
```
### Directives
The directives are a basic building block of logrotate configuration, and they define different functions. 
### Configuration File
```bash
<global directive 1>
<global directive 2>

<file path matchers 1> {
    <directive 1>
    <directive 2>
    ...
    <directive n>
}

<file path matchers 2a> <file path matchers 2b> {
    <directive 1>
    <directive 2>
    ...
    <directive n>
}
```

Example configuration file

```bash
compress

/var/log/nginx/* {
    rotate 3
    daily
}

/var/log/nginx/error.log {
    rotate 3
    size 1M
    lastaction
        /usr/bin/killall -HUP nginx
    endscript
    nocompress
}
```
In this example config ....

- **global compress** directive at the top
- 2 patterns defined: `/var/log/nginx/*` and `/var/log/nginx/error.log`.

### Default Configuration
When we install logrotate, it creates a default configuration at `/etc/logrotate.conf`. 

### Applying Configuration Files
```bash
logrotate log-rotation.conf
```
If we want logrotate to evaluate the condition immediately, we can pass the -f option to force run it:
```bash
logrotate -f log-rotation.conf
```

### Rotating Condition

1. Rotating Log Files Based on Duration
```bash
/var/log/nginx/access.log {
    daily
}
```
```bash
/var/log/nginx/access.log {
    weekly
}
```
2. Rotating Log Files Based on Size
```bash
/var/log/nginx/access.log {
    size 1M
}
```
### Handling Rotated Files
1. Keeping Only a Few Rotated Log Files
```bash
/var/log/nginx/access.log {
    size 1M
    rotate 3
}
```
2. Removing Rotated Files by Age  
For instance, we can discard rotated logs that are already in the system for more than 5 days:

```bash
/var/log/nginx/access.log {
    size 1M
    maxage 5
}
```
3. Compressing the Rotated Files
```bash
/var/log/nginx/access.log {
    size 1M
    compress
}
```

### Handling Active Log File
1. Creating a New Log File
In the default behavior, the rotation process beings by logrotate renaming the active log file into a different name. Then, it creates a new log file with the same name.

Let’s configure the create directive for the /tmp/logs/error.log:

```bash
/tmp/logs/error.log {
    size 100k
    rotate 2
    create
}
```

Then, we enter 200 kilobytes worth of data into the error.log file and note down its inode value:
```bash
ls -hil /tmp/logs
total 200K
402882 -rw-r--r-- 1 user user 200K Sep  5 12:45 error.log
```
Next, we run the logrotate command to trigger the rotation:
```bash
logrotate logrotate.conf
ls -hil /tmp/logs
total 200K
402878 -rw-r--r-- 1 user user    0 Sep  5 13:00 error.log
402882 -rw-r--r-- 1 user user 200K Sep  5 12:59 error.log.1
```
2. Making a Copy of the Active Log File
```bash
/tmp/logs/error.log {
    size 100k
    rotate 2
    copytruncate
}
```

### Running Scripts During Rotation
In addition to the predefined directives, logrotate offers the possibility to run custom scripts at different hook points during the rotation. Concretely, we can run attach scripts on the 4 different hook points during rotation:

* Before any rotation
* Before each rotation
* After each rotation
* After all rotation

1. Before or After All Rotation

```bash
/tmp/logs/*.log {
    size 100k
    firstaction
        echo "start rotation $(date)" >> /tmp/rotation.log
    endscript
    lastaction
        echo "complete rotation $(date)" >> /tmp/rotation.log
    endscript
}
```
2. Before or After Each Rotation

```bash
/tmp/logs/*.log {
    size 100k
    prerotate
        echo "start rotation for $1 $(date)" >> /tmp/rotation.log
    endscript
    postrotate
        echo "complete rotation for $1 $(date)" >> /tmp/rotation.log
    endscript
}
```
3. Differences Between firstaction/lastaction and prerotate/postrotate

Example:

```bash
cat logrotate.conf
/tmp/logs/*.log {
  size 100k
  firstaction
    echo "on first action. first argument: $1" >> /tmp/event-hooks.log
  endscript
  lastaction
    echo "on last action. first argument: $1" >> /tmp/event-hooks.log
  endscript
  prerotate
    echo "on prerotate. first argument: $1" >> /tmp/event-hooks.log
  endscript
  postrotate
    echo "on postrotate. first argument: $1" >> /tmp/event-hooks.log
  endscript
}
```

```bash
logrotate logrotate.conf
```
