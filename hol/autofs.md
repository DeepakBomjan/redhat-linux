## Mount NFS filesystems with autofs    
### Autofs defined
- Use the kernel-based `automount` utility
Automounting NFS shares conserves bandwidth and offers better performance compared to static mounts controlled by `/etc/fstab`.

### How does it work?
Daemon: `autofs` 
Map file: `/etc/auto.master`

1. Mount point
2. Location of map file
3. Optional field (allows for the inclusion of options)

### Example
1. Add the following to the `auto.master` file:
```bash
/test                 /etc/auto.misc      --timeout 30
```
2. Once that is completed, add the following to our map file `/etc/auto.misc`:
```bash
autofstest   -rw,soft,intr,rsize=8192,wsize=8192 client.example.com:/afstest
```

```bash
payroll -fstype=nfs personnel:/exports/payroll
sales -fstype=ext3 :/dev/hda4
```

The automounter will create the directories if they do not exist.

```bash
service autofs start
```
