---
aliases: 
draft: false
tags:
  - computerscience
  - textbook
  - syntax
title: CPL - Chapter 6
date: 2025-03-08
updated: 2025-03-09T11:48
---

-------------------------------------------------------------------------------

# Data Types

What is a data type? *Data types* are a collection of data values and set of pre-defined operations on those values. One major benefit of data typing is error catching. Another is documentation; we can tell a lot about about a program based on it's data types and types used.

The two most common structured (non-scalar) data types are arrays and records. Structured data types defined w/ type operators, or constructors (C uses brackets for arrays, asterisks for pointers). *Descriptors* are the collection of the attributes of a variable.

## Primitive Data Types

Data types that are not defined in terms of other types. 

- **Numeric Types**:
	- Integers: Different languages have different types, some common are; `short`, `byte`, `int`, `long`
	- Floating-point: Models real numbers, but representations are only approximations for many real values; `float` or `doubles`
	- Complex: Ordered pairs of floating-point values
	- Decimal: Mostly for larger computers designed to support business system applications; stores a fixed number of decimal digits, with the decimal point being fixed position in the value
- **Boolean Types**:
	- Simplest of all types; one value for True, one for False, typically stored in a byte
- **Character Types**:
	- Stored usually as numeric coding. Common coding's are 8-bit or ASCII

## Character String Types

A data type in which the values consist of sequences of characters. These have some inherent design issues;

1. Should strings be a special kind of character array or a primitive type?
2. Should strings have static or dynamic length?

### Strings and Their Operators

Most common operations are assignment, concatenation, sub-string reference, comparison, & pattern matching. The *sub-string reference* is simply a reference to a sub-string of a given string.

If strings are not defined as a primitive type, strings are usually stored in arrays of single characters.

- C & C++ use `char` arrays
	- `char str[] = 'apples';`
		- Equal to `apples0` where 0 is the null character that stops the list from being read past the characters

### String Length Options

Three main options:

1. **Static Length String**:
	1. The length can be static, set when the string is created. Such is the case for Python, Java, C++ Classes, etc.
		1. Descriptor:
			1. Static String (name of type)
			2. Length
			3. Address (of first character)
2. **Limited Dynamic Length Strings**:
	1. To allow strings to have varying length up to a declared and fixed maximum set by the variables definition
		1. Descriptor
			1. Limited Dynamic String
			2. Max length
			3. Current length
			4. Address
3. **Dynamic Length Strings**:
	1. To allow strings to have varying length with no maximum. This is the case for JavaScript, Perl, and standard C++ libraries

Dealing with strings as arrays is overall more cumbersome than a primitive string type.

## Enumeration Types

One in which all possible values, which are named constants, are provided, or enumerated, in the definition.

```C#
enum days {Mon, Tue, Wed, Thu, Fri, Sat, Sun}
```

There are some inherent design issues;

1. Is an enumeration constant allowed to appear in more than one type definition, and if so, how is the type of an occurrence of that constant in the program checked?
2. Are enumeration values coerced to integer?
3. Are any other types coerced to an enumeration type?

***All the above are type checking issues***.

For languages without enumeration types, we can use int values; `{red = 0; blue = 1;}`

### C++

```c++
enum colors {red, blue, green, yellow, black};
colors MyColor = blue, yourColor = red;
```

Because enumeration types evaluate to an integer value, they can be used in mathematical operations.

```C++
myColor++; // Setzs myColor to green from blue

myColor = 4;  // Illegal in C++
```
