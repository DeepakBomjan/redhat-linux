
## Playbook Examples With Conditionals
1. With Simple Registered Variable
```bash
cat date.yaml
```
```yaml
---
- name: Using Conditionals
  hosts: webserver
  tasks:
    - name: Run a command
      command: "date +%H"
      register: current_hour
    - name: Perform action based on time
      debug:
        msg: "Good {{ 'morning' if current_hour.stdout|int < 12 else 'afternoon' }}"
```
2. With String Type Registered Variable
```yaml
---
- hosts: client1
  tasks:
    - name: Register the contents of the /etc/passwd file
      command: cat /etc/passwd
      register: passwd_contents
    - name: Check if the word 'nologin' exists in the /etc/passwd file
      debug:
        msg: "The word 'nologin' exists in the /etc/passwd file: {{ passwd_contents.stdout.find('nologin') != -1 }}"
      when: passwd_contents.stdout.find('nologin') != -1
    - name: Display a message when the word 'nologin' is not found
      debug:
        msg: "The word 'nologin' is not found in the /etc/passwd file."
      when: passwd_contents.stdout.find('nologin') == -1
```
3. With List Type Registered Variable
```yaml
---
- hosts: client2
  become: yes
  tasks:
    - name: Retrieve the list of files in the /etc directory using the ls command
      ansible.builtin.command: ls /etc
      register: directory_files
    - name: Create an archive of the file abc.txt if it exists in the list
      ansible.builtin.command: tar -cf /home/vagrant/archive.tar.gz /etc/abc.txt
      when: "'abc.txt' in directory_files.stdout_lines"
```


[ansible conditional](https://docs.ansible.com/ansible/latest/playbook_guide/playbooks_conditionals.html#playbooks-conditionals)

[ansible example](https://github.com/ansible/ansible-examples/tree/master)