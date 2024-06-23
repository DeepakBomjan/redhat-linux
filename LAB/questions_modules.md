### User and Access Management in Linux

1. **Create a new user named 'john'.**
   <details>
   <summary>Show Answer</summary>
   `sudo useradd john`
   </details>

2. **Set the password for the user 'john'.**
   <details>
   <summary>Show Answer</summary>
   `sudo passwd john`
   </details>

3. **Delete the user 'john' and their home directory.**
   <details>
   <summary>Show Answer</summary>
   `sudo userdel -r john`
   </details>

4. **Create a new group named 'developers'.**
   <details>
   <summary>Show Answer</summary>
   `sudo groupadd developers`
   </details>

5. **Add user 'john' to the 'developers' group.**
   <details>
   <summary>Show Answer</summary>
   `sudo usermod -aG developers john`
   </details>

6. **Change the shell for user 'john' to `/bin/bash`.**
   <details>
   <summary>Show Answer</summary>
   `sudo usermod -s /bin/bash john`
   </details>

7. **Lock the user account 'john'.**
   <details>
   <summary>Show Answer</summary>
   `sudo usermod -L john`
   </details>

8. **Unlock the user account 'john'.**
   <details>
   <summary>Show Answer</summary>
   `sudo usermod -U john`
   </details>

9. **Change the home directory for user 'john' to `/home/newjohn`.**
   <details>
   <summary>Show Answer</summary>
   `sudo usermod -d /home/newjohn john`
   </details>

10. **Set the account expiration date for 'john' to December 31, 2024.**
    <details>
    <summary>Show Answer</summary>
    `sudo chage -E 2024-12-31 john`
    </details>

11. **View the groups that user 'john' is a member of.**
    <details>
    <summary>Show Answer</summary>
    `groups john`
    </details>

12. **Change the owner of the file `example.txt` to 'john'.**
    <details>
    <summary>Show Answer</summary>
    `sudo chown john example.txt`
    </details>

13. **Change the group ownership of the file `example.txt` to 'developers'.**
    <details>
    <summary>Show Answer</summary>
    `sudo chgrp developers example.txt`
    </details>

14. **Give the owner read, write, and execute permissions, and read and execute permissions to the group and others for `example.txt`.**
    <details>
    <summary>Show Answer</summary>
    `chmod 755 example.txt`
    </details>

15. **Give the owner read and write permissions, and read-only permissions to the group and others for `example.txt`.**
    <details>
    <summary>Show Answer</summary>
    `chmod 644 example.txt`
    </details>

16. **Recursively change the owner of the directory `/project` to 'john'.**
    <details>
    <summary>Show Answer</summary>
    `sudo chown -R john /project`
    </details>

17. **Recursively change the group ownership of the directory `/project` to 'developers'.**
    <details>
    <summary>Show Answer</summary>
    `sudo chgrp -R developers /project`
    </details>

18. **Set the password expiration policy to 90 days for user 'john'.**
    <details>
    <summary>Show Answer</summary>
    `sudo chage -M 90 john`
    </details>

19. **Display password expiration information for user 'john'.**
    <details>
    <summary>Show Answer</summary>
    `chage -l john`
    </details>

20. **List all users on the system.**
    <details>
    <summary>Show Answer</summary>
    `cut -d: -f1 /etc/passwd`
    </details>

21. **List all groups on the system.**
    <details>
    <summary>Show Answer</summary>
    `cut -d: -f1 /etc/group`
    </details>

22. **Add a comment 'Developer' to the user 'john'.**
    <details>
    <summary>Show Answer</summary>
    `sudo usermod -c "Developer" john`
    </details>

23. **Create a user 'alice' with the home directory `/home/alice`.**
    <details>
    <summary>Show Answer</summary>
    `sudo useradd -m -d /home/alice alice`
    </details>

24. **Create a user 'bob' with the shell `/bin/zsh`.**
    <details>
    <summary>Show Answer</summary>
    `sudo useradd -s /bin/zsh bob`
    </details>

25. **Display the user ID (UID) of 'john'.**
    <details>
    <summary>Show Answer</summary>
    `id -u john`
    </details>

26. **Display the group ID (GID) of 'john'.**
    <details>
    <summary>Show Answer</summary>
    `id -g john`
    </details>

27. **Display all information about user 'john'.**
    <details>
    <summary>Show Answer</summary>
    `id john`
    </details>

28. **Create a group 'admins' with GID 1001.**
    <details>
    <summary>Show Answer</summary>
    `sudo groupadd -g 1001 admins`
    </details>

29. **Change the GID of the group 'developers' to 1010.**
    <details>
    <summary>Show Answer</summary>
    `sudo groupmod -g 1010 developers`
    </details>

30. **Change the primary group of 'john' to 'developers'.**
    <details>
    <summary>Show Answer</summary>
    `sudo usermod -g developers john`
    </details>

31. **Create a user 'eve' with UID 1050.**
    <details>
    <summary>Show Answer</summary>
    `sudo useradd -u 1050 eve`
    </details>

32. **Create a group 'testers' and add user 'eve' to it.**
    <details>
    <summary>Show Answer</summary>
    `sudo groupadd testers && sudo usermod -aG testers eve`
    </details>

33. **Remove user 'eve' from the 'testers' group.**
    <details>
    <summary>Show Answer</summary>
    `sudo gpasswd -d eve testers`
    </details>

34. **Display the current logged-in users.**
    <details>
    <summary>Show Answer</summary>
    `who`
    </details>

35. **Show the last login information for all users.**
    <details>
    <summary>Show Answer</summary>
    `last`
    </details>

36. **Display the details of the 'sudo' group.**
    <details>
    <summary>Show Answer</summary>
    `getent group sudo`
    </details>

37. **Grant sudo privileges to user 'alice'.**
    <details>
    <summary>Show Answer</summary>
    `sudo usermod -aG sudo alice`
    </details>

38. **Edit the sudoers file using the safe method.**
    <details>
    <summary>Show Answer</summary>
    `sudo visudo`
    </details>

39. **Add a user 'testuser' with no home directory.**
    <details>
    <summary>Show Answer</summary>
    `sudo useradd -M testuser`
    </details>

40. **Create a user 'dan' and specify the user information with the option -c 'Dan the Admin'.**
    <details>
    <summary>Show Answer</summary>
    `sudo useradd -c 'Dan the Admin' dan`
    </details>

41. **Create a user 'kate' and add her to multiple groups 'developers' and 'admins'.**
    <details>
    <summary>Show Answer</summary>
    `sudo useradd -G developers,admins kate`
    </details>

42. **Change the password expiration warning to 7 days for user 'john'.**
    <details>
    <summary>Show Answer</summary>
    `sudo chage -W 7 john`
    </details>

43. **Show the group membership for the current user.**
    <details>
    <summary>Show Answer</summary>
    `groups`
    </details>

44. **Show the file permissions of 'example.txt' in long format.**
    <details>
    <summary>Show Answer</summary>
    `ls -l example.txt`
    </details>

45. **Change the permissions of 'script.sh' to be executable by the owner only.**
    <details>
    <summary>Show Answer</summary>
    `chmod u+x script.sh`
    </details>

46. **Remove execute permissions for others on 'app.py'.**
    <details>
    <summary>Show Answer</summary>
    `chmod o-x app.py`
    </details>

47. **Set the setuid bit on 'program'.**
    <details>
    <summary>Show Answer</summary>
    `sudo chmod u+s program`
    </details>

48. **Set the setgid bit on the directory 'shared'.**
    <details>
    <summary>Show Answer</summary>
    `sudo chmod g+s shared`
    </details>

49. **Set the sticky bit on the directory 'uploads'.**
    <details>
    <summary>Show Answer</summary>
    `sudo chmod +t uploads`
    </details>

50. **Display the effective user ID (EUID) and effective group ID (EGID) for the current process.**
    <details>
    <summary>Show Answer</summary>
    `id -u` and `id -g`
    </details>

