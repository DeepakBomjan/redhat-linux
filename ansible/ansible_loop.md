1. playbook without loop
```yaml
- name: Install nginx
  apt: 
    name: nginx 
    state: present
- name: Install mysql
  apt: 
    name: mysql
    state: present
- name: Install php
  apt: 
    name: php
    state: present
```
2. With loop
```yaml
- name: Install Packages
  apt: 
    name: "{{ item }}" 
    state: present
  loop:
    - nginx
    - mysql
    - php
```

3. Iterating over a simple list
```yaml
tasks:
  - name: Task description
    ansible_module:
      key: "{{ item }}"
    loop: [item1, item2, item3]
```
```yaml
---
- name: Install packages using Ansible
  hosts: servers
  tasks:
    - name: Install Packages
      apt: 
        pkg: "{{ item }}" 
        state: present
      loop:
        - nginx
        - mysql
        - php
```

4. Looping over a Dictionary
```yaml
---
- name: Assign roles to servers
  hosts: localhost
  gather_facts: no
  tasks:
    - name: Print server role info
      ansible.builtin.debug:
        msg: "Server: {{ item.key }}, Role: {{ item.value }}"
      loop: "{{ servers | dict2items }}"
      vars:
        servers:
          server1: 'web'
          server2: 'database'
```

### Reference
https://www.packetswitch.co.uk/how-to-use-ansible-loops-with-examples/
