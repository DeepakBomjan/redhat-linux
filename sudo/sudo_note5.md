To set and restrict environment variables in `sudo`, you can use the `env_keep` and `env_reset` options in the `/etc/sudoers` file. This allows you to control which environment variables are preserved when running commands with `sudo`.

### Steps to Configure Environment Variables with `sudo`

1. **Reset Environment by Default**:
   The `env_reset` option resets the environment to a minimal set of variables by default. This is a security measure to prevent environment-based attacks.

2. **Keep Specific Environment Variables**:
   Use the `env_keep` option to specify which environment variables should be preserved.

3. **Set Default Environment Variables**:
   Use the `Defaults env_` option to set default environment variables for `sudo` sessions.

### Example Configuration

1. **Edit the `/etc/sudoers` File**:
   Open the sudoers file using the `visudo` command:

   ```sh
   sudo visudo
   ```

2. **Add Configuration for Environment Variables**:
   Here’s an example configuration to reset the environment, preserve specific variables, and set default variables:

   ```sudoers
   Defaults        env_reset
   Defaults        env_keep += "HOME"
   Defaults        env_keep += "LANG"
   Defaults        env_keep += "PATH"
   Defaults        env_keep += "TERM"
   Defaults        env_keep += "DISPLAY"
   Defaults        env_keep += "XAUTHORITY"
   Defaults        env_keep += "MY_CUSTOM_VAR"

   Defaults env_FILE_PATH="/path/to/file"
   Defaults env_API_KEY="your_api_key"
   ```

### Explanation

1. **`env_reset`**:
   - This option resets the environment to a minimal set of variables by default.

2. **`env_keep`**:
   - These lines specify which environment variables should be preserved. For example, `HOME`, `LANG`, `PATH`, `TERM`, `DISPLAY`, `XAUTHORITY`, and `MY_CUSTOM_VAR`.

3. **`Defaults env_`**:
   - These lines set default environment variables that will be available in the `sudo` session. For example, `FILE_PATH` and `API_KEY`.

### Practical Example

Let's say you want to allow a user `deployuser` to run a deployment script with specific environment variables set and restricted:

1. **Edit the `/etc/sudoers` File**:

   ```sh
   sudo visudo
   ```

2. **Add Configuration for `deployuser`**:

   ```sudoers
   Defaults        env_reset
   Defaults:deployuser env_keep += "HOME"
   Defaults:deployuser env_keep += "LANG"
   Defaults:deployuser env_KEEP += "MY_CUSTOM_VAR"
   Defaults:deployuser env_API_KEY="your_api_key"
   Defaults:deployuser env_DEPLOY_ENV="production"
   ```

3. **Deploy Script Example**:
   Assuming you have a deployment script `/usr/local/bin/deploy.sh`, make sure `deployuser` can run this script with `sudo`:

   ```sh
   sudo visudo
   ```

   Add the following line:

   ```sudoers
   deployuser ALL=(ALL) NOPASSWD: /usr/local/bin/deploy.sh
   ```

4. **Running the Deployment Script**:
   As `deployuser`, you can now run the deployment script with the specified environment variables:

   ```sh
   sudo /usr/local/bin/deploy.sh
   ```

### Verification

To verify that the environment variables are set and restricted as expected:

1. **Check Environment Variables**:
   Create a simple script to print environment variables:

   ```sh
   #!/bin/bash
   echo "HOME=$HOME"
   echo "LANG=$LANG"
   echo "MY_CUSTOM_VAR=$MY_CUSTOM_VAR"
   echo "API_KEY=$API_KEY"
   echo "DEPLOY_ENV=$DEPLOY_ENV"
   ```

2. **Run the Script with `sudo`**:

   ```sh
   sudo /usr/local/bin/deploy.sh
   ```

3. **Output**:
   Ensure that the output matches the expected values of the environment variables.

### Summary

By configuring the `/etc/sudoers` file with `env_reset` and `env_keep`, and setting default environment variables using `Defaults env_`, you can control and restrict the environment variables available in `sudo` sessions. This helps maintain security while allowing necessary environment variables to be preserved and set for specific users or commands.
