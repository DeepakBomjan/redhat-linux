Let's break down the `sudoers` configuration line you provided for the user `john`:

```sudoers
john ALL = ALL, !SHELLS, PASSWD: /bin/ls, /usr/bin/who, /usr/bin/man
```

### Explanation:

1. **`john ALL = ALL`**:
   - This part grants `john` permission to execute any command (`ALL`) as any user (`ALL`). Essentially, it allows `john` to use `sudo` for any administrative task.

2. **`, !SHELLS`**:
   - The comma separates different command specifications. `!SHELLS` specifies that `john` is not allowed to run shell commands using `sudo`. This is a security measure to prevent `john` from opening a shell with elevated privileges, which could potentially bypass other restrictions.

3. **`PASSWD:`**:
   - This keyword requires `john` to enter his password when executing the following commands with `sudo`. It ensures an additional layer of security.

4. **`/bin/ls, /usr/bin/who, /usr/bin/man`**:
   - These are specific commands (`/bin/ls`, `/usr/bin/who`, and `/usr/bin/man`) that `john` is allowed to execute with `sudo` privileges. The `PASSWD:` keyword indicates that `john` needs to enter his password specifically for these commands.

### Usage Scenario:

- **Listing files with `ls`:**
  ```sh
  sudo /bin/ls -l /root
  ```
  - `john` can list files in the `/root` directory using `sudo`.

- **Checking logged-in users with `who`:**
  ```sh
  sudo /usr/bin/who
  ```
  - `john` can view currently logged-in users on the system.

- **Reading manual pages with `man`:**
  ```sh
  sudo /usr/bin/man ls
  ```
  - `john` can read the manual page for the `ls` command using `sudo`.

### Security Considerations:

- **Restricting Shell Access (`!SHELLS`):** Prevents `john` from potentially accessing a root shell, which could lead to unintended system modifications or security breaches.
  
- **Command-Specific Password Requirement (`PASSWD:`):** Adds an extra layer of security by prompting `john` for his password only when executing specified commands.

- **Granular Command Permissions:** Limits `john` to executing only certain commands with elevated privileges, reducing the risk of accidental or malicious actions.

This `sudoers` configuration provides `john` with controlled administrative access, allowing him to perform specific tasks that are essential for system administration while maintaining security and restricting potentially risky activities. Adjust and expand the `sudoers` file based on your specific security policies and `john`'s role requirements.
To allow a user to run `sudo` commands without granting them access to a root shell, you can configure the `/etc/sudoers` file to restrict shell access explicitly. This is a security best practice to prevent users from escalating their privileges to a root shell, which could potentially compromise the system. Here’s how you can achieve this:

### Example Configuration

Assuming you want to allow the user `john` to execute specific commands with `sudo` but not allow access to a root shell, you can modify the `/etc/sudoers` file using the `!SHELLS` directive. Here’s an example:

```sudoers
john    ALL=(ALL) !SHELLS, /bin/ls, /usr/bin/who, /usr/bin/man
```

### Explanation:

1. **`john    ALL=(ALL)`**:
   - This specifies that `john` can execute commands as any user (`ALL`) on any host (`ALL`).

2. **`!SHELLS`**:
   - The `!SHELLS` directive denies `john` the ability to run shell commands using `sudo`. This prevents `john` from accessing a root shell.

3. **`,` (comma)**:
   - Separates the different command specifications.

4. **`/bin/ls, /usr/bin/who, /usr/bin/man`**:
   - These are the specific commands (`/bin/ls`, `/usr/bin/who`, and `/usr/bin/man`) that `john` is allowed to execute with `sudo` privileges.

### Usage Scenario:

- **Listing files with `ls`:**
  ```sh
  sudo /bin/ls -l /root
  ```
  - `john` can list files in the `/root` directory using `sudo`.

- **Checking logged-in users with `who`:**
  ```sh
  sudo /usr/bin/who
  ```
  - `john` can view currently logged-in users on the system.

- **Reading manual pages with `man`:**
  ```sh
  sudo /usr/bin/man ls
  ```
  - `john` can read the manual page for the `ls` command using `sudo`.

### Security Considerations:

- **Preventing Shell Access (`!SHELLS`):** Ensures that `john` cannot escalate privileges to a root shell, which helps prevent unauthorized access and potential system compromise.

- **Specific Command Permissions:** Limits `john` to executing only specified commands with elevated privileges, reducing the risk of accidental or intentional misuse.

### Applying the Configuration:

1. Edit the `/etc/sudoers` file securely using `visudo`:
   ```sh
   sudo visudo
   ```

2. Add or modify the `john` entry to include the `!SHELLS` directive and list the allowed commands.

3. Save and exit the `/etc/sudoers` file (`visudo` ensures syntax checking to prevent errors).

4. Test the configuration to ensure `john` can execute permitted commands with `sudo` without being able to access a root shell.

This configuration ensures that `john` can perform necessary administrative tasks while maintaining a secure environment by preventing direct access to a root shell through `sudo`. Adjust the allowed commands (`/bin/ls`, `/usr/bin/who`, etc.) based on `john`'s specific responsibilities and your system's security requirements.
