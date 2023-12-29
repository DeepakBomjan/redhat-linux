# Parameter Expansion with ${} in Bash
1. Basic Parameter Expansion
    ```bash
    name="John Doe"
    echo "Hello, ${name}!"
    ```
2. Default Value Expansion
    ```bash
    greeting=${name:-"World"}
    echo "Hello, ${greeting}!"
    ```
3. Assign Default Value
    ```bash
    : {count:=0}
    echo "Current count: ${count}"
    ```
4. Error if Unset or Null
    To raise an error if a variable is not set or is null, use the **${variable:?error_message}** syntax
    ```bash
    echo "Hello, ${name:?Name is not set}!"
    ```
5. String Length Expansion
    ```bash
    name="John Doe"
    echo "Name length: ${#name}"
    ```
6. Substring Expansion
    **{variable:offset:length}**
    ```
    name="John Doe"
    echo "First name: ${name:0:4}"
    ```
7. Substring Removal
    * Remove the shortest matching prefix pattern: {variable#pattern}
    * Remove the longest matching prefix pattern: ${variable##pattern}
    * Remove the shortest matching suffix pattern: ${variable%pattern}
    * Remove the longest matching suffix pattern: ${variable%%pattern}
    ```bash
    filename="document.txt"
    echo "Without extension: ${filename%.*}"
    ```
8. Search and Replace
    **${variable//pattern/replacement}**
    ```bash
    text="The rain in Spain falls mainly on the plain."
    echo "Replace 'rain' with 'sun': {text/rain/sun}"
    echo "Replace all 'ain': ${text//ain/ane}"
    ```
9. Case Modification
    * Convert the first character to uppercase: {variable^}
    * Convert the first character to lowercase: ${variable,}
    * Convert all characters to uppercase: ${variable^^}
    * Convert all characters to lowercase: ${variable,,}
    ```bash
    text="The Rain in Spain"
    echo "First character uppercase: {text^}"
    echo "First character lowercase: ${text,}"
    echo "All characters uppercase: ${text^^}"
    echo "All characters lowercase: ${text,,}"
    ```
10. Indirect Reference
    ```bash
    name_var="name"
    name="John Doe"
    echo "Indirect reference: ${!name_var}"
    ```
