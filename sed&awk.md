## AWK Resource
https://github.com/freznicek/awesome-awk

https://github.com/pmitev/to-awk-or-not


## Quick Example
```bash
sed 's/^\(172\.31\.29\.167[[:space:]]*\)[^[:space:]]*/\1newhostname.com/' /etc/hosts
```
## Matching word boundary
```bash
cat > test
cat
catfis
catalog

grep '\bcat\b' test
sed 's/\bcat\b/dog/g' test
```

## Matching between context
```bash
sed -n '/###START/,/###END/p' sample.txt

sed -n '/###START/,/###END/{/###START/b;/###END/b;p}' sample.txt

sed -n '1p' sample.txt

sed -n '1,3p' sample.txt
# Insert line below matched line
sed '/###START/a\New Line to Insert' sample.txt
# Insert new line above matched line
sed '/###END/i\New Line to Insert' sample.txt
# Replace the matched string within match context
sed '/###START/,/###END/ {/shyam/d}' sample.txt

```
