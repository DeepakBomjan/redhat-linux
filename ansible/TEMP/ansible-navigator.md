## Installation
```bash
subscription-manager attach --pool=<sku-pool-id>
```
```bash
sudo subscription-manager repos --enable ansible-automation-platform-2.4-for-rhel-9-x86_64-rpms
```
```bash
dnf install ansible-navigator
```


Steps
Install podman.
Install ansible and ansible-navigator in a Python virtualenv.
Create an inventory file.
Create an ansible-navigator.yml config file.
Create a test.yml playbook.
Examples.
These steps assume you are running a RHEL-based system, and they maximize the likelihood you will be running a supported version of Python for your Ansible* pip installs.

Install podman
$ sudo yum install podman -y

Install ansible and ansible-navigator in a Python virtualenv
```bash
cd ~
sudo yum install python39 -y
python3.9 -m venv navdemo
source navdemo/bin/activate
pip3 install --upgrade pip 
pip3 install ansible ansible-navigator
which ansible # SHOULD BE: ~/navdemo/bin/ansible
which ansible-navigator # SHOULD BE: ~/navdemo/bin/ansible-navigator
```
Create an inventory file
A pretty simple test ~/inventory file might look like:

```bash
$ cat inventory 
locahost ansible_connection=local
```

(navdemo) [vagrant@rhel8 ~]$ 
Create an ansible-navigator.yml config file
Next let’s write an ~/ansible-navigator.yml config file that will give us a good jumping off point to explore some key features of ansible-navigator in a moment (see more options here):

# ansible-navigator.yml:
---
ansible-navigator:
  ansible:
    inventory:
      entries:
      - inventory
  execution-environment:
    container-engine: podman
    enabled: false
    image: quay.io/ansible/ansible-navigator-demo-ee:latest
  logging:
    level: debug
  playbook-artifact:
    enable: true
    save-as: playbook-artifacts/{playbook_name}-artifact-{ts_utc}.json
  # mode: stdout
And here’s an Ansible playbook we’ll call ~/test.yml:

# test.yml:
---
- name: Test Playbook
  hosts: all
  tasks:
    - name: Test ping
      ansible.builtin.ping:
      register: result

    - name: Print ping result
      ansible.builtin.debug:
        msg: "{{ result }}"


## References
https://levelupla.io/a-blazingly-fast-ansible-navigator-tutorial/
