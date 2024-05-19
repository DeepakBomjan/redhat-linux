## Ansible Vault
```bash
ansible-vault create foo.yml
```

```bash
ansible-vault create --vault-id password1@prompt foo.yml
```

## Decrypting Encrypted Files
```bash
ansible-vault decrypt foo.yml bar.yml baz.yml
ansible-vault view foo.yml bar.yml baz.yml
```

### Providing Vault Passwords
```bash
ansible-playbook --vault-password-file /path/to/my/vault-password-file site.yml
```
