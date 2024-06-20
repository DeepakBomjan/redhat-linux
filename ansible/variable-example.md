1. Simple variables
```yaml
- name: Example Simple Variable
  hosts: all
  become: yes
  vars:
    username: bob

  tasks:
  - name: Add the user {{ username }}
    ansible.builtin.user:
      name: "{{ username }}"
      state: present
```
2. List, dictionary & nested variables
```yaml
vars:
  cidr_blocks:
      production:
        vpc_cidr: "172.31.0.0/16"
      staging:
        vpc_cidr: "10.0.0.0/24"

tasks:
- name: Print production vpc_cidr
  ansible.builtin.debug:
    var: cidr_blocks['production']['vpc_cidr']
```
3. Magic variables
```yaml
---
- name: Echo playbook
  hosts: localhost
  gather_facts: no
  tasks:
    - name: Echo inventory_hostname
      ansible.builtin.debug:
        msg:
          - "Hello from Ansible playbook!"
          - "This is running on {{ inventory_hostname }}"
```
4. Ansible facts
```bash
ansible -m setup <hostname>
```
5. Connection variables
```yaml
---
- name: Echo message on localhost
  hosts: localhost
  connection: local
  gather_facts: no
  vars:
    message: "Hello from Ansible playbook on localhost!"
  tasks:
    - name: Echo message and connection type
      ansible.builtin.shell: "echo '{{ message }}' ; echo 'Connection type: {{ ansible_connection }}'"
      register: echo_output

    - name: Display output
      ansible.builtin.debug:
        msg: "{{ echo_output.stdout_lines }}"
```
6. Registering variables
```yaml
- name: Example Register Variable Playbook
  hosts: all
  
  tasks:
  - name: Run a script and register the output as a variable
    shell: "find hosts"
    args:
      chdir: "/etc"
    register: find_hosts_output
  - name: Use the output variable of the previous task
    debug:
      var: find_hosts_output
```

```yaml
- name: Example Registered Variables Conditionals
  hosts: all
  
  tasks:
  - name: Register an example variable
    shell: cat /etc/hosts
    register: hosts_contents

  - name: Check if hosts file contains the word "localhost"
    debug:
      msg: "/etc/hosts file contains the word localhost"
    when: hosts_contents.stdout.find("localhost") != -1
      var: find_hosts_output
```

### Where to set Ansible variables?
1. Vars block
```yaml
- name: Set variables in a play
  hosts: all
  vars:
    version: 12.7.1
```
2. Inventory files
```yaml
[webservers]
webserver1 ansible_host=10.0.0.1 ansible_user=user1
webserver2 ansible_host=10.0.0.2 ansible_user=user2

[webservers:vars]
http_port=80
```
To better organize our variables, we could gather them in separate host and group variables files. 
```bash
group_vars/databases 
group_vars/webservers
host_vars/host1
host_vars/host2
```
3. Custom var files
```yaml
- name: Example External Variables file
  hosts: all
  vars_files:
    - ./vars/variables.yml

  tasks:
  - name: Print the value of variable docker_version
    debug: 
      msg: "{{ docker_version}} "
  
  - name: Print the value of group variable http_port
    debug: 
      msg: "{{ http_port}} "
  
  - name: Print the value of host variable app_version
    debug: 
      msg: "{{ app_version}} "
```
The `vars/variables.yml` file:
```yaml
docker_version: 20.10.12
```

The `group_vars/webservers` file:
```yaml
http_port: 80
ansible_host: 127.0.0.1
ansible_user: vagrant
```
The `host_vars/host1` file:
```yaml
app_version: 1.0.1
ansible_port: 2222
ansible_ssh_private_key_file: ./.vagrant/machines/host1/virtualbox/private_key
```
The `host_vars/host2` file:
```yaml
app_version: 1.0.2
ansible_port: 2200
ansible_ssh_private_key_file: ./.vagrant/machines/host2/virtualbox/private_key
```
The inventory file contains a group named _webservers_ that includes our two hosts, _host1_ and _host2_:
```yaml
[webservers]
host1 
host2
```

If we run this playbook, we notice the same value is used in both hosts for the group variable _http_port_ but a different one for the host variable _app_version_.

```bash
ansible-playbook example-external-vars.yml
```

### References
1. https://spacelift.io/blog/ansible-variables
