## Ansible Roles Explained | Cheat Sheet

1. Create ansible role
```bash
ansible-galaxy init base_httpd
```
tree baseline

2. Add index.html file
```bash
echo 'Hello World!' > base_httpd/files/index.html
```
3. Define default variables
```bash
cat base_httpd/defaults/main.yml
```
```yaml
---
# default files for base_httpd
base_httpd_listen_port: 80
base_httpd_log_level: warn
```
4. httpd.conf template
Copy existing httpd.conf file and make it as templates with couple variable added
```bash
Listen {{ base_httpd_listen_port }}
LogLevel {{ base_httpd_log_level }}
```
5. httpd task
cat base_httpd/tasks/main.yml

```yaml
---
# task file for base_httpd
- include: httpd.yml
```

cat base_httpd/tasks/httpd.yml
```yaml
---
# tasks file for base_httpd
- yum: name=httpd state=latest
- template: src=httpd.conf.j2 dest=/etc/httpd/conf/httpd.conf
- copy: src=index.html dest=/var/www/html/index.html
- service: name=httpd state=started enabled=yes


## Deploying the role
cat deployweb.yml
```yaml
---
- hosts: webservers
  become: yes
  roles:
    - /home/user/roles/base_httpd
```

## Overriding the default variables
```yaml
---
- hosts: webservers
  become: yes
  vars:
    base_httpd_loglevel: error
  roles:
    - /home/user/roles/base_httpd
```


## More Example
```bash
tree /etc/ansible/roles/apache/
/etc/ansible/roles/apache/
|-- README.md
|-- defaults
|   `-- main.yml
|-- files
|-- handlers
|   `-- main.yml
|-- meta
|   `-- main.yml
|-- tasks
|   `-- main.yml
|-- templates
|-- tests
|   |-- inventory
|   `-- test.yml
`-- vars
    `-- main.yml
8 directories, 8 files
```

```yaml
---
- hosts: all
  tasks:
  - name: Install httpd Package
    yum: name=httpd state=latest
  - name: Copy httpd configuration file
    copy: src=/data/httpd.original dest=/etc/httpd/conf/httpd.conf
  - name: Copy index.html file
    copy: src=/data/index.html dest=/var/www/html
    notify:
    - restart apache
  - name: Start and Enable httpd service
    service: name=httpd state=restarted enabled=yes
  handlers:
  - name: restart apache
    service: name=httpd state=restarted
```
## Tasks
```yaml
---
- name: Install httpd Package
  yum: name=httpd state=latest
- name: Copy httpd configuration file
  copy: src=/data/httpd.original dest=/etc/httpd/conf/httpd.conf
- name: Copy index.html file
  copy: src=/data/index.html dest=/var/www/html
  notify:
  - restart apache
- name: Start and Enable httpd service
  service: name=httpd state=restarted enabled=yes
```
**Or**

cat tasks/main.yml
```yaml
---
# tasks file for /etc/ansible/roles/apache
- import_tasks: install.yml
- import_tasks: configure.yml
- import_tasks: service.yml
```

### install.yaml
```yaml
---
- name: Install httpd Package
  yum: name=httpd state=latest
```
### configure.yml
```yaml
---
- name: Copy httpd configuration file
  copy: src=files/httpd.conf dest=/etc/httpd/conf/httpd.conf
- name: Copy index.html file
  copy: src=files/index.html dest=/var/www/html
  notify:
  - restart apache
```


## References
https://github.com/do-community/ansible-playbooks?tab=readme-ov-file
