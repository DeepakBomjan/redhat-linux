## Miscellaneous Commands
```bash
lsof -p PROCESS_ID
ps auxwwwe
ps ax -o pid,cmd

pgrep -u USER | while read a; do echo -n "$a "; readlink /proc/$a/exe; done
cat /proc/*/cmdline