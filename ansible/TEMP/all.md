## https://devdocs.io/ansible/user_guide/basic_concepts

## Setting a remote user
```yaml
---
- name: update webservers
  hosts: webservers
  remote_user: admin

  tasks:
  - name: thing to do first in this playbook
  . . .
```
as a host variable in inventory:  

```yaml
other1.example.com     ansible_connection=ssh        ansible_user=myuser
other2.example.com     ansible_connection=ssh        ansible_user=myotheruser
```

## Managing host key checking
```yaml
[defaults]
host_key_checking = False
```

```bash
export ANSIBLE_HOST_KEY_CHECKING=False
```

## How do I keep secret data in my playbook?
```yaml
- name: secret task
  shell: /usr/bin/do_something --value={{ secret_value }}
  no_log: True
```

### The no_log attribute can also apply to an entire play:
```yaml
- hosts: all
  no_log: True
```

### Listing Group Variables
```bash
mkdir group_vars/
```

```bash
cat group_vars/webservers
---
my_vars:
 - OS: Ubuntu
 - uid: "445"
 - Home: /home/ruhul
 - gid: 69809
 - shell: /bin/bash
 ```

 To make use of our group variables, we create a playbook, `grp_var.yml`:

```bash
cat grp_var.yml
- hosts: client1
  tasks:
    - name: List a variable
      debug:
        var: my_vars
```
Let’s run the playbook and see the output:
```bash
ansible-playbook -i inventory.ini grp_var.yml
```

## Ansible Configuration Settings
Ansible supports several sources for configuring its behavior, including an ini file named ansible.cfg, environment variables, command-line options, playbook keywords, and variables. 

## Playbook Keywords
https://docs.ansible.com/ansible/latest/reference_appendices/playbooks_keywords.html

## YAML Syntax
https://docs.ansible.com/ansible/latest/reference_appendices/YAMLSyntax.html

```bash
ansible-doc --type keyword --list
```

## Creating simple plugins
https://www.dasblinkenlichten.com/creating-ansible-filter-plugins/

### Custom module
https://www.cloudwerkstatt.com/en/a-beginners-guide-to-building-a-custom-ansible-module-with-python-requests/

https://mjvish.hashnode.dev/ansible-custom-modules

### Ansible filter
https://docs.ansible.com/ansible/2.7/user_guide/playbooks_filters.html#list-filters


### Json path
https://jmespath.org/examples.html

### A brief introduction to Ansible Vault
https://www.redhat.com/sysadmin/introduction-ansible-vault

### Managing vault password
https://docs.ansible.com/ansible/latest/vault_guide/vault_managing_passwords.html