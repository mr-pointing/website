---
aliases:
  - python
draft: true
tags:
  - computerscience
  - python
  - documentation
  - errors
  - exceptions
title: The Python Tutorial Notes - Chapter 8
date: 2024-06-22
---
Modified: July 19 2024 

-------------------------------------------------------------------------------

## **Errors and Exceptions**

6/22/2024

There are two distinguishable types of errors: *syntax errors* and *exceptions*.

### **8.1 Syntax**

Syntax errors (or parsing errors) are errors involving the actual use of the language. 

```python
>>> while True print('Hello World')
   File "<stdin>", line 1
    while True print('Hello world')
               ^^^^^
SyntaxError: invalid syntax
```


In the example above, the `while` statement is missing the `:` required to use it.


### **8.2 Exceptions**

Even if code is syntactically correct, an error may occur when attempting to execute it. When the error is thrown, the last line of the error usually has an explanation. 

```python
>>> 10 * (1/0)
Traceback (most recent call last):
	File "<stdin>", line 1, in <module>
ZeroDivisionError: division by zero

>>> 4 * spam*3
Traceback (most recent call last):
	File "<stdin>", line 1, in <module>
ZeroDivisonError: name 'spam' is not defined

>>> '2' * 2
Traceback (most recent call last):
	File "<stdin>", line 1, in <module>
TypeError: can only concantenate str(not "int") to str
```

[This](https://docs.python.org/3/library/exceptions.html#bltin-exceptions) is a document on all of the built-in exceptions


### **8.3 Handling Exceptions**

You can write programs that handle errors that instead of letting your program break. I assume it uses less memory/processing power than an `if` statement.

```python
>>> while True:
...     try:
...         x = int(input("Please enter a number: "))
...         break
...     except ValueError:
...         print("Oops!  That was no valid number.  Try again...")
```


The above code will not break if you were to enter a character or anything other than a number. 

Here is how the `try` statement works.

1) The *try clause* (between `try` and `except`) is executed
2) If no exception occurs, the *except clause* is skipped and execution of the `try` statement is finished
3) If an exception occurs, the rest of the *try clause* is skipped. If the type of error matches the exception used in the `except`, the *except clause* is executed and then execution continues after the `try`/`except` block. (In the example above that doesn't happen, because we put the `try` statement in a `while` loop.)

A `try` statement can have more than one *except clause*, passed in a parenthesized tuple. 

You can place a variable after the `except` keyword, which bounds the exceptions arguments to it.

```python
>>> try:
...     raise Exception('spam', 'eggs')
... except Exception as inst:
...     print(type(inst))
...     print(inst.args)     
...     print(inst)             
...     x, y = inst.args     
...     print('x =', x)
...     print('y =', y)
<class 'Exception'>
('spam', 'eggs')
('spam', 'eggs')
x = spam
y = eggs
```

We can use `Exception` as a way to catch most errors if we don't specify the type.

```python
import sys

try:
	f = open('myfile.txt')
	s = f.readline()
	i = int(s.strip())
except OSError as err:
	print("OS error:", err)
except ValueError:
	print("Could not convert data to an integer.")
except Exception as err:
	print(f"Unexpected {err=}, {type(err)=}")
	raise
```

`try` also has an *else clause* it can take advantage of. It must follow all *except clauses*, and is useful for code that must be executed if the try clause does not raise any exception.

```python
for arg in sys.argv[1:]:
	try:
		f = open(arg, 'r')
	except OSError:
		print('cannot open', arg)
	else:
		print(arg, 'has', len(f.readlines()), 'lines')
		f.close()
```

Exception handlers also catch errors that happen in the body of code written, not just in the *try clause*.

### **8.4 Raising Exceptions**

`raise` allows the programmer to force a specified exception to occur.

```python
>>> raise NameError('HiThere')
Traceback (most recent call last):
	File "<stdin>", line 1, in <module>
NameErrror: HiThere
```

The following example is fun to play with:

```python
>>> try:
...     raise NameError('HiThere')
... except NameError:
...     print('An exception flew by!')
...     raise
...
An exception flew by!
Traceback (most recent call last):
  File "<stdin>", line 2, in <module>
NameError: HiThere
```

So if I remove the raise on line 5, the code runs with no errors. If you keep it, the code finishes with one exit error. If I don't raise any error in the try, the except obviously doesn't run.


### **8.5 Exception Chaining**

This part is a bit complicated, so strap in.

So, there can be instances where an unhandled exception occurs in an except section. In this case, it will attach the error to the raised error.

```python
>>> try:
...     open("database.sqlite")
... except OSError:
...     raise RuntimeError("unable to handle error")
Traceback (most recent call last):
  File "<stdin>", line 2, in <module>
FileNotFoundError: [Errno 2] No such file or directory: 'database.sqlite'

During handling of the above exception, another exception occurred:

Traceback (most recent call last):
  File "<stdin>", line 4, in <module>
RuntimeError: unable to handle error
```

You can use the `from` clause after the `raise` statement to indicate that an exception is a direct consequence of another.

```python
>>> def func():
...      raise ConnectionError
...
>>> try:
...     func()
... except ConncetionError as exc:
...     raise RuntimeError('Failed to open database') from exc
...
Traceback (most recent call last):
  File "<stdin>", line 2, in <module>
  File "<stdin>", line 2, in func
ConnectionError

The above exception was the direct cause of the following exception:

Traceback (most recent call last):
  File "<stdin>", line 4, in <nodule>
RuntimeError: Failed to open database
```


### **8.6 User-defined Exceptions**

Programs can name their own exceptions by creating a new exception class. They are either directly or indirectly derived from the `Exception` class.

Common for modules to define their own exceptions to report errors that occur in the functions they define. 


### **8.7 Defining Clean-up Actions**

In order to make something execute regardless of exceptions, what we can call "clean-up actions", we can use `finally`.

The way `finally` interacts with the rest of the `try` statement can be defined as follows:

1) If an exception occurs during the execution of the *try clause*, the `except` statement kicks in, then `finally` right after. If the error is not handled by the *expect clause*, the exception is raised after the `finally` has executed (same thing happens if an exception happens during the *exception clause*
2) If the `finally` has a `break`, `continue` or `return` statement, the exceptions are **not** re-raised
3) If the `try` statement has a `break`, `continue` or `return` statement, the `finally` executes just prior to the `break`, `continue` or `return` execution
4) If the `finally` has a `return` statement, the returned value will be the one from the `finally` instead of the `try`.

Some Examples;

Basic:

```python
>>> try:
...    raise KeyboardInterrupt
... finally:
...    print('Goodbye World!')
...
Goodbye World!
Traceback (most recent call last):
  File "<stdin>", line 2, in <module>
KeyboardInterrupt
```

Medium:

```python
>>> def bool_return():
...     try:
...          return True
...     finally:
...          return False
...
>>> bool_return()
False
```

Complicated:

```python
>>> def divide(x, y):
...     try:
...          result = x / y
...     except ZeroDivisionError
...          print("division by zero!")'
...     else:
...          print("result is", result)
...     finally:
...          print("executing finally clause")
...
>>> divide(2, 1)
result is 2.0
executing finally clause
>>> divide(2, 0)
division by zero!
executing finally clause
>>> divide ("2", "1")
executing finally clause
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
  File "<stdin>", line 3, in divide
TypeError: unsupprted operand type(s) for /: 'str' and 'str'
```


### **8.8 Predefined Clean-up Actions**

The only thing this section touches on is that you shouldn't just open a file since it might not close; you should open a file using a `with` statement.

```python
with open("myfile.txt") as f:
	for line in f:
		print(line, end="")
```


### **8.9 Raising and Handling Multiple Unrelated Exceptions**

There are situations where there are several exceptions that have occurred. This is the case in concurrency frameworks, when several tasks might've failed in parallel. `ExceptionGroup` can list together exception instances. 

```python
>>> def f():
...     excs = [OSError('error 1'), SystemError('error 2')]
...     raise ExceptionGroup('there were problems', excs)
...
>>> f()
  + Exception Group Traceback (most recent call last):
  |   File "<stdin>", line 1, in <module>
  |   File "<stdin>", line 3, in f
  | ExceptionGroup: there were problems
  +-+---------------- 1 ----------------
    | OSError: error 1
    +---------------- 2 ----------------
    | SystemError: error 2
    +------------------------------------
>>> try:
...     f()
... except Exception as e:
...     print(f'caught{type(e)}: e')
...
caught <class 'ExceptionGroup'>: e
```


### **8.10 Enriching Exceptions with Notes**

If an exception is created in order to be raised, it is usually initialized with information that describes the error that has occurred. Adding information on the error is achievable using the `add_note(note)` method built-into the exception class.

```python
>>> try:
...     raise TypeError('bad type')
... except Exception as e:
...     e.add_note('Something biffed it dude!')
...     raise
...
Traceback (most recent call last):
  File "<stdin>", line 2 in <module>
TypeError: bad type 
Something biffed it dude!
```



-------------------------------------------------------------------------------
Next: 
[Chapter 9]({{< ref "The Python Tutorial Notes - Chapter 9" >}})

