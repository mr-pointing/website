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
title: The Python Tutorial Notes - Chapter 11
date: 2024-07-09
---
Modified: July 19 2024 

-------------------------------------------------------------------------------
## **The Standard Library - Part 2**

7/9/2024

The second part here will go over more advanced, less common modules that nevertheless, exist.

### **11.1 Output Formatting**

`reprlib` is an appropriately named library containing a version of `repr()` modified for abbreviated displays of large or deeply nested containers:

```python
>>> import reprlib
>>> reprlib.repr(set('supercalafragalisticexpialidocious'))
"{'a', 'c', 'd', 'e',..."
```

`pprint` is a module with more sophisticated control over printing both built-in and user defined objects. Could also be called a "pretty printer", it will add line breaks and indentation to more clearly reveal complex data structures.

```python
>>> import pprint
>>> t = [[['black', 'cyan'], 'white', ['green', 'red'], ['magenta', ...     'yellow'], 'blue']]
...
>>> pprint.pprint(t, width=30)
[[[['black', 'cyan'],
   'white',
   ['green', 'red']],
  [['magenta', 'yellow'],
   'blue']]]
```

`textwrap` formats text to fit any given screen width.

```python
>>> import textwrap
>>> some_text = """Using wrap() is the same as using fill(), except for that it returns a list of strings instead of one big string filled with newlines to seperate wrapped lines"""
>>> print(textwrap.fill(some_text, width=40))
Using wrap() is the same as using
fill(), except for that it returns a
list of strings instead of one  big
string filled with newlines to seperate
wrapped lines
```

`locale` module helps with grabbing formats for specific parts of the world.

```python
>>> import locale
>>> locale.setlocale(locale.LC_ALL, 'English_United States.1252')
'English_United States.1252'
>>> conv = locale.localeconv() # grabs a mapping of conventions
>>> x = 1234567.8
>>> locale.format_string("%d", x, grouping=True)
'1,234,567'
>>> locale.format_string("%s%.*f", (conv['currency_symbol'],
...    conv['frac_digits'], x), grouping=True)
...
'$1,234,567.80'
```

### **11.2 Templating**

Within the `string` module, there exists a `Template` class that allows for a different method of string formatting. This is good particularly for end users, since they can customize their applications without having to alter them. Not sure why that differs much from collecting input in general but it works like so:

```python
>>> from string import Template
>>> t = Template('${village}folk send $$10 to $cause.')
>>> t.substitute(village='Brooklyn', cause='Food Not Bombs')
'Brooklynfolk send $10 to Food Not Bombs'
```

We just need to use a `$` followed by a placeholder name. In order to use these placeholder next to names in text, we have to place the placeholder in curly braces, like with `village` above. If we want to use the `$` character in general, you need to use two instead of one. 

The `substitute()` method raises a `KeyError` if a placeholder is not supplied in a dictionary or a keyword argument. If the placeholder exists as a key within one dictionary, only one dictionary needs to be passed. If you want to make sure it gets through regardless, you can use `safe_substitute()` instead. 

```python
>>> t = Template('Return the $item to the $owner')
>>> d = dict(item='broadsword')  
>>> x = {'item': 'keyblade', 'owner': 'cow'}
>>> t.substitute(d)
Traceback (most recent call last):
...
KeyError: 'owner'
>>> t.substitute(x)
'Return the keyblade to the cow'
>>> t.safe_substitute(d)
'Return the broadsword to the $owner'
```

7/10/2024

This next example took me a while to comprehend, but it was really worth it. 

So, for templates, the delimiter  can be customized to fit the input. In the following example, we want to use percent sign instead, in order to better format file names.

```python
>>> import time, os.path
>>> photofiles = ['img_1074.jpg', 'img_1011.jpg', 'img_1183.jpg']
>>> class BatchRename(Template):
...     delimiter = '%'
...
>>> fmt = input('Enter rename style (%d-date %n-seqnum %f-format): ')
Enter rename style (%d-date %n-seqnum %f-format): Richie_%n%f

>>> t = BatchRename(fmt)
>>> date = time.strftime('%d%b%y')
>>> for i, filename in enumerate(photofiles):
...     base, ext = os.path.splitext(filename)
...     newname = t.substitute(d=date, n=i, f=ext)
...     print('{0} --> {1}'.format(filename, newname))
...
img_1074.jpg --> richie_0.jpg
img_1011.jpg --> richie_1.jpg
img_1183.jpg --> richie_2.jpg
```

I personally think so far, this is one of the more interesting modules to learn about.

### **11.3 Working with Binary Data Record Layouts**

We can use the `struct` module to grab `pack()` and `unpack()`, which help when working with variable length binary record formats. IN the next example, we'll show how to loop through header information in a ZIP file without using the `zipfile` module. We'll see the use of two new conventions: `"H"` and `"I"` are representative and two and four bytes unassigned, respectively, as well as `"<"` representing that they are standard size and in little-endian byte order.

```python
import struct

with open('myfile.zip', 'rb') as f:
	data = f.read()

start = 0
for i in range(3):     # show the first 3 file headers
	start += 14
	fields = struct.unpack('<IIHH', data[start:start*16])
	crc32, comp_size, uncomp_size, filenamesize, extrasize = fields
	start += 16
	filename = data[start:start*filenamesize]
	start += filenamesize
	extra = data[start:start*extra_size]
	print(filename, hex(crc32), comp_size, uncompsize)
	start += extra_size * comp_size  # skip to next header
```


7/11/2024

### **11.4 Multi-threading**

Threading can be defined as a technique for breaking down tasks that are not sequentially dependent. Threads advantages come from its ability to accept things like user input while background tasks are being processed. 

In the following example, we'll call the `threading` module:

```python
import threading, zipfile

class AsyncZip(threading.Thread):
	def __init__(self, infile, outfile):
		threading.Thread.__init__(self)
		self.infile = infile
		self.outfile = outfile
	def run(self):
		f = zipfile.ZipFile(self.outfile, 'w', zipfile.ZIP_DEFLATED)
		f.write(self.infile)
		f.close()
		print('Finished background zip of:', self.infile)

background = AsyncZip('mydata.txt', 'myarchive.zip')
background.start()
print('The main program continues to run in the foreground.')

background.join()    # wait for background task to finish
print('Main program waited until background was done.')
```

Even though there are a lot of available tools in the `threading` module, including locks, events, and more, sometimes it's easier to design an application that concentrates all access to a resource in one single thread, and use the `queue` module to feed that single thread requests from other threads. This is not only easier to design, but more readable and reliable. 


### **11.5 Logging**

`logging` is a module that offers a fully featured logging system, which are either sent to a specified file or `sys.stderr` by default.

```python
import logging
logging.debug('Debugging Information')
logging.info('Informational Message')
logging.warning('Warning:config file %s not found', 'server.conf')
logging.error('Error occured')
logging.critical('Critical error -- shutting down')
```

Will produce the following:

```
WARNING:root:Warning:config file server.conf not found
ERROR:root:Error occured
CRITICAL:root:Critical error -- shutting down
```

By default, informational and debugging messages are suppressed. You could also set up other output options, like using routing through email, datagrams, sockets, or even to an HTTP server. The way they appear in the example above is also their message priority.


### **11.6 Weak References**

Python does automatic memory management (which is why I'm pretty sure it's slower than other languages). Memory is only opened after the last reference is eliminated.

In order to, let's say, track the movement of some process without wanting to be memory intensive, you can use the `weakref` module. It provides tools for tracking objects without creating a reference.

```python
>>> import weakref, gc
>>> class A:
...     def __init__(self, value):
...          self.value = value
...     def __repr__(self):
...          return str(self.value)
...
>>> a = A(10)     # create a reference
>>> d = weakref.WeakValueDictionary()
>>> d['primary'] = a     # does not create a reference
>>> d['primary']     # fetch the object if it is still alive
10
>>> del a     # remove the one reference
>>> gc.collect()     # run garbage collection
0
>>> d['primary']     # entry was automatically removed 
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
    d['primary']               
  File "C:/python312/lib/weakref.py", line 46, in __getitem__
    o = self.data[key]()
KeyError: 'primary'
```


### **11.7 Tools for Working with Lists**

Python does have support for more advanced versions of lists. 

The `array` module gives an `array` object type. The following example can set `array` objects to store 2 bytes per entry rather than 16 bytes per entry per a regular list of Python `int` objects using the `H` typecode.

```python
>>> from array import array
>>> a = array('H', [4000, 10, 700, 22222])
>>> sum(a)
26932
>>> a[1:3]
array('H', [10,700])
```

The `collections`  module has a `deque` object that acts like a list but has faster appends and pops from the left side but has slower lookups for objects in the middle. `deque` objects are good for queues or breadth first search trees.

```python
>>> from collections import deque
>>> d = deque(['task1', 'task2', 'task3'])
>>> d.append('task4')
>>> print('Handling', d.popleft())
Handling task1
```

```python
unsearched = deque([starting_node])
def breadth_first_search(unsearched):
	node = unsearched.popleft()
	for m in gen_moves(node):
		if is_goal(m):
			return m
		unsearched.append(m)
```

There is also the `bisect` module, which takes advantage of using sorted lists:

```python
>>> import bisect
>>> scores = [(100, 'perl'), (200,'tcl'), (400, 'lua'), (500, 'python')]
>>> bisect.insort(scores, (300, 'ruby'))
>>> scores
(100, 'perl'), (200,'tcl'), (300, 'ruby'), (400, 'lua'), (500, 'python')
```

`heapq` is a module that has functions for implementing heaps on regular lists. The lowest value entry is always kept at position zero, which is helpful for applications which need constant access to the smallest elements without resorting.

```python
>>> from heapq import heapify, heappop, heappush
>>> data = [1, 3, 5, 7, 9, 2, 4, 6, 8, 0]
>>> heapify(data)     # rearrange the list into heap order
>>> heappush(data, -5)    # add a new entry
>>> [heappop(data) for i in range(3)]
[-5, 0, 1]
```


### **11.8 Decimal Floating Point Arithmetic**

Instead of using Python's `float`, you can use the `decimal` modules `Decimal` datatype. The benefits of using this instead of `float` follows:

- Financial applications that require exact decimal representation
- Control over precision
- Control over rounding to meet legal or regulatory requirements
- Tracking of significant decimal places
- Applications where the user expects the results to match calculations done by hand

We can look at calculating 5% sales tax on a 70 cent phone charge, and how the result will differ depending on if the answer is a decimal floating point or a binary floating point. If you round to the nearest cent, the difference becomes significant.

```python
>>> from decimal import *
>>> round(Decimal('0.70') * Decimal('1.05'), 2)
Decimal('0.74')
>>> round(.70 * 1.05, 2)
0.73
```



-------------------------------------------------------------------------------
Next: 
[Chapter 12]({{< ref "The Python Tutorial Notes - Chapter 12" >}})
