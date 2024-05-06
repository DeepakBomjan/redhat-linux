## Create filesystem
```yaml
---
- name: Storage Configuration Playbook
  hosts: your_target_hosts
  become: true  # Run tasks with sudo

  tasks:
    - name: Create partition using parted
      parted:
        device: /dev/sdb  # Specify the disk device to work with
        number: 1         # Partition number
        state: present    # Ensure the partition exists
        part_type: primary
        fs_type: ext4     # Filesystem type (can be changed based on your preference)
        label: "data"     # Label for the partition (optional)
        align: none       # Alignment setting (optional)

    - name: Format the partition with ext4 filesystem
      filesystem:
        fstype: ext4
        dev: /dev/sdb1   # The newly created partition
```

### volume group 
```yaml
---
- name: Create and Mount Logical Volume
  hosts: your_target_hosts
  become: true  # Run tasks with sudo

  tasks:
    - name: Create Physical Volumes
      lvg:
        vg: vg01
        pvs: /dev/sdb1  # Specify the physical volume(s) to use

    - name: Create Volume Group
      lvg:
        vg: vg01
        pesize: 4  # Specify the physical extent size (optional)
        state: present

    - name: Create Logical Volume
      lvol:
        vg: vg01
        lv: lv01
        size: 1G  # Specify the size of the logical volume
        state: present

    - name: Format Logical Volume
      filesystem:
        fstype: ext4
        dev: /dev/vg01/lv01  # The logical volume device

    - name: Mount Logical Volume
      mount:
        path: /mnt/data  # Mount point
        src: /dev/vg01/lv01  # Logical volume device
        fstype: ext4
        state: mounted

```

## Variable

```yaml
- hosts: sanog-1
  tasks:
    - shell: whoami
      register: whoami

    - debug: msg={{ whoami }}
```

## Role
```yaml
---

- hosts: sanog-1
  roles:
    - geerlingguy.java
  become: yes
  become_method: sudo
```

## Variables

1. Using Playbook Variables:
```yaml
---
- name: Example Playbook
  hosts: localhost
  vars:
    my_var: "Hello, Ansible!"

  tasks:
    - name: Print variable value
      debug:
        msg: "{{ my_var }}"

```
2. Accessing Facts:
```yaml
---
- name: Example Playbook
  hosts: localhost
  tasks:
    - name: Print hostname
      debug:
        msg: "Hostname is {{ ansible_hostname }}"
```
3. Accessing Inventory Variables:
```ini
[web_servers]
server1 ansible_host=192.168.1.100 my_var="Hello from inventory"

```
```yaml
---
- name: Example Playbook
  hosts: web_servers
  tasks:
    - name: Print variable from inventory
      debug:
        msg: "{{ my_var }}"

```

4. Accessing host var and gourp variables

```bash
ansible_project/
├── inventory/
│   ├── hosts
│   ├── host_vars/
│   │   ├── server1.yml
│   │   └── server2.yml
│   └── group_vars/
│       └── web_servers.yml
└── playbook.yml
```
-  Accessing Host Variables 
```bash
---
# host_vars/server1.yml
my_host_var: "Hello from host_vars"

```
```yaml
---
- name: Example Playbook
  hosts: server1
  tasks:
    - name: Print host variable
      debug:
        msg: "{{ my_host_var }}"
```
- Accessing Group Variables
```yaml
---
# group_vars/web_servers.yml
my_group_var: "Hello from group_vars"
```
```yaml
---
- name: Example Playbook
  hosts: web_servers
  tasks:
    - name: Print group variable
      debug:
        msg: "{{ my_group_var }}"

```

## Host Variables (host_vars/hostname.yml or host_vars/ip_address.yml)
```bash
inventory/
└── host_vars/
    ├── server1.yml  # Hostname-based variable file
    └── 192.168.1.100.yml  # IP address-based variable file
```
Example content (`host_vars/server1.yml`):

```yaml
---
# host_vars/server1.yml
web_server_port: 8080
app_version: "1.2.3"

```
```yaml
---
- name: Example Playbook
  hosts: server1
  tasks:
    - name: Start web server
      command: "start_server --port {{ web_server_port }}"

```

## Group Variables (group_vars/groupname.yml)
```bash
inventory/
└── group_vars/
    └── web_servers.yml  # Group-based variable file

```
Example content (`group_vars/web_servers.yml`):
```yaml
---
# group_vars/web_servers.yml
database_host: "db.example.com"
database_port: 3306

```
```yaml
---
- name: Example Playbook
  hosts: web_servers
  tasks:
    - name: Configure database connection
      template:
        src: database_config.j2
        dest: /etc/myapp/database.conf
      vars:
        db_host: "{{ database_host }}"
        db_port: "{{ database_port }}"

```


## Reference
https://github.com/devopshobbies/ansible-templates/tree/master
