## Linux trap & signal

In Linux, signals are mechanisms used by the operating system to communicate with processes. Here are some common signals and their meanings:

- **SIGHUP (1):** Hangup. This signal is typically sent to a process when its controlling terminal is closed.

- **SIGINT (2):** Interrupt. This is the signal sent when the user presses Ctrl+C. It's used to interrupt a running process.

- **SIGQUIT (3):** Quit. Similar to SIGINT, but also generates a core dump of the process.

- **SIGKILL (9):** Kill. This signal cannot be caught or ignored by the process and immediately terminates it.

- **SIGTERM (15):** Terminate. This is a termination sign


### Example 1
```bash
#!/bin/bash

cleanup() {
  echo "Cleaning up before exit"
  # Add your cleanup commands here
}

# Set up the trap command to call the cleanup function when the script receives the EXIT signal
trap cleanup EXIT

# Your script logic goes here

echo "Script is running"

# Simulate some work
sleep 5

# Uncomment the following line to force an error and trigger the trap
# undefined_command

# The cleanup function will be called automatically when the script exits
echo "Script completed"

```

## Example 2
## Resist or override Ctrl+C (SIGINT) or SIGKILL
```bash
#!/bin/bash

# Function to handle SIGTERM (Ctrl+C sends SIGINT, and SIGTERM can be sent using kill command)
terminate() {
  echo "Caught termination signal. Cleaning up..."
  # Add your cleanup commands here
  exit 1  # You can exit with a specific code if needed
}

# Set up the trap command to catch SIGTERM
trap terminate SIGTERM

# Function to simulate work
simulate_work() {
  while true; do
    echo "Working..."
    sleep 1
  done
}

# Ignore SIGINT (Ctrl+C)
trap '' SIGINT

echo "Script is running"

# Simulate some work
simulate_work

# The script will continue running until terminated by SIGTERM
```

### Ctrl+C (SIGINT)
```bash
#!/bin/bash

cleanup() {
  echo "Cleaning up before exit"
  # Add your cleanup commands here
  exit 1  # You can exit with a specific code if needed
}

# Set up the trap command to call the cleanup function when the script receives the SIGINT signal (Ctrl+C)
trap cleanup SIGINT

# Your script logic goes here

echo "Script is running"

# Simulate some work
while true; do
  echo "Working..."
  sleep 1
done

# The cleanup function will be called automatically when the user presses Ctrl+C

```

[The Bash Trap Command](https://www.linuxjournal.com/content/bash-trap-command)
```bash
tempfile=/tmp/tmpdata
trap "rm -f $tempfile" EXIT
```
```bash
function cleanup()
{
    # ...
}

trap cleanup EXIT
```

## Capture ^CTRL

```bash
ctrlc_count=0

function no_ctrlc()
{
    let ctrlc_count++
    echo
    if [[ $ctrlc_count == 1 ]]; then
        echo "Stop that."
    elif [[ $ctrlc_count == 2 ]]; then
        echo "Once more and I quit."
    else
        echo "That's it.  I quit."
        exit
    fi
}
```
```bash
trap no_ctrlc SIGINT

while true
do
    echo Sleeping
    sleep 10
done
```
## If you run that and type Ctrl-C three times, you'll get the following output:


