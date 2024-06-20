## Ansible Modules
_Modules_ represent distinct units of code, each one with specific functionality. 

```yaml
- name: "Install Nginx to version {{ nginx_version }} with apt module"
   ansible.builtin.apt:
     name: "nginx={{ nginx_version }}"
     state: present
```
```bash
ansible databases -m ping

```
```bash
ansible-doc apt
```

### 12 Useful & Common Ansible Modules
1. Package Manager Modules yum & apt
```yaml
- name: Update the repository cache and update package "nginx" to latest version
  ansible.builtin.apt:
    name: nginx
    state: latest
    update_cache: yes
```
```yaml
- name: Update the repository cache and update package "nginx" to latest version
   ansible.builtin.yum:
     name: nginx
     state: latest
     update_cache: yes
```
2. Service Module
```yaml
- name: Restart docker service
   ansible.builtin.service:
     name: docker
     state: restarted
```
3. File Module
```yaml
- name: Create the directory "/etc/test" if it doesnt exist and set permissions
  ansible.builtin.file:
    path: /etc/test
    state: directory
    mode: '0750'
```
4. Copy Module
```yaml
- name: Copy file with owner and permissions
  ansible.builtin.copy:
    src: /example_directory/test
    dest: /target_directory/test
    owner: joe
    group: admins
    mode: '0755'
```
5. Template Module
```yaml
- name: Copy and template the Nginx configuration file to the host
  ansible.builtin.template:
    src: templates/nginx.conf.j2
    dest: /etc/nginx/sites-available/default
```
6. Cron Module
```yaml
- name: Run daily DB backup script at 00:00
  ansible.builtin.cron:
    name: "Run daily DB backup script at 00:00"
    minute: "0"
    hour: "0"
    job: "/usr/local/bin/db_backup_script.sh > /var/log/db_backup_script.sh.log 2>&1"
```
7. Wait_for Module
```yaml
- name: Wait until a string is in the file before continuing
  ansible.builtin.wait_for:
    path: /tmp/example_file
    search_regex: "String exists, continue"
```
8. Command & Shell Modules
```yaml
- name: Execute a script in remote shell and capture the output to file
  ansible.builtin.shell: script.sh >> script_output.log
```

### References
https://spacelift.io/blog/ansible-modules

https://faun.pub/ansible-30-most-important-modules-for-devops-professional-part-1-fdd536b0790d

https://opensource.com/article/19/9/must-know-ansible-modules
