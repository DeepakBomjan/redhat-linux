## Set ulimit
### Soft Limit
```bash
ulimit -Sa
```
### Hard Limit
```bash
ulimit -Ha
```

### Limit Process Number
```bash
ulimit -u 10
```
Run fork bomb
```bash
:(){ :|:& };:
```

The string `:(){ :|:& };:` is known as the "**fork bomb**" in Linux and Unix-like systems. It's a malicious piece of code that can cause a denial-of-service (DoS) attack by consuming system resources and causing the system to become unresponsive.

Let's break down how this code works:

1. `:():` This defines a function named :. In Bash scripting (and similar shells), the colon (:) is a valid function name.

2. `{ ... }:` This encloses the body of the function.

3. `:|:&:` This line contains two uses of the function ::

    * `:` calls the function recursively, creating a new process each time.
    * `|` is the pipe operator, which redirects the output of the left side to the input of the right side. Here, it creates a pipeline between the processes.
    * `&` sends the process to the background, allowing the function to spawn new instances without waiting for each one to finish.
4. `;:` Separates multiple commands on a single line.

5. `::` Invokes the initial call to the function.

When you run this code, it starts by defining the function `:`. Then, it invokes `:` with `|` and `&`, causing a chain reaction of processes that rapidly consume system resources, leading to a system crash or severe slowdown due to the high CPU and memory usage.

This code is a dangerous example and should never be executed on a system unless you fully understand its implications and have explicit permission to perform such actions (e.g., in a controlled testing environment). It's often used as an example to highlight the importance of understanding and securing against malicious code execution.

### Limit File Size
```bash
ulimit -f 50
```
```bash

cat /dev/zero > file # limits the file size to 50KB
```

### Limit Maximum Virtual Memory
```bash

ulimit -v 1000   # limits the virtual memory available for a process to 1000KB
```

### Limit the Number of Open Files
```bash
ulimit -n 5
```
Example
```bash
ls *.txt | xargs -n 1 xdg-open
```
