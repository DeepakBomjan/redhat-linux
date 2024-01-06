## grep (global regular expression print)
### A regular expression may be followed by one of several repetition operators:

* **?** The preceding item is optional and matched at most once.
* **\*** The preceding item will be matched zero or more times.
* **+** The preceding item will be matched one or more times.
* **`{n}`** The preceding item is matched exactly n times.
* **`{n,}`** The preceding item is matched n or more times.
* **`{,m}`** The preceding item is matched at most m times.
* **`{n,m}`** The preceding item is matched at least n times, but not more than m times.

## Practice Sets
1. Create Demo File
```bash
    cat > demo.txt
    THIS LINE IS THE 1ST UPPER CASE LINE IN THIS FILE.
    this line is the 1st lower case line    in this file.
    This Line Has All Its First Character   Of The Word With Upper Case.

    Two lines above this line is empty.
    And this is the last line.
```

2. Search "literal string" 
```bash
    grep "this" demo_file
```
3. Check the given string in multiple files
```bash
    grep "this" *
```
4. Case insensitive search
```bash
    grep -i "this" demo.txt
```
5. Check full word, not sub-strings
```bash
    grep -iw "is" demo.txt
```
6. Display lines before/after/around the match.
    1. N lines after match
        ```bash
        grep -A 3 -i "example" demo.txt
        ```
    2. N lines before match
        ```bash
        grep -B 2 "single WORD" demo.txt
        ```
    3. N lines around match
        ```bash
        grep -C 2 "Example" demo.txt
        ```
7. Highlight the search using GREP_OPTIONS
    ```bash
    export GREP_OPTIONS='--color=auto' GREP_COLOR='100;8'
    ```
8. Search recursively
    ```bash
    grep -r "error" *
    ```
9. Invert match
    ```bash
    grep -v "go" demo.txt
    ```
10. display the lines which does not matches all the given pattern.
    ```bash
    $ cat test-file.txt
    a
    b
    c
    d

    $ grep -v -e "a" -e "b" -e "c"  test-file.txt
    d
    ```
11. Counting the number of matches
    ```bash
    grep -c "go" demo.txt
    grep -v -c "this" demo.txt
    ```
12. disploy the file names
    ```bash
    grep -l "this" demo.txt
    ```
13. Show only the matched string
    ```bash
    grep -o "is.*line" demo.txt
    ```
14. Show the position of match in the line
    ```bash
    cat > temp-file.txt
    12345
    12345

    grep -o -b "3" temp-file.txt
    ```
**Note**: The output of the grep command above is not the position in the line, it is byte offset of the whole file.
15. Show line number while displaying the output using grep -n
```bash
    grep -n "go" demo.txt
```
## Stream Editor SED Examples
The three basic operations supported by the sed command are:
1. Insertion
2. Deletion
3. Substitution (Find and replace)

## Create sample file
```bash
cat > sed_example.txt
unix is great os. unix is opensource. unix is free os.
learn operating system.
unix linux which one you choose.
unix is easy to learn.unix is a multiuser os.Learn unix .unix is a powerful.

```

```bash
cat > sed_examle2.txt
Hello World!
This is a test file
Computer Science is fun!
```

1. find and replace
    ```bash
    sed 's/Hello/Goodbye/' testfile
    ```
2. In-place file editing
    **Without backup**
    ```bash
    cat > fruits.txt
    banana
    papaya
    mango
    ```
    ```bash
    sed -i 's/an/AN/g' fruits.txt
    cat fruits.txt
    ```
    **With Backup**
    ```bash
    cat > colors.txt
    deep blue
    light orange
    blue delight
    ```
    ```bash
    sed -i.bkp 's/blue/green/' colors.txt
    ```
    ```bash
    cat colors.txt.bkp
    ```
    **Multiple files**
    ```bash
    cat > f1.txt
    have a nice day
    bad morning

    cat > f2.txt
    worse than ever
    too bad
    ```
    ```bash
    sed -i.bkp 's/bad/good/' f1.txt f2.txt
    ```
    **Prefix backup name**
    ```bash
    sed -i'bkp.*' 's/green/yellow/' colors.txt
    ```
    **Place backups in a different directory**
    ```bash
    mkdir backups
    sed -i'backups/*' 's/good/nice/' f1.txt f2.txt
    ```
3. Reading Lines
    ```bash
    cat > lyrics.txt
    Thundercats are on the move
    Thundercats are loose
    Feel the magic, hear the roar
    Thundercats are loose
    Thunder, thunder, thunder, Thundercats
    Thunder, thunder, thunder, Thundercats
    Thunder, thunder, thunder, Thundercats
    Thunder, thunder, thunder, Thundercats!
    Thundercats!
    ```
    1. Printing only lines 5-8 of lyrics.txt
    ```bash
    sed -n '10p' lyrics.txt # Print only one line
    sed -n '5,8p' lyrics.txt
    sed -n '5,+3p' lyrics.txt
    ```
    2. Deleting lines
    ```bash
    sed '5,8d' lyrics.txt
    sed '5,+3d' lyrics.txt
    ```
    3. delete lines that contain specific patterns
    ```bash
    sed '/thunder/ d' lyrics.txt 
    ```
    4. run multiple commands at the same time
    ```bash
    sed -e '/thunder/ d' -e '/magic/ d' lyrics.txt  
    ```
    ```bash
    sed '
    /thunder/ d;
    /magic/ d
    ' lyrics.txt
    ```
    ```bash
    sed '/thunder/ d; /magic/ d' lyrics.txt
    ```
    5. display only the lines we changed
    ```bash
    sed -n '
    s/thunder/lightning/gp;
    s/Thunder,/Lightning,/gp
    ' lyrics.txt
    ```

## Real world journey
https://github.com/Anant/example-introduction-to-sed/blob/main/spacecraft_journey_catalog.csv
    
    ```bash
    sed 's/^,/Missing Summary,/' spacecraft_journey_catalog.csv > updated_items.csv
    ```
    ```bash
    sed '/^,/ d' spacecraft_journey_catalog.csv > removed_items.csv
    ```
4. append, change, insert
    **Basic Usage**
    * **a** appends the given string after the end of line for each matching address
    * **c** changes the entire matching address contents to the given string
    * **i** inserts the given string before the start of line for each matching address
    ```bash
        cat > file.txt
        # start
        This line is between the start and end keywords.
        Hello foo!!!
        Hello bar
        # end

        # End of file.txt

    ```
    ```bash
    sed '10p;5i\"INSERTED BEFORE LINE 5" file.txt 
    ```
5.  replacement on all lines except line 5
    ```bash
    sed '5!/s/foo/bar/' file.txt
    ```
6. Remove comments between lines starting with these two keywords. Empty lines will be put there instead
    ```bash
    sed -E '/start/,/end/ s/#.*//' file.txt 
    ```
7. Delete comments starting with # (no empty lines left behind)
    ```bash
    sed -E '/^#/d' f1
    ```
8. Insert an empty line after pattern (after each line containing comment in this case)
    ```bash
    sed '/^#/G' file.txt 
    ```
9. View lines minus lines between line starting with pattern and end of file
    ```bash
    sed  '/start/,$ d' file.txt 
    ```
10. View lines except lines between line starting with pattern and line ending with pattern
    ```bash
    sed -rn '/start/,/end/ !p' file.txt 
    ```
11. Print until you encounter pattern then quit
    ```bash
    sed  '/start/q' file.txt 
    ```
12. Insert contents of file after a certain line
    ```bash
    sed  '5 r newfile.txt' file.txt 
    ```
13. Append text after lines containing regex (AFTER FOO)
    ```bash
    sed '/foo/a\AFTER FOO' file.txt 
    ```
14. Insert text after lines containing regex (BEFORE FOO)
    ```bash
    sed '/foo/i\BEFORE FOO' file.txt 
    ```
15. Change line containing regex match
    ```bash
    sed '/foo/c\FOO IS CHANGED' file.txt 
    ```

## AWK Example
[Example files](https://github.com/learnbyexample/learn_gnuawk/tree/master/example_files)
1. Input record separator
    ```bash
    printf 'this,is\na,sample,text' | awk -v RS=, '{print NR ")", $0}'
    ```
2. String anchor and sub built in function
    ```bash
    printf 'spared no one\npar\nspar\n' | awk '{sub(/^spar$/, "123")} 1'
    ```
3. OFS
    ```bash
    echo 'goal:amazing:whistle:kwality' | awk -F: -v OFS=: '{print $2, $NF}'
    echo 'goal:amazing:whistle:kwality' | awk 'BEGIN{FS=OFS=":"} {print $2, $NF}'
    ```
4. Changing field content
    ```bash
    echo 'goal:amazing:whistle:kwality' | awk -F: -v OFS=: '{$2 = 42} 1'
    echo 'goal:amazing:whistle:kwality' | awk -F: -v OFS=, '{$2 = 42} 1'
    ```
5. assign a field value to itself to force the reconstruction of $0
    ```bash
    echo 'Sample123string42with777numbers' | awk -F'[0-9]+' -v OFS=, '1'
    echo 'Sample123string42with777numbers' | awk -F'[0-9]+' -v OFS=, '{$1=$1} 1'
    ```
6. In place file editing
    1. Without backup
        ```bash
        cat > greet.txt
        Hi there
        Have a nice day
        Good bye
        awk -i inplace '{print NR ". " $0}' greet.txt
        ```

        ```bash
        cat > f1.txt
        I ate 3 apples
        cat > f2.txt
        I bought two balls and 3 bats

        awk -i inplace '{gsub(/\<3\>/, "three")} 1' f1.txt f2.txt

        ```
    2. With backup
        ```bash
        cat > f3.txt
         Name    Physics  Maths
        Moe  76  82
        Raj  56  64
        awk -i inplace -v inplace::suffix='.bkp' -v OFS=, '{$1=$1} 1' f3.txt
        ```

7. Using shell variables
    ```bash
    s='cake'
    awk -v word="$s" '$2==word' table.txt
    ```
8. Shell environment
    ```bash
    awk 'BEGIN{print ENVIRON["HOME"]}'
    ```
9. Control Structures
    1. if-else
        ```bash
        awk '/^b/{print; if($NF>0) print "------"}' table.txt
        awk '/^b/{print; if($NF>0) print "------"; else print "======"}' table.txt
        ```
    2. loops
        ```bash
        awk 'BEGIN{for(i=2; i<7; i+=2) print i}'
        awk -v OFS=, '{for(i=1; i<=NF; i++) if($i ~ /^[bm]/) $i="["$i"]"} 1' table.txt
        awk 'NR>1{d[$1]+=$3; c[$1]++} END{for(k in d) print k, d[k]/c[k]}' marks.txt
        ```
10. Built-in functions
    1. length
        ```bash
        awk 'BEGIN{print length("road"); print length(123456)}'
        awk 'length($1) < 6' table.txt
        ```
    2. split
        ```bash
        s='Joe,1996-10-25,64,78'
        echo "$s" | awk -F, '{split($2, d, "-"); print $1 " was born in " d[1]}'
        s='air,water,12:42:3'
        echo "$s" | awk -F, '{n=split($NF, a, ":");
                       for(i=1; i<=n; i++) print $1, $2, a[i]}'
        ```
    3. substr
        ```bash
        echo 'abcdefghij' | awk '{print substr($0, 1, 5)}'
        echo 'abcdefghij' | awk -v OFS=: '{print substr($0, 2, 3), substr($0, 6, 3)}'
        ```
    4. match
        ```bash
        s='051 035 154 12 26 98234 3'
        echo "$s" | awk 'match($0, /[0-9]{4,}/){print substr($0, RSTART, RLENGTH)}'
        ```

## Example with BEGIN and END 
```bash
awk 'BEGIN {
    sum = 0
}

{
    # Process each line
    for (i = 1; i <= NF; i++) {
        # Assuming the fields are numbers
        sum += $i
    }
}

END {
    # Actions to be performed after processing all lines
    print "Sum of Numbers:", sum
}' numbers.txt
```

```bash
awk 'BEGIN {
    # Initialize variables and categories
    count_low = 0
    count_medium = 0
    count_high = 0
}

{
    # Process each line
    for (i = 1; i <= NF; i++) {
        # Assuming the fields are numbers
        value = $i

        # Categorize into different ranges
        if (value < 50) {
            count_low++
        } else if (value >= 50 && value < 100) {
            count_medium++
        } else {
            count_high++
        }
    }
}

END {
    # Actions to be performed after processing all lines
    print "Number of values in different ranges:"
    print "Low (less than 50):", count_low
    print "Medium (50 to 99):", count_medium
    print "High (100 and above):", count_high
}' numbers.txt

```
```bash
cat > number.txt
25 72 48 95 102
60 35 80 110 45
90 55 75 40 105

```






## Let's check one awk game
```bash
https://github.com/TheMozg/awk-raycaster/tree/master
gawk -f awkaster.awk

```
