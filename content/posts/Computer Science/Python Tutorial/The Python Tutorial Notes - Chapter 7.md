---
aliases:
  - python
draft: false
tags:
  - computerscience
  - python
  - documentation
  - input
  - output
title: The Python Tutorial Notes - Chapter 7
date: 2024-06-17
---
Modified: July 19 2024 

-------------------------------------------------------------------------------

## **Input and Output**

6/18/2024
   
There are three main ways to present output in Python; expression statements (not using `print()`), using `print()`, and using `write()` which writes something into an existing or new file. 

### **7.1 Fancier Output Formatting**

At any point in the command line, I can just send out some text without any `print()` commands and get back what I just sent in. That's an expression statement. Not super important.

The more important would be things we can do with `print()`, that we can also do with expression statements (but we don't care about those).

We can use formatted string literals: 

```python
>>> year = 2024
>>> print(f'The year is {year}')
The year is 2024
```

We can also use the `str.format()` method:

```python
>>> yes_votes = 42_572_654
>>> total_votes = 85_705_149
>>> percentage = yes_votes / total_votes
>>> '{:-9} YES votes {:2.2%}'.format(yes_votes, percentage)
' 42572654 YES votes  49.67%'
```

The spacing in the example is very deliberate; aside from using `str.format()`, we're using some format specification. You can mess around and play with the numbers to change the padding (space between objects) and the percentage.

`repr()` sends out the full context of what a string is made up of:

```python
>>> hello = 'world'
>>> print(hello)
'world'
>>> repr(hello)
"'world'"
>>> hello = "world\n."
>>> print(hello)
'world
.'
>>> repr(hello)
"'world\n.'"
```


**Formatted string literals** let you include Python expressions inside a string by including `f` or `F`. 
If you place an integer after `:` will cause that output to be a minimum number of characters wide. This is helpful for formatting columns.

You can apply other modifiers after that will convert the value before formatted. `!a` can apply `ascii()`, and `!r` applies `repr()`. An equal sign expands the expression to include the variable name. 

```python
>>> animals = 'eels'
>>> print(f'This car is full of {animals!r}.')
This car is full of 'eels'.
>>> print(f'Amounts: {animals=}')
Amounts: animals=eels
```


**The `str.format()` method** can be used with nothing in them, an index representation for how they appear in your call, and by keywords (you can also combine them).

```python
>>> print('{} {} DOOM'.format('Metal', 'Face'))
Metal Face DOOM
>>> print('{0} {1} DOOM'.format('Metal', 'Face'))
Metal Face DOOM
>>> print('{1} {0} DOOM'.format('Metal', 'Face'))
Face Metal DOOM

>>> print('The {noun} is so {adjective},'.format(noun="beat", adjective="butter"))
The beat is so butter,
```

If you have a really long formatted string you don't want to break apart, you can pass a dict and using square brackets to access keys.

I thought this stuff might not be that important, but than I considered the memory factor. I compared looping over the table with a for loop, compared to just outputting them in a longer string format.

```python
import time  
import sys  
  
table = {  
    'MF DOOM': 10,  
    'KING GHEEDORAH': 5,  
    'MADVILLIAN': 7  
}  
  
# Method 1: using str.format()  
start_time = time.perf_counter()  
formatted_string = 'MF DOOM: {0[MF DOOM]:d}; KING GHEEDORAH: {0[KING GHEEDORAH]:d}; MADVILLIAN: {0[MADVILLIAN]:d}'.format(table)  
print(formatted_string)  
end_time = time.perf_counter()  
method_1_time = end_time - start_time  
method_1_space = sys.getsizeof(formatted_string)  
  
  
# Method 2: using f-string in a loop  
start_time = time.perf_counter()  
formatted_strings = [f'{i}: {j}' for i, j in table.items()]  
for s in formatted_strings:  
    print(s, end=' ')  
end_time = time.perf_counter()  
method_2_time = end_time - start_time  
method_2_space = sum(sys.getsizeof(s) for s in formatted_strings)  
  
# Output  
print(f'\nMethod 1 time: {method_1_time:.4f}; Method 2 time: {method_2_time:.4f}')  
print(f'Method 1 space: {method_1_space}; Method 2 space: {method_2_space:.4f}')
```

The metrics came out pretty expected: no visible difference in time, but the space of method 2 was twice the size. Maybe not the best way to test it, but I just asked AI how they would do it and this was their response. 

I like this example they give on how to nicely format some columns:

```python
>>> for x in range(1, 11):
>>> 	print('{0:2d} {1:3d} {2:4d}'.format(x, x*x, x*x*x))
 1   1    1
 2   4    8
 3   9   27
 4  16   64
 5  25  125
 6  36  216
 7  49  343
 8  64  512
 9  81  729
10 100 1000
```

6/20/2024

### **7.2 Reading and Writing Files**

Using `open()` will return a file object, commonly used with two positional arguments and one keyword argument; `open(filename, mode, encoding=None)`

```python
>>> f = open('workfile', 'w', encoding='utf-8')
```

The first argument, obviously, is the filename. You could also use a path to get there if not local. 

The second, mode, determines the way `open()` is connecting to the file.
- `r` is for when the file is only to be read (the default if mode isn't in use)
- `w` is for writing only (any existing file of the same name will be erased)
- `a` opens the file for appending (adding data to the end of the file)
- `r+` opens the file for both reading and writing
- `b` opens the file in binary; encoding does not work with this

Most encoding will be done in UTF-8, so unless otherwise specified, that's what we'll use.

It's good practice to use `with` when dealing with files, so the file is properly closed when done being used.

```python
with open('workfile', encoding='utf-8') as f:
	read_data = f.read()
```

If you're not using `with`, you'll have to call `f.close()` in order to close the file and free up memory.

**Methods of File Objects**

Assuming `f` is a file we are working with:

- `f.read()`: reads some quantity of data and returns it as a string for text mode, and a bytes object for binary mode. *Size* is an optional argument to determine how much to read. If at the last line/end of file, an empty string will be returned instead. 
- `f.readline()`: reads only a single line from the file. All lines end with a `\n` except for the last line; a nice convention for us to determine if it's the end of the file or a new line. 
- `f.readlines()`: returns all lines in a file as a list
- `f.write(string)`: writes the contents of *string* into the file. Also returns the number of characters written.
- `f.tell()`: returns an integer giving the file object's current position in the file
- `f.seek(offset, whence)`: To change an object's position; position computed by adding offset to a reference point set by whence. 0 measures from the beginning of the file, 1 is the current position, and 2 uses the end of the file as a reference point. 

```python
>>> f.read()
'This is the entire file.\n'
>>> f.read()
''

>>> f.readline()
'This is the first line of the file.\n'
>>> f.readline()
'Second line of the file\n'
>>> f.readline()
''

# for when reading lines from a file
>>> for line in f:
>>> 	print(line, end=' ')
This is the first line of the file.
Second line of the file

>>> f.write('This is a test\n')
15
```

You can also save structured data with JSON (JavaScript Object Notation). Because you can only read and write strings, numbers are difficult to process. 

The module `json` can take Python structures and convert them into string representations, aka **Serializing**. The opposite, reconstructing data from the string representation is **Deserializing**.

```python
>>> import json
>>> x = [1, 'stupid', 'list']
>>> json.dumps(x)
'[1, "stupid", "list"]'

# or, we could use dump() to serialize to a text file, f
>>> json.dump(x, f)

# and to decode back
>>> x = json.load(f)
```



-------------------------------------------------------------------------------
Next: 
[Chapter 8]({{< ref "The Python Tutorial Notes - Chapter 8" >}})                             
