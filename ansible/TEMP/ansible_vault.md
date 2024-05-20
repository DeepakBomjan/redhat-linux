**Ansible Vault** is a feature of Ansible that allows users to encrypt sensitive data within Ansible projects. This can include passwords, secret keys, and other confidential information that you don't want to store as plain text in your playbooks or inventory files. Here’s an example use case demonstrating how Ansible Vault can be used effectively:

## Use Case: Managing Database Credentials Securely
**Scenario**:
You are managing a web application that connects to a database. The database credentials (username and password) need to be used within your Ansible playbooks to configure and deploy the application. However, storing these credentials in plain text poses a security risk. You can use Ansible Vault to securely encrypt these sensitive details.

Steps:
Create an Encrypted File:
First, create a file to store your sensitive information, such as db_credentials.yml.


```yaml
db_user: "my_database_user"
db_password: "my_secure_password"

```
Then, use Ansible Vault to encrypt this file:

```bash
ansible-vault encrypt db_credentials.yml
```
You will be prompted to enter a password, which will be used to encrypt and later decrypt this file.

### Reference Encrypted Variables in Playbooks:
In your Ansible playbook, you reference the encrypted variables. Here’s an example playbook (`deploy_app.yml`) that uses these credentials to configure a database:

```yaml
---
- hosts: web_servers
  vars_files:
    - db_credentials.yml
  tasks:
    - name: Ensure the database is configured
      mysql_db:
        name: my_database
        state: present

    - name: Create a database user
      mysql_user:
        name: "{{ db_user }}"
        password: "{{ db_password }}"
        priv: 'my_database.*:ALL'
        state: present
```

### Running the Playbook with Ansible Vault:
When you run the playbook, you need to provide the vault password to decrypt the db_credentials.yml file:

```bash
ansible-playbook --ask-vault-pass deploy_app.yml
```
Alternatively, you can store the vault password in a file and use the `--vault-password-file` option:

```bash
ansible-playbook --vault-password-file .vault_pass deploy_app.yml
```

**Benefits**:
1. Security: Sensitive data is encrypted and only accessible with the vault password.
Simplicity: Easy integration into existing Ansible workflows without the need for external secrets management tools.
2. Compliance: Helps in meeting security compliance requirements by ensuring that sensitive information is not exposed in plaintext.
Using Ansible Vault in this way ensures that your database credentials and other sensitive data remain secure, while still being easily accessible for automation and deployment processes.

### How to store password in text file

Storing a password in a text file is generally not recommended for production environments due to security risks. However, for development or certain controlled scenarios, it can be useful. If you need to store a password in a text file and use it with Ansible Vault, here’s how you can do it securely:

Steps to Store a Password in a Text File for Ansible Vault
Create a Password File:
Create a text file to store the password that will be used to encrypt and decrypt Ansible Vault files. Make sure this file has restricted permissions so that only authorized users can read it.

```bash
echo 'your_vault_password_here' > .vault_pass.txt
```
Set Secure Permissions:
Change the file permissions to ensure that only the owner can read and write the file:
```bash
chmod 600 .vault_pass.txt
```
Encrypt a File with Ansible Vault Using the Password File:
Use Ansible Vault to encrypt a file, specifying the password file:

```bash
ansible-vault encrypt --vault-password-file .vault_pass.txt your_file.yml
```
Decrypt a File with Ansible Vault Using the Password File:
Similarly, to decrypt the file, use the password file:

```bash
ansible-vault decrypt --vault-password-file .vault_pass.txt your_file.yml
```
Using the Encrypted File in a Playbook:
When running a playbook that references the encrypted file, you can use the `--vault-password-file` option:

```bash
ansible-playbook --vault-password-file .vault_pass.txt your_playbook.yml
```
### Example Workflow
Encrypting a File
Suppose you have a file `db_credentials.yml` with sensitive data:

```yaml
db_user: "my_database_user"
db_password: "my_secure_password"
```
Encrypt this file using the password stored in `.vault_pass.txt`:

```bash
ansible-vault encrypt --vault-password-file .vault_pass.txt db_credentials.yml
```
### Playbook Configuration
In your playbook (`deploy_app.yml`), reference the encrypted variables:

```yaml
---
- hosts: web_servers
  vars_files:
    - db_credentials.yml
  tasks:
    - name: Ensure the database is configured
      mysql_db:
        name: my_database
        state: present

    - name: Create a database user
      mysql_user:
        name: "{{ db_user }}"
        password: "{{ db_password }}"
        priv: 'my_database.*:ALL'
        state: present
```
### Running the Playbook
Run the playbook using the password file to decrypt the variables on the fly:

```bash
ansible-playbook --vault-password-file .vault_pass.txt deploy_app.yml
```
### Security Considerations
Restrict Access: Ensure the password file (.vault_pass.txt) is stored securely and has appropriate access controls.
**Environment Specific**: Avoid using plaintext password files in production. Consider using environment-specific secure storage solutions like AWS Secrets Manager, HashiCorp Vault, or other secrets management tools for production environments.
**Rotate Passwords**: Regularly rotate your Ansible Vault passwords and update your encrypted files accordingly.
By following these steps, you can manage encrypted Ansible Vault files with a password stored in a text file securely within controlled environments.






## How to encrypt individual variable value and use in playbook

Encrypting individual variable values in Ansible and using them in a playbook involves the use of Ansible Vault. Here’s a step-by-step guide on how to achieve this:

### Steps to Encrypt Individual Variable Values
Encrypt the Variable Value:
Use the ansible-vault encrypt_string command to encrypt the value of a variable. For example, if you want to encrypt a database password:

```bash
ansible-vault encrypt_string 'my_secure_password' --name 'db_password'
```
This command will prompt you for a vault password and then output an encrypted string that can be used directly in your playbook or variables file.

The output will look something like this:

```yaml
db_password: !vault |
      $ANSIBLE_VAULT;1.1;AES256
      31346534373137643638383530646564323032663034366235373732383731396434613532623537
      6561303061636132353934393063393633633963366533310a313939616434663164353866333335
      34386666373537366565326532333538323132383235616235366461303036633964326138626163
      6635306136366332610a656463616531383866313363623730343137623138343261656532653839
      3336
```
Add the Encrypted Variable to a Variables File:
You can add the encrypted variable directly to a variables file or an inventory file. For example, create a file called `secrets.yml`:

```yaml
---
db_user: "my_database_user"
db_password: !vault |
      $ANSIBLE_VAULT;1.1;AES256
      31346534373137643638383530646564323032663034366235373732383731396434613532623537
      6561303061636132353934393063393633633963366533310a313939616434663164353866333335
      34386666373537366565326532333538323132383235616235366461303036633964326138626163
      6635306136366332610a656463616531383866313363623730343137623138343261656532653839
      3336
```
Reference the Encrypted Variable in Your Playbook:
In your playbook, reference the variables from the `secrets.yml` file. For example, `deploy_app.yml`:

```yaml
---
- hosts: web_servers
  vars_files:
    - secrets.yml
  tasks:
    - name: Ensure the database is configured
      mysql_db:
        name: my_database
        state: present

    - name: Create a database user
      mysql_user:
        name: "{{ db_user }}"
        password: "{{ db_password }}"
        priv: 'my_database.*:ALL'
        state: present
```
Running the Playbook:
When running the playbook, you will need to provide the vault password to decrypt the variable values:

```bash
ansible-playbook --ask-vault-pass deploy_app.yml
```
Alternatively, if you have a vault password file, use:

```bash
ansible-playbook --vault-password-file .vault_pass.txt deploy_app.yml
```

### can I also use in same main playbook

Steps to Encrypt Individual Variable Values and Use Them Directly in the Playbook
Encrypt the Variable Value:
Use the `ansible-vault encrypt_string` command to encrypt the value of a variable. For example, to encrypt a database password:

```bash
ansible-vault encrypt_string 'my_secure_password' --name 'db_password'
```
The output will look something like this:

```yaml
db_password: !vault |
      $ANSIBLE_VAULT;1.1;AES256
      31346534373137643638383530646564323032663034366235373732383731396434613532623537
      6561303061636132353934393063393633633963366533310a313939616434663164353866333335
      34386666373537366565326532333538323132383235616235366461303036633964326138626163
      6635306136366332610a656463616531383866313363623730343137623138343261656532653839
      3336
```
Include the Encrypted Variable Directly in the Playbook:
You can include the encrypted variable directly in your playbook. Here’s an example of a playbook (`deploy_app.yml`) with encrypted variables:

```yaml
---
- hosts: web_servers
  vars:
    db_user: "my_database_user"
    db_password: !vault |
      $ANSIBLE_VAULT;1.1;AES256
      31346534373137643638383530646564323032663034366235373732383731396434613532623537
      6561303061636132353934393063393633633963366533310a313939616434663164353866333335
      34386666373537366565326532333538323132383235616235366461303036633964326138626163
      6635306136366332610a656463616531383866313363623730343137623138343261656532653839
      3336
  tasks:
    - name: Ensure the database is configured
      mysql_db:
        name: my_database
        state: present

    - name: Create a database user
      mysql_user:
        name: "{{ db_user }}"
        password: "{{ db_password }}"
        priv: 'my_database.*:ALL'
        state: present
```
### Running the Playbook:
When running the playbook, you need to provide the vault password to decrypt the variable values:

```bash
ansible-playbook --ask-vault-pass deploy_app.yml
```
Alternatively, if you have a vault password file, use:

```bash
ansible-playbook --vault-password-file .vault_pass.txt deploy_app.yml
```