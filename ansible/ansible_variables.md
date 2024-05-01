[## Using Variables](https://docs.ansible.com/ansible/latest/playbook_guide/playbooks_variables.html)

### Creating valid variable names
#### Simple variables
1. Define simple variables
```yaml
remote_install_path: /opt/my_app_config
```
2. Reference simple variable
```yaml
ansible.builtin.template:
  src: foo.cfg.j2
  dest: '{{ remote_install_path }}/foo.cfg'
```
In this example, the variable defines the location of a file, which can vary from one system to another.

### List variables
1. Define variables as lists
```yaml
region:
  - northeast
  - southeast
  - midwest
```
2. Referencing list variables
```yaml
region: "{{ region[0] }}"
```

### Dictionary variables
1. Defining variables as key:value dictionaries
```yaml
foo:
  field1: one
  field2: two
```
2. Referencing key:value dictionary variables
```yaml
foo['field1']
foo.field1
```
## Registering variables
You can create variables from the output of an Ansible task with the task keyword register. You can use registered variables in any later tasks in your play. For example:
```yaml
- hosts: web_servers

  tasks:

     - name: Run a shell command and register its output as a variable
       ansible.builtin.shell: /usr/bin/foo
       register: foo_result
       ignore_errors: true

     - name: Run a shell command using output of the previous task
       ansible.builtin.shell: /usr/bin/bar
       when: foo_result.rc == 5
```

1. Simple Variable Example:
```yaml
- name: Register variable from command output
  command: echo "Hello, Ansible!"
  register: output_result

- name: Use registered variable in condition
  debug:
    msg: "Output is {{ output_result.stdout }}"
  when: output_result.rc == 0  # Check return code

```
2. List Variable Example:
```yaml
- name: Register list variable from shell command
  shell: "ls /tmp"
  register: files_list

- name: Use list variable in condition
  debug:
    msg: "Found {{ files_list.stdout_lines | length }} files"
  when: files_list.stdout_lines | length > 0  # Check if list is not empty

```
3. Dictionary Variable Example:
```bash
- name: Register dictionary variable from command output
  shell: "cat /etc/os-release"
  register: os_info

- name: Use dictionary variable in condition
  debug:
    msg: "OS is {{ os_info.stdout_lines[0] }}"
  when: "'Ubuntu' in os_info.stdout"  # Check if 'Ubuntu' is in the output

```

### Referencing nested variables
Many registered variables (and facts) are nested YAML or JSON data structures. 

```yaml
{{ ansible_facts["eth0"]["ipv4"]["address"] }}
```
```yaml
{{ ansible_facts.eth0.ipv4.address }}
```

## Where to set variables
You can define variables in a variety of places, such as in inventory, in playbooks, in reusable files, in roles, and at the command line. 

1. Defining variables in a play
```yaml
- hosts: webservers
  vars:
    http_port: 80
```
2. Defining variables in included files and roles
```yaml
---

- hosts: all
  remote_user: root
  vars:
    favcolor: blue
  vars_files:
    - /vars/external_vars.yml

  tasks:

  - name: This is just a placeholder
    ansible.builtin.command: /bin/echo foo
```
3. Defining variables at runtime
```bash
ansible-playbook release.yml --extra-vars "version=1.23.45 other_variable=foo"
```

[### Special Variables](https://docs.ansible.com/ansible/latest/reference_appendices/special_variables.html)
