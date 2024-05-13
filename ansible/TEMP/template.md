1. Create network.j2
```bash
{{ ansible_default_ipv4.address }}
```
2. Create playbook
```yaml
---
- hosts: local
  tasks:
  - name: deploy local net file
    template:
      src: /home/ec2-user/template/network.j2
      dest: /home/ec2-user/template/network.txt
```
3. Add some content in template

```bash
My IP address is {{ ansible_default_ipv4.address }}
{{ ansible_distribution }} is my OS version
```


## Print ipv4 address of the system
```bash
{{ hostvars['node1']['ansible_distribution'] }}
{{ groups['webservers']}}
{{ groups['webservers']| join(' ')}}
```

4. Create empty file
```yaml
---
- hosts: local
  vars:
    env_file: /home/ec2-user/vars/env.txt
  tasks:
    - name: create file
      file:
        path: "{{ env_file }}"
        state: touch
    - name: generate inventory
      lineinfile: 
        path: "{{ env_file }}"
        line: "{{ groups['labservers'] }}"
```

5. create user.list
```yaml
staff:
  - ram
  - shyam
  - sita
faculty:
  - hari
  - rita
  - gita
other:
  - prem
  - nita

```

```yaml
---
- hosts: local
  vars: 
    userFile: /home/ec2-user/vars/list
  tasks:
    - name: crate file
      file:
        state: touch
        path: "{{ userFile }}"
    - name: list users
      lineinfile:
        path: "{{ userFile }}"
        line: "{{ item }}"
      with_items:
        - "{{ staff }}"
        - "{{ faculty }}"
        - "{{ other }}"
```
```bash
ansible-playbook userList.yaml -e "@users.list"
```

## Ansible facts
```bash
ansible server -m setup -a "filter=*dist*"
```
```bash
mkdir /etc/ansible/facts.d
```
```bash
/etc/ansible/facts.d/prefs.fact
[location]
type=physical
system=db
```
```bash
ansible server -m setup -a "filter=ansible_local"
```
