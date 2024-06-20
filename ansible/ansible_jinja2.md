## Templating (Jinja2)
###  Jinja2 Example

```bash
├── hostname.yml
├── templates
    └── test.j2
```

Our hostname.yml:
```yaml
---
- name: Write hostname
  hosts: all
  tasks:
  - name: write hostname using jinja2
    ansible.builtin.template:
       src: templates/test.j2
       dest: /tmp/hostname
```
Our test.j2:
```bash
My name is {{ ansible_facts['hostname'] }}
```

## References
https://docs.ansible.com/ansible/latest/playbook_guide/playbooks_templating.html
