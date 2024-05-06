## Use file,lineinfile, yum, service module
```yaml
---
- name: Install and configure Apache HTTP server
  hosts: your_target_hosts
  become: true  # Run tasks with sudo

  tasks:
    - name: Install httpd package
      yum:
        name: httpd
        state: present

    - name: Start httpd service and enable it on boot
      service:
        name: httpd
        state: started
        enabled: yes

    - name: Touch index.html file
      file:
        path: /var/www/html/index.html
        state: touch

    - name: Add a line to index.html
      lineinfile:
        path: /var/www/html/index.html
        line: "<p>This is a new line added by Ansible</p>"
        insertafter: "<h1>Welcome to my website!</h1>"
```
## To limit to run only specific hosts
```bash
ansible-playbook demo.yml --limit host1 host3
```

## Create a file /tmp/newfile and save the uid of the file to new file /tmp/newfile

```yaml
---
- name: Create /tmp/newfile and save UID to /tmp/uid_file
  hosts: localhost
  gather_facts: false  # Disable gathering facts about the system

  tasks:
    - name: Create /tmp/newfile
      file:
        path: /tmp/newfile
        state: touch
      register: output

    # - name: Get UID of /tmp/newfile
    #   stat:
    #     path: /tmp/newfile
    #   register: output

    - name: Save UID to /tmp/uid_file
      copy:
        content: "{{ output.uid }}"
        dest: /tmp/newfile

```

## Use conditionals to Control play execution
```yaml
---
- hosts: localhost
  become: yes
  handlers: 
    - name: restart apache
      service: name="httpd" state="restarted"
      listen: "restart web"
  tasks:
    - name: change config
      replace:
        path: /etc/httpd/conf/httpd.conf
        regexp: '^DocumentRoot.*$'
        replace: 'DocumentRoot "/opt/www"'
        backup: yes
      notify: "restart web"
```

### loop
```yaml
---
- hosts: localhost
  become: yes
  tasks:
    - name: create user
      user:
        name: {{item}}
      with_items:
        - ram
        - shyam
        - hari
```

```yaml
---
- hosts: servers
  become: yes
  tasks:
    - name: edit index
      lineinfile:
        path: /var/www/html/index.html
        line: "Hello World"
      when: ansible_hostname == "example"
```
## Configure Error Handling
* Ignoring acceptable erros
* Defining failure conditions
* Defining "Changed"
* Blocks

```yaml
---
- hosts: servers
  tasks:
    - name: get files
      get_url:
        url: "http://{{item}}/index.html
        dest: "/tmp/{{item}}"
      ignore_errors: yes
      with_items:
        - host1
        - host2
```

## Disable https service in some machine
```bash
ansible host1,host2 -m service -a "name=httpd state=stopped"
```

### Error handling - Block group

```yaml
- hosts: servers
  tasks:
    - name: get files
      block
        - get_url:
            url: "http://host1/index.html
            dest: "/tmp/host1"
      rescue:
        - debug: msg="The file doesn't exist!"
      always:
        - debug: msg="Play done!"
```
```bash
ansible host1 -m service -a "name=httpd state=stopped"
```

### Running selective task with tags
```sql
insert into apps (name, id, state) values (hello, 5, deployed)
```
```yaml
---
- hosts: web
  become: yes
  tasks:
  - name: deploy app binary
    copy:
      src: /home/ec2-user/app/hello
      dest: /var/www/html/hello
    tags:
      - webdeploy
- hosts: db
  become: yes
  tasks:
  - name: deploy db script
    copy:
      src: /home/ec2-user/app/script.sql
      dest: /opt/db/script/script.sql
    tags:
      - dbdeploy
```

```bash
ansible-playbook demo.yaml --tags dbdeploy
```
