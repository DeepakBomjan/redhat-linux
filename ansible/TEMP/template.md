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

