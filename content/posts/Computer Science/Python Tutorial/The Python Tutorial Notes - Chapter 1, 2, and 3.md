---
aliases:
  - python
draft: true
tags:
  - computerscience
  - python
  - documentation
  - syntax
  - datatypes
  - formatting
title: The Python Tutorial Notes - Chapter 1, 2, and 3
date: 2024-06-02
---
Modified: July 19 2024 

[Link to source](https://docs.python.org/3/tutorial/index.html)

-------------------------------------------------------------------------------

6/2/2024

In order to get a better understanding of Python as a whole language, I'm going to document and take notes as I go through the tutorial. I mostly would like to improve as a programmer, and eventually get a software job at Google or something.

## **Introduction**  
  
What is Python?   
 1. Python is an easy to learn, powerful programming language. Featuring efficient high-level data structures as well as a simple but effective approach to object-oriented programming. 
 2. Ideal language for scripting and rapid application development

Description of objects and modules are in [The Python Standard Library](https://docs.python.org/3/library/index.html#library-index). I'll probably go through this another day.

Same goes for [The Python Language Reference](https://docs.python.org/3/reference/index.html#reference-index). This goes over the syntax are "core semantics" of the language.

[Python's Glossary](https://docs.python.org/3/glossary.html#glossary) 

## **1. Whetting Your Appetite**

Python is a language well suited for small, quick, and useful applications

Python is an interpreted language - saving time during program development due to not needing compilation and linking. 

Python enables programs to be written compactly and are easily readable; python programs are usually shorter than C++/Java programs for three main reasons:
1. High-level data types allow you to express complex operations in single statements
2. Statement grouping is done by indentation rather than beginning/end brackets
3. No variable or argument declarations are necessary


## **2. Using the Python Interpreter**

### 2.1 Invoking the Interpreter
Usually, when installed correctly, you can open up a shell/command line and run;

```python
python3.12
```
or
```python
py
```

You can stop typing at anytime using ctrl-z or `quit()`.

Arguments are passed using square-bracket list format: turned into strings and saved as `argv` variable in the sys module.

Interactive mode is the feature that lets you continue to write long statements on the command line, usually denoted by ellipses instead of the usual three greater than signs.

### 2.2 The Interpreter and Its Environment

Python source files are treated as encoded in UTF-8, where characters of most languages in the world can be used in string literals, identifies, and comments; the standard library only uses ASCII characters for identifies.

To declare an encoding besides default, use

```python
# -*- coding: encoding -*-
```

where *encoding* is a valid [codec](https://docs.python.org/3/library/codecs.html#module-codecs) supported by Python.

## **3. An Informal Introduction to Python**

Comments are left usually with '#';

```python
# This is my super awesome comment
```

Number calculations are a breeze with Python. By default, Python acts as a standard calculator, following basic rules of arithmetic (PEMDAS, etc.)

```python
2 + 2

50 - 5 * 6

(50 - 5 * 6) / 4

8 / 5  # division always returns a floating point number

8 // 5 # integer division truncates decimal *does not round up*
```


Modular division calculates the remainder of a division problem. 

```python
17 % 3 # equals 2
```

Mod anything by 2, and you'll get either 0 or 1-even or odd respectively. 

Powers are shown with double star:

```python
5 ** 2
```

Data in Python is stored and separated into different data types. The most basic are **int** or integer data types (whole numbers), **float** or decimal point numbers, **str** or strings which hold anything in-between two quotation marks, and **bool** or Booleans, which return true or false.  

The equal sign is known as the assignment operator. It is used to place values into named, identifiable spaces to be called on later. 

```python
width = 20
height = 5 * 9
width * height # returns 900
```

Variables must be assigned some value before being called/used.

Expressions with mixed types (including floats) will return floats.

In interactive mode, `_` acts as the last produced value.

Python also supports **Decimal**, **Fraction**, and **complex numbers**.

Strings can be used with single or double quotes, with the backslash acting as an escape character.

In regular Python shell commands, the output doesn't account for any backslashes. The `print()` command will accomplish that

```python
>>> s = 'First line.\nSecond line.'  # \n means newline
>>> s  # without print(), special characters are included in the string
'First line.\nSecond line.'
>>> print(s)  # with print(), special characters are interpreted, so \n produces new line
First line.
Second line.
```

Placing `r` before a string will output it as *raw* strings; special characters aren't account for.

```python
>>> print('C:\some\name')
C:\some
ame
>>> print(r'C:\some\name')
C:\some\name
```

Strings can also take up more than one line using the triple quotation mark notation: `"""..."""` 

Strings can be concatenated using the `+` operator, and repeated with the `*` operator.

```python
>>> 3 * 'hi' + ' there'
'hihihi there'

>>> prefix = 'Py'
>>> prefix + 'thon'
'Python'
```

Strings can be indexed, starting at 0 and the last character represented as -1:

```python
>>> word = "Hello world!"
>>> word[0]
'H'
>>>word[-1]
'!'
```

Slicing is also supported:

```python
>>> word[:2] # characters from beginning to position 2 (excluding)
'He'
>>> word [2:] # characters from position 2 (included) to the end
'llo world!'
>>> word[-2:] # characters from second to last position (including) to the end
'd!'
```

Here is a useful diagram to think about how index positions work in Python:

```python
 +---+---+---+---+---+---+
 | P | y | t | h | o | n |
 +---+---+---+---+---+---+
 0   1   2   3   4   5   6
-6  -5  -4  -3  -2  -1
```

Python strings are immutable, meaning they cannot be changed at the index level. You cannot reassign individual or sliced portions of a string. You can either make a new one or reassign the entire string's value at once.

The built-in function `len()` returns the length of a string.

All methods for strings can be found [here](https://docs.python.org/3/library/stdtypes.html#string-methods).

Python has multiple *compound* data types that hold values together. The most versatile is a *list*, which is commonly written as a group of elements separated by a comma surrounded by square brackets. 

*Lists* can hold many different data types, but is usually confined to just one.

```python
>>> squares = [1, 4, 9, 16, 25]
>>> squares
[1, 4, 9, 16, 25]
```

Like strings, lists can be indexed and sliced, as well as concatenated, and are fully mutable, meaning we can change the list at exact locations. 

You can add items to the end of the list using the `.append()` method:

```python
>>> squares.append(36)
>>> squares.append(7 ** 2)
>>> squares
[1, 4, 9, 16, 25, 36, 45]
```

Simple assignment doesn't copy data; when you assign a list to a variable, the variable refers to the existing list. Any changes made to a list through one variable is seen through all other variables that refer to that same list.

```python
>>> rgb = ["Red", "Green", "Blue"]
>>> rgba = rgb
>>> id(rgb) == id(rgba) #checking to see if they reference the same object
True
>>> rgba.append("Alph")
>>> rgb
["Red", "Green", "Blue", "Alph"]
```

Slices can also be reassigned. `len()` also applies to lists, counting the number of elements inside the list.

Nested lists are also possible:

```python
>>> a = ['A', 'B', 'C']
>>> a_low = ['a', 'b', 'c']
>>> x = [a, a_low]
>>> x
 ['A', 'B', 'C'], ['a', 'b', 'c']
>>> x[0]
['A', 'B', 'C']
>>> x[0][1]
B
```

Next Steps: We can create a Fibonacci sequence.

Fibonacci Sequence: a sequence in which each number is the sum of the two preceding ones. Numbers that are part of this sequence are known as Fibonacci numbers. 

I first tried making a Fibonacci sequence from scratch, but I failed to understand how the assignment should work so that a and b are updated without adding the wrong values. [I used ChatGPT to help facilitate my error](https://chatgpt.com/share/f43b22f2-7f7f-41bd-881f-72fc7ad92d25).

-------------------------------------------------------------------------------
Next: 
[Chapter 4]({{< ref "The Python Tutorial Notes - Chapter 4" >}})
