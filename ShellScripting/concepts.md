# [Bash Reference Manual](https://www.gnu.org/software/bash/manual/html_node/index.html#SEC_Contents)

1. [Shell Parameters](https://www.gnu.org/software/bash/manual/html_node/Shell-Parameters.html) 
2. [Bash Builtin Commands](https://www.gnu.org/software/bash/manual/html_node/Bash-Builtins.html)
3. [Shell Arithmetic](https://www.gnu.org/software/bash/manual/html_node/Shell-Arithmetic.html)
4. Substring Expansion
    ```bash
    ${parameter:offset}
    ${parameter:offset:length}

    ```
5. [Brace Expansion](https://www.gnu.org/software/bash/manual/html_node/Brace-Expansion.html)
6. [Shell Expansions](https://www.gnu.org/software/bash/manual/html_node/Shell-Expansions.html)

6. Bash Special Variables
    - **$0:** Gets the name of the  current script.
    - **$#:** Gets the number of    arguments passed while executing the   bash script.
    - **$*:** Gives you a string    containing every command-line  argument.
    - **$@:** It stores the list of every   command-line argument as an array.
    - **$1-$9:** Stores the first 9     arguments.
    - **$?:** Gets the status of the last   command or the most recently executed     process.
    - **$!:** Shows the process ID of the   last background command.
    - **$$:** Gets the process ID of the    current shell.
    - **$-:** It will print the current set of options in your current shell.


