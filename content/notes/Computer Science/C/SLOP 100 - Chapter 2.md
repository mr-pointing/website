---
aliases:
draft: false
tags:
  - computerscience
  - c
title: SLOP 100 - Chapter 2
date: 2026-01-05
updated: 2026-02-25T19:02
---

-------------------------------------------------------------------------------

# Conditionals

Let's say we have the code from last chapter;

```c
#include <stdio.h>

int main() {
	int year = 2026;
	
	printf("This is the year %i", year);
	
	return 0;
}
```

To add conditional statements, they look like this;

```c
#include <stdio.h>

int main() {
	int year = 2026;
	
	if(year == 2026) {	
		printf("This is the year %i", year);
	}
	
	return 0;
}
```

The usual comparison operators are available, greater than, less than, and so on. You can also use logical operators, like `&&` for *and*, or `||` for *or*.

`else if` statements and `else` are written like so;

```c
#include <stdio.h>

int main() {
	int i = 24;
	
	// Checks for a single digit number
	if(i < 10 && i >= -9) {
		printf("i is a single digit \n");
	} else if(i <= 99 && i >= -99) {
		printf("i is two digits long \n");
	} else {
		printf("i is three digits or more \n");
	}
	
	return 0;
}
```

Like most if not all languages, these checks are boolean checks, running only if the designated check is true. If false, they are skipped. Up until C23, booleans were not supported as a type, and mostly were 1 for true and 0 for false. They are supported, but due to C being such an old language it's not commonly adopted into code bases and may not be used at all. What SLOP recommends is using C99's `stdbool.h` library, like so;

```c
#include <stdio.h>
#include <stdbool.h>

int main() {
	bool t = true;
	bool f = false;
	
	if(t) {
		printf("Variable t is true!\n");
	}
	
	if(f == false) {
		printf("Variable f is false!\n");
	}
	return 0;
}
```

Exclamation points are used in mostly two ways; `!=` for not equal to, and `!` in front of a boolean to make it a **NOT** operator.

If you have a long chain of `if` statements, technically the more efficient way to write the check out is using a `switch` statement instead;

```c
#include <stdio.h>

int main() {
	int i = 3;
	
	switch(i) {
		case 1: {printf("i is 1\n"); } break;
		case 2: {printf("i is 2\n"); } break;
		case 3: {printf("i is 3\n"); } break;
		case 4: {printf("i is 4\n"); } break;
		case 5: {printf("i is 5\n"); } break;
		default: {printf("i is something else\n"); } break;
	}
	
	return 0;
}
```

Exactly why these are faster is not so important, and for many statements it's even sometimes better to use an if-else statement, but we should know they exist regardless.

# Loops

While loops are written as so;

```c
#include <stdio.h>
#include <stdbool.h>

int main() {
	int i = 0;
	
	while(i < 10) {
		printf("i is %i\n", i);
		
		++i;
	} 
	return 0;
}
```

To clarify, there is a difference between a prefix and postfix operator choice. If you were to print them, the prefix operator will print the number +1, while the postfix will print the original number and increment as the final segment of the line being ran. The prefix operator is faster.

We can use *logical loop statements*, like *continue* or *break* to skip and end the loop, respectively. The last important structure is the `for` loop;

```c
#include <stdio.h>
#include <stdbool.h>

int main() {
	for(int i = 0; i < 10; ++i) {
		printf("i is %i\n", i);
	}
	
	return 0;
}
```