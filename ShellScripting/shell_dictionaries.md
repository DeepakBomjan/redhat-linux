# Bash Arrays and Associative Arrays Tutorial

```bash
# Bash Arrays and Associative Arrays Tutorial

## Arrays

### Declaration and Initialization:

You can declare and initialize arrays in Bash in different ways:

```bash
# Method 1
my_array=("value1" "value2" "value3")

# Method 2
my_array[0]="value1"
my_array[1]="value2"
my_array[2]="value3"
```
## Accessing Array Elements:
```bash
echo ${my_array[0]}  # prints "value1"
echo ${my_array[1]}  # prints "value2"
echo ${my_array[2]}  # prints "value3"

```
## Array Length:
Find the length of an array using the # symbol:
```bash
echo ${#my_array[@]}  # prints the number of elements in the array

```
## Iterating Through Array Elements:
Use a **for** loop to iterate through all elements in the array:
```bash
for element in "${my_array[@]}"; do
  echo $element
done

```
## Adding Elements to an Array:
dd elements using the **+=** operator:
```bash
my_array+=( "new_value1" "new_value2" )
```
## Removing Elements from an Array:
Unset specific elements using the **unset** command:
```bash
unset my_array[1]  # removes the element at index 1
```

# Associative Arrays (Dictionaries)

## Declaration and Initialization
```bash
# Declare an associative array
declare -A my_dict

# Initialize the associative array with key-value pairs
my_dict=([key1]="value1" [key2]="value2" [key3]="value3")

```

## Accessing Dictionary Elements:
You can access individual elements using their keys:
```bash
echo ${my_dict[key1]}  # prints "value1"
echo ${my_dict[key2]}  # prints "value2"
echo ${my_dict[key3]}  # prints "value3"

```
## Dictionary Length:
```bash
echo ${#my_dict[@]}  # prints the number of elements in the dictionary
```
## Iterating Through Dictionary Elements:
```bash
for key in "${!my_dict[@]}"; do
  echo "Key: $key, Value: ${my_dict[$key]}"
done
```
## Adding and Updating Elements:
```bash
my_dict[key4]="value4"  # adds a new key-value pair
my_dict[key2]="new_value2"  # updates the value for an existing key
```
## Removing Elements:
```bash
unset my_dict[key3]  # removes the key-value pair with key "key3"
```
## Example Script:
Here's a simple script that demonstrates the above concepts:
```bash
#!/bin/bash

# Declare and initialize an associative array
declare -A my_dict
my_dict=([name]="John" [age]=25 [city]="New York")

echo "Original Dictionary:"
for key in "${!my_dict[@]}"; do
  echo "Key: $key, Value: ${my_dict[$key]}"
done

echo "Dictionary Length: ${#my_dict[@]}"

echo "Adding Element:"
my_dict[occupation]="Engineer"

echo "Updated Dictionary:"
for key in "${!my_dict[@]}"; do
  echo "Key: $key, Value: ${my_dict[$key]}"
done

echo "Removing Element:"
unset my_dict[age]

echo "Updated Dictionary:"
for key in "${!my_dict[@]}"; do
  echo "Key: $key, Value: ${my_dict[$key]}"
done
```
