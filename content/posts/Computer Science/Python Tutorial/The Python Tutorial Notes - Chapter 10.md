---
aliases:
  - python
draft: true
tags:
  - computerscience
  - python
  - documentation
  - standardlibrary
  - modules
title: The Python Tutorial Notes - Chapter 10
date: 2024-07-04
---
Modified: July 19 2024 

-------------------------------------------------------------------------------

## **A Brief Tour of the Standard Library**

7/4/2024

### **10.1 Operating System Interface**

The `os` module provides functions for interacting with operating systems:

```python
>>> import os
>>> os.getcwd()     # returns the working directory
'C:\\Python312'
>>> os.chdir('/server/accesslogs')     # change working directory
>>> os.system('mkdir today')     # run the command mkdir in the system shell
0
```

Never use `from os import *`. It's not good practice to not  do this regardless, but it will specifically keep `os.open()` from shadowing the built-in `open()` function which operators for opening files. 

Below, we can see examples pf the `dir()` and `help()` functions.

```python
>>> import os
>>> dir(os)
<returns a list of all module functions>
>>> help(os)
<returns an extensive manual page created from the module's docstring>
```

For daily file and directory management tasks, the `shutil` module provides a higher level interface that is easier to use.

`copyfile(source, dist)` copies the contents of the file `source` to the file `dist` and returns `dist` in the most efficient way possible. `move(source, dist)` recursively move a file or directory, `source`, to another location and return the destination, `dist`.

```python
>>> import shutil
>>> shutil.copyfile('data.db', 'archive.db')
'archive.db'
>>> shutil.move('/build/executables', 'installdir')
'installdir'
```

### **10.2 File Wildcards**

`glob` is a module that provides a function for making file lists from directory wildcard searches:

```python
>>> import glob
>>> glob.glob('*.py')
['primes.py', 'random.py', 'quote.py']
```


### **10.3 Command Line Arguments**

Common utility scripts often need to process command line arguments. These arguments are stored in `sys` module's *argv* attribute as a list.

```python
# file is demo.py
>>> import sys
>>> print(sys.argv)

# here is the output from running python demo.py one two three
['demo.py', 'one', 'two', 'three']
```

The `argparse` module provides a more sophisticated mechanism to process command line arguments. The following example extracts one or more filenames and an optional number of lines to be displayed. 

```python
import argparse

parser = argparse.ArgumentParser(
	prog='top',
	description='Show top lines from each file')
parser.add_argument('filenames', nargs='+')
parser.add_argument('-1', '--lines', type=int, default=10)
args = parser.parse_args()
print(args)
```

If you run the above example with the command `python top.py --lines=5 alpha.txt beta.txt`, the script will set `args.lines` to 5 and `args.filenames` to `['alpha.txt', 'beta.txt']`.


### **10.4 Error Output Redirection and Program Termination**

`sys` also has attributes for *stdin*, *stdout*, and *stderr*. The latter is useful for emitting warnings and error messages even when *stdout* has been redirected.

```python
>>> sys.stderr.wrtie("Warning, log file not found starting a new one\n")
Warning, log file not found starting a new one
```

The most direct way to terminate any script is to use `sys.exit()`.


### **10.5 String Pattern Matching**

`re` is a module that provides regular expression tools (regex) for advanced string processing. 

```python
>>> import re
>>> re.findall(r'\bf[a-z]*', 'which foot or hand fell fastest')
['foot', 'fell', 'fastest']
>>> re.sub(r'\b[a-z]+) \1', r'\1', 'cat in the hat')
'cat in the hat'
```

For basic and simple tasks, string methods are preferred because they are easier to both read and debug.

```python
>>> 'tea for too'.replace('too', 'two')
'tea for two'
```


### **10.6 Mathematics**

`math` module gives access to the underlying C library functions for floating point math.

```python
>>> import math
>>> math.cos(math.pi / 4)
0.70710678118654757
>>> math.log(1024, 2)
10.0
```

`random` module provides tools for random selections.

```python
>>> import random
>>> random.choice(['apple', 'pear', 'banana'])
'apple'
>>> random.sample(range(100), 10)     # sampling without replacement
[30, 83, 16, 4, 8, 81, 41, 50, 18, 33]
>>> random.random()     # random float
0.179239851380
>>> random.randrange(6)     # random integer chosen from range(6)
4
```

`statistics` module calculates basic statistical properties (the mean, median, variance, etc.) of numeric data.

```python
>>> import statistics
>>> data = [2.75, 1.75, 1.25, 0.25, 0.5, 1.25, 3.5]
>>> statistics.mean(data)
1.60714292348
>>> statistics.median(data)
1.25
>>> statistics.variance(data)
1.3789436579
```


**10.7 Internet Access**

There are a few modules that can access the internet and process internet protocols. 

Two we can look at are `urllib.request` to retrieve URLs and `smtplib` for sending mail. For sending mail, we would need to have a mail server running on `localhost`. 

```python
>>> from urllib.request import urlopen
>>> with urlopen('http://worldtimeapi.org/api/timezone/etc/UTC.txt') as response:
...      for line in response:
...         line = line.decode()    # converts bytes to a str
...         if line.startswith('datetime'):
...              print(line.rstrip())     # removes trailing newline
...
datetime: 2022-01-01T01:36:47.6923847239

>>> import smtplib
>>> server = smtplib.SMTP('localhost')
>>> server.sendmail('soothsayer@example.org', 'rpointing@example.org'
... """To: rpointing@example.org
... From: soothsayer@example.org
...
... Beware the Ides of March.
... """)
>>> server.quit()
```


**10.8 Dates and Times**

`datetime` module supplies classes for manipulating dates and times in both simple and complex manners.

```python
>>> from datetime import date
>>> now = date.today()
>>> print(now)
2024-07-05
>>> print(now.strftime('%m/%d/%y\n%d %b %Y is a %A on the %d day of %B'))
07/05/24
05 Jul 2024 is a Friday on the 05 day of July

>>> birthday = date(1997, 5, 1)
>>> age = now - birthday
>>> age.days
9927
```


**10.9 Data Compression**

Common data archiving/compression formats are directly supported by modules like `zlib`, `gzip`, `bz2`, `lzma`, `zipfile`, and `tarfile`.

```python
>>> import zlib
>>> s = b'witch which has which witches wrist watch'
>>> len(s)
41
>>> t = zlib.compress(s)
>>> len(t)
37
>>> zlib.decompress(t)
b'witch which has which witches wrist watch'

```


7/6/2024

**10.10 Performance Measurement**

Python has a built-in tool for measuring performance. `timeit` is one module that can show that:

```python
>>> from timit import Timer
>>> Timer('t=a; a=b; b=t', 'a=1;b=2').timeit()
0.1351344
>>> Timer('a, b = b, a', 'a=1; b=2').timeit()
0.05585979999999996
```


**10.11 Quality Control**

In order to make sure your code is up-to-stuff, or of a higher quality, you can write tests that can be run throughout the development of the project.

If you use the `doctest` module, and include a use case in your module's docstring, it can very easily run the tests.

```python
import doctest  
  
def average(values):  
    """Computes the arithmetic mean of a list of numbers  
    >>> print(average([20, 30, 70]))  
    40.0    
    """    
    return sum(values) / len(values)  
  
doctest.testmod()
```

In the above example, if you change the answer to something else, making it fail the test case, the compiler should show you exactly what went wrong.

There is also the `unittest` module, that is more complicated that `doctest` so it will obviously be a bit more comprehensive as a testing feature.

```python
import unittest

class TestStatisticalFunctions(unittest.TestCase):
	def test_average(self):
		self.assertEqual(average([20, 30, 70]), 40.0)
		self.assertEqual(round(average([1, 5, 7]), 1), 4.3)
		with self.assertRaises(ZeroDivisionError):
			average([])
		with self.assertRaises(TypeError):
			average(20, 30, 70)

unittest.main()
```


### **10.7 Internet Access**

There are a few modules that can access the internet and process internet protocols. 

Two we can look at are `urllib.request` to retrieve URLs and `smtplib` for sending mail. For sending mail, we would need to have a mail server running on `localhost`. 

```python
>>> from urllib.request import urlopen
>>> with urlopen('http://worldtimeapi.org/api/timezone/etc/UTC.txt') as response:
...      for line in response:
...         line = line.decode()    # converts bytes to a str
...         if line.startswith('datetime'):
...              print(line.rstrip())     # removes trailing newline
...
datetime: 2022-01-01T01:36:47.6923847239

>>> import smtplib
>>> server = smtplib.SMTP('localhost')
>>> server.sendmail('soothsayer@example.org', 'rpointing@example.org'
... """To: rpointing@example.org
... From: soothsayer@example.org
...
... Beware the Ides of March.
... """)
>>> server.quit()
```


### **10.8 Dates and Times**

`datetime` module supplies classes for manipulating dates and times in both simple and complex manners.

```python
>>> from datetime import date
>>> now = date.today()
>>> print(now)
2024-07-05
>>> print(now.strftime('%m/%d/%y\n%d %b %Y is a %A on the %d day of %B'))
07/05/24
05 Jul 2024 is a Friday on the 05 day of July

>>> birthday = date(1997, 5, 1)
>>> age = now - birthday
>>> age.days
9927
```


### **10.9 Data Compression**

Common data archiving/compression formats are directly supported by modules like `zlib`, `gzip`, `bz2`, `lzma`, `zipfile`, and `tarfile`.

```python
>>> import zlib
>>> s = b'witch which has which witches wrist watch'
>>> len(s)
41
>>> t = zlib.compress(s)
>>> len(t)
37
>>> zlib.decompress(t)
b'witch which has which witches wrist watch'

```


7/6/2024

### **10.10 Performance Measurement**

Python has a built-in tool for measuring performance. `timeit` is one module that can show that:

```python
>>> from timit import Timer
>>> Timer('t=a; a=b; b=t', 'a=1;b=2').timeit()
0.1351344
>>> Timer('a, b = b, a', 'a=1; b=2').timeit()
0.05585979999999996
```


### **10.11 Quality Control**

In order to make sure your code is up-to-stuff, or of a higher quality, you can write tests that can be run throughout the development of the project.

If you use the `doctest` module, and include a use case in your module's docstring, it can very easily run the tests.

```python
import doctest  
  
def average(values):  
    """Computes the arithmetic mean of a list of numbers  
    >>> print(average([20, 30, 70]))  
    40.0    
    """    
    return sum(values) / len(values)  
  
doctest.testmod()
```

In the above example, if you change the answer to something else, making it fail the test case, the compiler should show you exactly what went wrong.

There is also the `unittest` module, that is more complicated that `doctest` so it will obviously be a bit more comprehensive as a testing feature.

```python
import unittest

class TestStatisticalFunctions(unittest.TestCase):
	def test_average(self):
		self.assertEqual(average([20, 30, 70]), 40.0)
		self.assertEqual(round(average([1, 5, 7]), 1), 4.3)
		with self.assertRaises(ZeroDivisionError):
			average([])
		with self.assertRaises(TypeError):
			average(20, 30, 70)

unittest.main()
```


-------------------------------------------------------------------------------
Next: 
[Chapter 11]({{< ref "The Python Tutorial Notes - Chapter 11" >}})
