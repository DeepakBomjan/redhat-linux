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

## Create user and password
```bash
ansible -i project_inventory.ini client1 -m user -a "name=Baeldung-CS password=$(mkpasswd --method=sha-512 '123')" --become
```

```bash
mkpasswd --method=sha-512
```

## Set password

```yaml
cat play_pass1.yml
---
- name: Create a password for user
  hosts: client1
  become: yes
  tasks:
    - name: Create a password for user ram
      user:
        name: ram
        password: '$6$2OCdN3heBd$5swl1SfNkeiKd7n/WwZl/FpvhH4VJANl4u9j8kEA9gEjfl5lrqqQibiH2JU2rxW./Za3sp3BS2FabhTuTEAOQ.'

```
Method -2   

```yaml
---
- name: Create a password for user
  hosts: client1
  become: yes
  tasks:
    - name: Create a password for user ram
      user:
        name: ram
        password: "{{ '1234' | password_hash('sha512') }}"
```

## Configure remote access

```yaml
cat user_ssh.yml
---
- name: Create user, SSH directory, and transfer SSH keys
  hosts: client1
  become: yes   Use become to run tasks as a privileged user (e.g., sudo)
  tasks:
    - name: Create SSH directory for ram
      file:
        path: /home/ram/.ssh
        state: directory
        owner: ram
        group: ram
        mode: 0700
    - name: Generate SSH key for ram
      user:
        name: ram
        generate_ssh_key: yes
        ssh_key_type: rsa
        ssh_key_bits: 4096
        ssh_key_file: /home/ram/.ssh/id_rsa  # Full path is needed here
    - name: Transfer public key to the target host
      authorized_key:
        user: ram
        key: "{{ lookup('file', '/home/vagrant/.ssh/id_rsa.pub') }}" 
```
