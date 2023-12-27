
## Shell parameter expansion
Shell parameter expansion provides a way to manipulate the values of variables in various ways. Here's an example of shell parameter expansion:

### Example 1
```bash
#!/bin/bash

# Example variables
name="John"
age=25

# Basic parameter expansion
echo "Name: $name"
echo "Age: $age"
echo "--------------------------"

# String length
echo "Length of name: ${#name}"
echo "Length of age: ${#age}"
echo "--------------------------"

# Substring
echo "First three characters of name: ${name:0:3}"
echo "Last two characters of age: ${age: -2}"
echo "--------------------------"

# Default value if variable is unset or null
unset city
echo "City: ${city:-Unknown}"
echo "--------------------------"

# Use default value if variable is unset, null, or empty
unset country
echo "Country: ${country:=USA}"
echo "Country after setting a value: $country"
echo "--------------------------"

# Replace substring
sentence="I love programming in Bash"
echo "Original sentence: $sentence"
echo "After replacing 'Bash' with 'Shell': ${sentence/Bash/Shell}"
echo "--------------------------"

# Remove matching prefix
filename="example.txt"
echo "Original filename: $filename"
echo "After removing 'example.': ${filename#example.}"
echo "--------------------------"

# Remove matching suffix
filename="example.txt"
echo "Original filename: $filename"
echo "After removing '.txt': ${filename%.txt}"
echo "--------------------------"

```
* Basic parameter expansion is used to print the values of variables.
* ${#variable} is used to get the length of a string.
* ${variable:start:length} is used to extract a substring.
* ${variable:-default} provides a default value if the variable is unset or null.
* ${variable:=default} sets a default value if the variable is unset, null, or empty.
* ${variable/substring/replacement} is used to replace a substring.
* ${variable#prefix} removes a matching prefix.
* ${variable%suffix} removes a matching suffix.

### Example 2

```bash
#!/bin/bash

# Example variables
name="Alice"
greeting="Hello, $name!"

# Uppercase and lowercase conversion
echo "Uppercase: ${name^^}"
echo "Lowercase: ${name,,}"
echo "--------------------------"

# Default value with command substitution
unset city
echo "City: ${city:-$(hostname)}"
echo "--------------------------"

# Default value with arithmetic expression
unset count
echo "Count: $((count:=10))"
echo "Count after setting a value: $count"
echo "--------------------------"

# Use default value if variable is unset or null (alternative syntax)
unset country
echo "Country: ${country=USA}"
echo "Country after setting a value: $country"
echo "--------------------------"

# Pattern matching and removal
sentence="The quick brown fox jumps over the lazy dog"
echo "Original sentence: $sentence"

# Remove shortest match from the beginning
echo "After removing 'The ': ${sentence#*The }"

# Remove longest match from the beginning
echo "After removing 'The ': ${sentence##*The }"
echo "--------------------------"

# Remove shortest match from the end
echo "After removing 'dog': ${sentence% dog}"

# Remove longest match from the end
echo "After removing 'dog': ${sentence%% dog}"
echo "--------------------------"

# Length of an array
fruits=("Apple" "Banana" "Cherry")
echo "Number of fruits: ${#fruits[@]}"
echo "Length of the second fruit: ${#fruits[1]}"
echo "--------------------------"

# Indirect reference
var_name="greeting"
echo "Greeting: ${!var_name}"
echo "--------------------------"

# Parameter length in bytes
text="Hello, world!"
echo "Length of text in bytes: ${#text}"
echo "--------------------------"

```

Certainly! Here are some additional examples of shell parameter expansion:

bash
Copy code
#!/bin/bash

# Example variables
name="Alice"
greeting="Hello, $name!"

# Uppercase and lowercase conversion
echo "Uppercase: ${name^^}"
echo "Lowercase: ${name,,}"
echo "--------------------------"

# Default value with command substitution
unset city
echo "City: ${city:-$(hostname)}"
echo "--------------------------"

# Default value with arithmetic expression
unset count
echo "Count: $((count:=10))"
echo "Count after setting a value: $count"
echo "--------------------------"

# Use default value if variable is unset or null (alternative syntax)
unset country
echo "Country: ${country=USA}"
echo "Country after setting a value: $country"
echo "--------------------------"

# Pattern matching and removal
sentence="The quick brown fox jumps over the lazy dog"
echo "Original sentence: $sentence"

# Remove shortest match from the beginning
echo "After removing 'The ': ${sentence#*The }"

# Remove longest match from the beginning
echo "After removing 'The ': ${sentence##*The }"
echo "--------------------------"

# Remove shortest match from the end
echo "After removing 'dog': ${sentence% dog}"

# Remove longest match from the end
echo "After removing 'dog': ${sentence%% dog}"
echo "--------------------------"

# Length of an array
fruits=("Apple" "Banana" "Cherry")
echo "Number of fruits: ${#fruits[@]}"
echo "Length of the second fruit: ${#fruits[1]}"
echo "--------------------------"

# Indirect reference
var_name="greeting"
echo "Greeting: ${!var_name}"
echo "--------------------------"

# Parameter length in bytes
text="Hello, world!"
echo "Length of text in bytes: ${#text}"
echo "--------------------------"
In this script:

* ${variable^^} converts the value to uppercase.
* ${variable,,} converts the value to lowercase.
* ${variable:-$(command)} provides a default value using command substitution.
* ${variable:=expression} sets a default value using an arithmetic expression.
* ${!var_name} is used for indirect reference.
* ${#array[@]} gives the length of an array.
* ${#array[index]} gives the length of a specific element in the array.
* ${#text} gives the length of a string in bytes.