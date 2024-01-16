[Linux permissions: SUID, SGID, and sticky bit](https://www.redhat.com/sysadmin/suid-sgid-sticky-bit)

## Linux Sudoers Setting
1. Allow member of group sudo to run below command
```bash
%sudo   ALL=(ALL:ALL) /path/to/allowed/command1,/path/to/allowed/command2
```
2.  If you want to allow the user to run the allowed commands without entering a password, you can append NOPASSWD: before the command path
```bash
%sudo  ALL=(ALL)  NOPASSWD: /path/to/allowed/command
```
3. disallow all commands, then allow only poweroff without asking password
```bash
# Allow guestx user to remote poweroff
guestx ALL=(ALL) !ALL
guestx ALL=NOPASSWD: /sbin/poweroff
```
