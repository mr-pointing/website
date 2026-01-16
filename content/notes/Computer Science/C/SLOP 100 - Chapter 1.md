---
aliases:
draft: false
tags:
  - computerscience
  - c
  - syntax
title: Chapter 1 - Variables
date: 2025-12-23
updated: 2026-01-05T19:13
---

-------------------------------------------------------------------------------

# Variables

C supports variables with type declaration.

```c
#include <stdio.h>

int main() {
	int year = 2026;
	
	printf("This is the year %i", year);
	
	return 0;
}
```

In the above example, the variable `year` is placed into a function `printf`, but has to specify which type of variable is going to take the that space, which is where the 
`%i` comes in.

Writing a variable follows this syntax,

```c
datattype variablename = value;
```

C is statically typed, which means datatypes are checked at compile time, data types inform the compiler on how to interpret and operate on the data, and lets the compiler know how much memory is needed for that data.

Naming allows letters, numbers, underscore, cannot start with digits, and are case sensitive. No use of reserved words is possible.

A `char` is 1 byte or 8 bits. Range of -128 to 127.

```c
#include <stdio.h>

int main() {
	char c = 'C';
	
	printf("I LOVE programming in %c\n", c);
	
	return 0;
}
```

A `double` has 8 bytes or 64 bits.

```c
#include <stdio.h>

int main() {
	double d = 3234567891.123456;
	
	printf("Hoo boy this is a big number %lf\n", d);
	
	return 0;
}
```

A `float` is a number with decimals, 4 bytes or 32 bits. 

```c
#include <stdio.h>

int main() {
	float f = 3.141592f;
	
	printf("What time is it? %f time!", f);
	
	return 0;
}
```

A `int` is an integer number.

Mathematical operators are `+, -, *, /`. 

Modulo operator is `%%`.

You can perform mathematical operations across numeric types, but they will be type casted into `float`.

C supports explicit typing with the type name with parenthesis around your data. 

Comments are denoted with `//`.


## Problems


There are certain circumstances that can best be defined as *Undefined behavior*. This is when what happens when you perform these actions is system based, and quite often not recommend for various reasons.

One such situation is where you add 1 to an existing numerical variable that can't contain anymore. Or if you try to print a variable that hasn't been defined with a default value. Best practice to always give a default value.

I've done enough notes on how bits and bytes work, but some preface is needed; when you don't want to support a negative number for memory reasons, you can use an `unsigned` keyword before your variable. These are considered data type modifiers.

```c
#include <stdio.h>

int main() {
	int si = 2147483647;
	unsigned int ui = 4294967295;
	
	printf("This is a signed int -> %i\n", si);
	printf("This is an unsigned int -> %i\n", ui);
	
	return 0;
}
```

You also have `short` and `long`, which take up 2 and 4 bytes respectively.

```c
#include <stdio.h>

int main() {
	short s = 32767;
	long l = 2147483647;
	
	printf("This is a short -> %hd\n", si);
	printf("This is a long -> %ld\n", ui);
	
	return 0;
}
```

Because of how old C is, and the range of how much memory each type can take given a different operating system, there's a commonly used header library, `stdint.h` which many people use as so;

```c
#include <stdio.h>
#include <stdint.h>

// signed
typedef int8_t i8;   // char
typedef int16_t i16; // short
typedef int32_t i32; // int
typedef int64_t i64; // long

// unsigned
typedef uint8_t u8;   // unsigned char
typedef uint16_t u16; // unsigned short
typedef uint32_t u32; // unsigned int
typedef uint64_t u64; // unsigned long

int main() {
	i64 safe_long_8_bytes = 92233372036854775807;
	
	printf("long = %ld\n", safe_long_8_bytes);
	
	return 0;
}
```



---
Next: 
[Chapter 2]({{< ref "SLOP 100 - Chapter 2" >}}) 

