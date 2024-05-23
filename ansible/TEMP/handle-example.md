---
- name: Install Apache on RHEL server
  hosts: localhost
  connection: local
  become: yes
  tasks:
    - name: Install latest version of Apache
      yum:
        name: httpd
        state: latest
      notify:
        - start apache
  handlers:
    - name: start apache
      service:
        name: httpd
        state: restarted