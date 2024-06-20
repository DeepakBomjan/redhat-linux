## Use Case Description:
**Shared Directories**:

`/share`: Available to both sales and marketing groups.
`/share/secret`: Restricted to managers only (ram and hari).
**Users and Groups**:

**Users**: ram, shyam, hari, sita
**Groups**: sales, marketing
### Samba Configuration Steps:
Create Samba Groups:

Create the following groups:
```bash

sudo groupadd sales
sudo groupadd marketing
```
Add users to their respective groups:

```bash
sudo usermod -aG sales ram
sudo usermod -aG sales shyam
sudo usermod -aG marketing hari
sudo usermod -aG marketing sita
```
Set Directory Permissions:

Set permissions on the shared directories:
```bash
sudo chown -R :sales /path/to/share
sudo chown -R :marketing /path/to/share/secret
sudo chmod -R 0770 /path/to/share
sudo chmod -R 0770 /path/to/share/secret
```
Samba Configuration (smb.conf):

Edit the Samba configuration file (`smb.conf`):

```bash
sudo nano /etc/samba/smb.conf
```
Define the shares with appropriate permissions:
```bash
[share]
   path = /path/to/share
   valid users = @sales, @marketing
   read only = no

[secret]
   path = /path/to/share/secret
   valid users = ram, hari
   read only = no
```
Restart Samba:

Restart the Samba service for changes to take 
```bash
sudo systemctl restart smbd
```
**Explanation**:
This configuration ensures that the sales and marketing groups have access to /share.
Only ram and hari, who are managers in their respective groups, can access /share/secret.
Other users within the groups (shyam, sita) will not have access to /share/secret.
Adjust the paths, group memberships, and permissions as per your specific setup and requirements.

## Sample Configurations
```bash
[share]
   path = /share
   browsable = yes
   writable = yes
   valid users = @group1 user1 @group2
   create mask = 0664
   directory mask = 0775
   force directory mode = 0775

```

In this example:

* `path`: Specifies the shared directory path (/share in this case).  
* `browsable`: Allows the share to be browsed by users.  
* `writable`: Allows write access to the share.  
* `valid users`: Specifies the users and groups that have access to the share (@group1, user1, @group2).  
* `create mask, directory mask, force directory mode`: Define the default permissions for newly created files and directories within the share.