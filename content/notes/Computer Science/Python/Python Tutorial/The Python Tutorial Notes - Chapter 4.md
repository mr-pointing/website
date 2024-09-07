---
aliases:
  - python
draft: false
tags:
  - computerscience
  - python
  - documentation
  - conditionals
title: The Python Tutorial Notes - Chapter 4
date: 2024-06-05
---
Modified: July 19 2024 

-------------------------------------------------------------------------------
## **Control Flow Tools**

6/5/2024

The while loop was seen in the previous Fibonacci Sequence example.

### **4.1 `if` Statements**

```python
>>> x = int(input("Please enter an integer: "))
Please enter an integer: 42
>>> if x < 0:
>>> 	x = 0
>>> 	print("Negative so now it's zero!")
>>> elif x == 0:
>>> 	print("Zero!!!")
>>> elif x == 1:
>>> 	print("UNO!!!!!")
>>> else:
>>> 	print("Nice B)")
Nice B)
```

Very basic; all you need is an if statement. Else is optional, and you can have many else if (`elif`) statements as you desire.

Similar to the `switch` and `case` statements in other languages (which?)

Also similar to `match` statements


### **4.2 `for` Statements**

Unlike C++ where the user can define the iteration step and end conditions, Python's `for` statement iterates through an object (any sequence of data) in the order they appear, usually a list or a string.

```python
>>> words = ["cat", "binky", "aphrodite"]
>>> for w in words:
>>> 	print(w, len(w))
cat 3
binky 5
aphrodite 9
```

Pro-tip: if your loop modifies a sequence while iterating over it, it is best to make a copy or create a new collection

```python
# Create sample dictionary
users = {'Richie': 'active', 'Sarah': 'inactive', 'Atticus': 'active'}

# 1st strat: Iterate over a copy
for user, status in users.copy().items():
	if status == 'inactive':
		del users[user]

# 2nd strat: Create a new dictionary
active_users = {}
for user, status in user.items():
	if status == 'active':
		active_users[user] = status
```


### **4.3 The `range()` Function**

An easy way to iterate over a sequence of numbers is to use the `range()` function alongside a `for` loop. The number you use as the limit will never be reached; it has three basic parameters.

With just one parameter:

```python
>>> for i in range(3):
>>> 	print(i)
0
1
2
```

With two parameters:

```python
# range(start, step)
>>> for in in range(5, 10):
>>> 	print(i)
5
6
7
8
9
```

With three parameters:

```python
# range(start, stop, step)
>>> for i in range(1, 10, 2):
>>> 	print(i)
1
3
5
7
9
```

To iterate over the indices of a sequence, you can use `range()` and `len()` together, but you could also use `enumerate()` to get the same effect, which I will get into later I'm sure.

```python
>>> loughlin = ["Let's", "go", "Lions!"]
>>> for i in range(len(loughlin)):
>>> 	print(i, a[i])
0 Let's
1 go
2 Lions!
```

The item returned by `range()` acts like a list but isn't; it just returns a sequence of desired numbers based on parameters. Since it's not a list it saves space.


### **4.4 `break` and `continue` Statements, and `else` Clauses on Loops**

Both `for` and `while` loops can have an else clause. For a `for` loop, the else clause is executed after the loop reaches a final iteration. For the `while` loop, the else clause executes after the loop's condition becomes false.

The `break` statement interrupts a `for` or `while` loop. If either loop has an `else` clause, the break statement will bypass the `else` so it doesn't execute. We can see the above ideas below when searching for prime numbers:

```python
>>> for n in range(2, 10):
>>> 	for x in range(2, n):
>>>		if n % x == 0:
>>>			print(n, 'equals', x, '*', n//x)
>>>			break
>>>	else:
>>>		# loop falls through without finding a factor
>>>		print(n, 'is a prime number')
2 is a prime number
3 is a prime number
4 equals 2 * 2
5 is a prime number
6 equals 2 * 3
7 is a prime number
8 equals 2 * 4
9 equals 3 * 3
```

When used with a loop, the `else` clause has more in common with the clause of a `try` statement than an `if` statement; a `try` statement's clause will run when no exception occurs while a loops clause will run when no `break` occurs

The `continue` statement moves onto the next iteration of a loop:

```python
>>> for num in range(2, 10):
>>> 	if num % 2 == 0:
>>> 		print("Found an even number", num)
>>> 		continue
>>> 	print("Found an odd number", num)
Found an even number 2
Found an odd number 3
Found an even number 4
Found an odd number 5
Found an even number 6
Found an odd number 7
Found an even number 8
Found an odd number 9
```

6/6/2024

### **4.5 `pass` Statements**

The `pass` statement does nothing really; just allows something to exist which doesn't necessarily need to do anything.

```python
while True:
	pass    # Waits for keyboard interrupt (Ctrl + c)
```

```python
class MyEmptyClass:
	pass
```

```python
def initlog(*args):
	pass      # Remember to implement this!
```


### **4.6 `match` Statements**

A `match` statement takes in an expression, and compares it to case blocks in some successive pattern. Only the first pattern found gets executed.

A basic implementation:

```python
def http_error(status):
	match status:
		case 400:
			return "Bad Request"
		case 404:
			return "Not found"
		case 420:
			return "Falcon Punch!"
		case _:
			return "Something's effed up with the net"
```

In the above example, `_` acts like a wildcard, and will execute if no cases are matched. You can combine multiple literals in a single pattern using the Pipe operator `|` ("or").

```python
case 401 | 402 | 403:
	return "Not allowed"
```

The pattern to be matched can be also used to unpack assignments, and can also bind variables:

```python
# point is an (x, y) tuple
match point:
	case (0, 0):
		print("Origin")
	case (0, y):
		print(f"Y={y}")
	case (x, 0):
		print(f"X={x}")
	case (x, y):
		print(f"X={x}, Y={y}")
	case _:
		raise ValueError("Not a point")	
```

In the above example, the first pattern uses literals, while the second and third combine literals and a variable (binding a value from the subject *point*), and the fourth pattern uses two values, which is conceptually similar to unpacking `(x, y) = point`.

You can also use classes with patterns:

```python
class Point:
	def __init__(self, x, y):
		self.x = x
		self.y = y

def where_is(point):
	match point:
		case Point(x=0, y=0):
			print("Origin")
		case Point(x=0, y=y):
			print(f"Y={y}")
		case Point(x=x, y=0):
			print(f"X={x}")
		case Point(x=x, y=y):
			print(f"X={x}, Y={y}")
		case _:
			print("Not a point")
```

Positional parameters can be accounted for if order is required for attributes; you can also define specific positions for attributes in patterns by setting the `__match_args__` special attribute in user defined classes.

```python
# if we used __match_args__ = ('x', 'y') in our class, these
# would all be valid ways of writing cases and all assign y to the var variable
Point(1, var)
Point(1, y=var)
Point(x=1, y=var)
Point(y=var, x=1)
```

They say, "A recommended way to read patterns is to look at them as an extended form of what you would put on the left of an assignment, to understand which variables would be set to what."
I honestly don't understand this, so I'll need someone smarter than me to clarify this further for me. 

You can nest patterns:

```python
class Point:
	__match_args__ = ('x', 'y')
	def __init__(self, x, y):
		self.x = x
		self.y = y

match points:
	case []:
		print("No points")
	case [Point(0, 0)]:
		print("The origin")
	case [Point(x, y)]:
		print(f"Single point {x}, {y}")
	case [Point(0, y1), Point(0, y2)]:
		print(f"Two on the y axis at {y1}, {y2}")
	case _:
		print("Something else")
```

We can also add an `if` clause to a pattern, known as a guard. If the guard is false, the `match` goes onto the next case block:

```python
match point:
	case Point(x, y) if x == y:
		print(f"Y=X at {x}")
	case Point(x, y):
		print(f"Not on the diagnol")
```

More key features about `match` statements:
- Tuple and list patterns have the same meaning and match arbitrary sequences. An exception is they don't match iterators or strings.
- Sequence patterns support extended unpacking: `[x, y, *rest]` and `(x, y, *rest)` work like unpacking assignments. You can also use `_` after the `*`, so you can match a sequence of two items without binding the remaining items. 
- Literals are compared by equality; singletons compared by identity.
- Patterns can be named constants; must be dotted names so they aren't interpreted as capture variables:

```python
from enum import Enum
class Color(Enum):
	RED = 'red'
	GREEN = 'green'
	BLUE = 'blue'

color = Color(input("Enter your choice of red, blue, or green: "))

match color:
	case Color.RED:
		print("I see red!")
	case Color.GREEN:
		print("I see green!")
	case Color.BLUE:
		print("I see blue!")
```

A tutorial on how to better use `match` is [here](https://peps.python.org/pep-0636/).


### **4.7 Defining Functions**

We can create a function for that Fibonacci sequence from earlier:

```python
>>> def fib(n):      # write a Fibonacci series up to n
>>> 	"""Print a Fibonacci series up to n."""
>>> 	a, b = 0, 1
>>> 	while a < n:
>>> 		print(a, end=' ')
>>> 		a, b = b, a+b
>>> 	print()
>>> fib(2000)
0 1 1 2 3 5 8 13 21 34 55 89 144 233 377 610 987 1597
```

The `def` keyword for *definition* defines the function, with the name directly following and parenthesis to house the formal parameters, followed by a colon. The instructions follow underneath indented.

The first line of a function has the option to create a *docstring* using three quotation marks, seen above. More for accessibility, it's good practice to use them.


6/8/2024

The scope of variables within a function are local and are in a separate table than variables outside; they will not be able to directly modify/update out of scope variables. We can circumnavigate this by using the `global` call for a variable inside a function.

The parameters of a function are  introduced in that separate variable table specifically for that function; this means parameters are passed using *call by value* (value passed is a reference, not the value of the object).

Other languages might assume since a function doesn't return anything it's a procedure; in Python, if there is no `return` specified, it returns `None`.

We can rewrite the above Fibonacci Series with a return statement instead of print:

```python
>>> def fib2(n):
>>> 	"""Return a list containing a Fibonacci Series up to n."""
>>> 	result = []
>>> 	a, b = 0, 1
>>> 	while a < n:
>>> 		result.append(a)
>>> 		a, b = b, a + b
>>> 	return result
>>> f100 = fib2(100)
>>> f100
[0, 1, 1, 2, 3, 5, 8, 13, 21, 34, 55, 89]
```


### **4.8 More on Defining Functions**

Three forms of defining functions with a variable number of arguments;

1. Default Argument Values
	1. Very useful; allows for leaving out parameters not needed.
	2. We could call the function below in a few ways:
		1. Only the mandatory argument: `ask_ok("Do you really want to quit?")`
		2. Giving optional arguments: `ask_ok("OK to overwrite the file?", 2)`
		3. All arguments: `ask_ok("OK to overwrite file?", 2, "Only yes or no buster!")`
```python
def ask_of(prompt, retries=4, reminder="Please try again!"):
	while True:
		reply = input(propt)
		if reply in {'y', 'ye', 'yes'}:        # tests whether or not a sequence                    return True                        # contains a certain value
		if reply in {'n', 'no', 'nop', 'nope'}:
			return False
		retries -= 1
		if retries < 0:
			raise ValueError('invalid user response')
		print(reminder)
```

2. Keyword Arguments
	1. Functions can be called using keyword arguments, `kwarg=value`.
		1. In the code below, the function requires one parameter `voltage` and three optional parameters `state`, `action`, and `type` .
	
```python
>>> def parrot(voltage, state='a stiff', action='voom', type='Norwegian Blue'):
>>>	print("-- This parrot wouldn't", action, end=' ')
>>>	print("If you put", voltage, "volts to it.")
>>>	print("-- Lovely plumage, the", type)
>>>	print("-- It's", state,"!")
>>>  
>>> # Valid Calls
>>> parrot(1000)
>>> parrot(voltage=1000)
>>> parrot(voltage=10000, action="VMOOM")
>>> parrot(action="VMOOOM", voltage=10000)
>>> parrot('a million', 'bereft of life', 'jump')
>>> parrot('a thousand', state='pushin up daises')
>>> 
>>> # Invalid Calls
>>> parrot()                       # required argument missing
>>> parrot(voltage=5.0, 'dead')    # non-keyword assignment after keyword assignment
>>> parrot(110, voltage=220)       # duplicate value for the same argument
>>> parrot(actor='John Cleese')    # unknown keyword argument
```

 2.  When the final formal parameter is in the syntax `**name`, it receives a dictionary with all keyword arguments except for those corresponding to a formal parameter. This is usually combined with a formal parameter of syntax `*name` which receives a tuple containing the positional arguments beyond the formal parameter list. `*name` must go before `**name`, obviously. We can write the following:
```python
>>> def donut_shop(flavor, *arguments, **keywords):
>>> 	print("-- Do you have any", flavor, "?")
>>> 	print("-- I'm sorry, we're all out of ", flavor)
>>> 	for arg in arguments:
>>> 		print(arg)
>>> 	print("-" * 40)
>>> 	for kw in keywords:
>>> 		print(kw, ":", keywords[kw])
>>> donut_shop("Red Velvet", "We have no Donuts...",
>>> 			"We have...no...DONUTS????",
>>> 			vanilla="Out of Stock",
>>> 			chocolate="Out of Stock",
>>> 			oreo="Out of Stock")
-- Do you have any Red Velvet?
-- I'm sorry, we're all out of Red Velvet
We have no Donuts...
We have...no...DONUTS???
------------------------------------------
vanilla : Out of Stock
chocolate : Out of Stock
oreo : Out of Stock
```

3. Special Parameters
	1. By default, arguments passed to a Python function by position or keyword. TO increase readability and performance, you should restrict the way arguments are passed so a developer can just look at a function definition to determine if items are passed via position, position or keyword, or by keyword. 
	2. Function notation for this looks like the following:
		1. `def f(pos1, pos2, /, pos_or_kwd, *, kwd1, kwd2):`
		2. `/` and `*` are optional, when used they indicate the kind of parameter by how the arguments may be passed to the function.


6/10/2024


Examples of Function Calls:

```python
>>> def standard_arg(arg)L
>>> 	print(arg)
>>> def pos_only_arg(arg, /):
>>> 	print(arg)
>>> def kwd_only_arg(*, arg):
>>> 	print(arg)
>>> def combined_example(post_only, /, standard, *, kwd_only):
>>> 	print(pos_only, standard, kwd_only)
>>> standard_arg(2)             
2                             # first function takes either
>>> standard_arg(arg=2)
2
>>> pos_only_arg(1)
1
>>> pos_only_arg(arg=1)
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
TypeError: pos_only_arg() got some positional-only arguments passed as keyword arguments: 'arg'
>>> kwd_only_arg(3)
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
TypeError: kwd_only_arg() takes 0 positional arguments but 1 was given
>>> kwd_only_arg(arg=3)
3
>>> combined_example(1, 2, 3)
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
TypeError: combined_example() takes 2 positional arguments but 3 were given
>>> combined_example(1, 2, kwd_only=3)
1 2 3
>>> combine_example(1, standard=2, kwd_only=3)
1 2 3
>>> combine_example(pos_only=1, standard=2, kwd_only=3)
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
TypeError: combined_example() got some positional-only arguments passed as keyword arguments: 'pos_only'

```

**Recap:**
* Positional-only if you want the name of the parameters to not be available to the users, or if they are arbitrary/have no meaning.
* Keyword-only when names have meaning and function definition is more understandable.
* For API, use positional-only to prevent breaking API changes if the parameters name is modified 

Another less frequently used option is to specify that your function can be called with any amount of arguments. Arguments are wrapped as a tuple. Zero or more normal arguments may go before the `*args`

```python
def wrote_multiple_items(file, seperator, *args):
	file.write(separator.join(args))
```

We can do the reverse of this situation if there is a list with values already:

```python
>>> list(range(3, 6))
[3, 4, 5]
>>> args = [3, 6]
>>> list(range(*args))
[3, 4, 5]
```


-------------------------------------------------------------------------------
Next: 
[Chapter 5]({{< ref "The Python Tutorial Notes - Chapter 5" >}})
