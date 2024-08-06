---
aliases:
  - python
draft: false
tags:
  - computerscience
  - python
  - documentation
  - modules
title: The Python Tutorial Notes - Chapter 6
date: 2024-06-15
---
Modified: July 19 2024 

-------------------------------------------------------------------------------

## **Modules**

6/15/2024

Obviously, using local instances are not viable for long time development is not realistic. This is why we write *scripts*. 

Python has the ability to writes scripts, or another method called modules. Definitions from modules can be imported into your instance of Python. 

Main is also given a definition here: the collection of variables that you have access to in a script executed at the top level and in calculator mode.

You can write local modules by defining some basic functions on a `.py` file, then importing that file and calling them directly.

```python
# file named intro.py

def print_intro(name):
	print(f'Welcome to the game {name}!')
```

```python
import intro

username = input('What is your name? ')
intro.print_intro(username)
```

6/16/2024

### **6.1 More on Modules**

Modules can contain executable statements and function definitions.

Statements are ran the *first* time they are encountered from an `import`.

Modules have their own private namespace, which is used as the global namespace by all functions defined in said module (`modname.itemname`).

Modules can import other modules. 

It is customary to always use `import` at the beginning of a file. When placed, they are added to the modules global namespace.

You can vary the way you use an `import` to allow for selecting just a few functions, or all of them explicitly.

```python
# specific call
from intro import print_intro
print_intro()

# all items
from intro import *         # looked down upon due to low readability
print_intro()

# using a name using as
import intro as ir
ir.print_intro()
```

If you want to ensure your code your module can run as a script, you can do the following;

```python
if __name__ = "__main__":
	username = input('What is your name? ')
	print_intro(username)
```

This makes it usable as a script and an importable module, since the code that parse the command line only runs if the modules is executed as the "main" file. 


6/17/2024

When importing modules, the built-in modules are separate from the ones you bring into the environment. Let's say we have a module named `spam`. When we import `spam`, the interpreter first searches that list of built-in modules (that list is stored in `sys.builtin_module_names`). If not found, it will search for a `spam.py` in a list of directories given by `sys.path`:
 - The directory containing the input script (the current directory if not specified)
 - [`PYTHONPATH`](https://docs.python.org/3.12/using/cmdline.html#envvar-PYTHONPATH) (a list of directory names)
 - The installation-dependent default 

### **6.2 Standard Modules**

Python comes with it's own standard library with useful functions. These are described in the Python Library Reference, which I have back in the first note for this series. 

One thing they bring up is `sys`. You can edit path by using `sys.path` like so,

```python
>>> import sys
>>> sys.path.append('/ufs/guido/lib/python')
```

### **6.3 The `dir()` Function**

`dir()` is used to find out which names a module defines. 

```python
>>> import intro
>>> dir(intro)
['__name__', 'print_intro']
>>> a = [1, 2, 3, 4, 5]
>>> dir()
['__builtins__', '__name__', 'a', 'intro']
```

It ends up listing out all types of things, like variables modules, and functions.

To see the built-in functions and variables, you can use `dir(builtins)`

```python
>>> import(builtins)
>>> dir(builtins)
['ArithmeticError', 'AssertionError', 'AttributeError', 'BaseException',
 'BlockingIOError', 'BrokenPipeError', 'BufferError', 'BytesWarning',
 'ChildProcessError', 'ConnectionAbortedError', 'ConnectionError',
 'ConnectionRefusedError', 'ConnectionResetError', 'DeprecationWarning',
 'EOFError', 'Ellipsis', 'EnvironmentError', 'Exception', 'False',
 'FileExistsError', 'FileNotFoundError', 'FloatingPointError',
 'FutureWarning', 'GeneratorExit', 'IOError', 'ImportError',
 'ImportWarning', 'IndentationError', 'IndexError', 'InterruptedError',
 'IsADirectoryError', 'KeyError', 'KeyboardInterrupt', 'LookupError',
 'MemoryError', 'NameError', 'None', 'NotADirectoryError', 'NotImplemented',
 'NotImplementedError', 'OSError', 'OverflowError',
 'PendingDeprecationWarning', 'PermissionError', 'ProcessLookupError',
 'ReferenceError', 'ResourceWarning', 'RuntimeError', 'RuntimeWarning',
 'StopIteration', 'SyntaxError', 'SyntaxWarning', 'SystemError',
 'SystemExit', 'TabError', 'TimeoutError', 'True', 'TypeError',
 'UnboundLocalError', 'UnicodeDecodeError', 'UnicodeEncodeError',
 'UnicodeError', 'UnicodeTranslateError', 'UnicodeWarning', 'UserWarning',
 'ValueError', 'Warning', 'ZeroDivisionError', '_', '__build_class__',
 '__debug__', '__doc__', '__import__', '__name__', '__package__', 'abs',
 'all', 'any', 'ascii', 'bin', 'bool', 'bytearray', 'bytes', 'callable',
 'chr', 'classmethod', 'compile', 'complex', 'copyright', 'credits',
 'delattr', 'dict', 'dir', 'divmod', 'enumerate', 'eval', 'exec', 'exit',
 'filter', 'float', 'format', 'frozenset', 'getattr', 'globals', 'hasattr',
 'hash', 'help', 'hex', 'id', 'input', 'int', 'isinstance', 'issubclass',
 'iter', 'len', 'license', 'list', 'locals', 'map', 'max', 'memoryview',
 'min', 'next', 'object', 'oct', 'open', 'ord', 'pow', 'print', 'property',
 'quit', 'range', 'repr', 'reversed', 'round', 'set', 'setattr', 'slice',
 'sorted', 'staticmethod', 'str', 'sum', 'super', 'tuple', 'type', 'vars',
 'zip']
```


### **6.4 Packages**

Packages are structures that contain nested modules. You use the dot operator to access modules through subfolders. The following structure if you wanted to design your own package for uniform handling of sound files and sound data; there are many different sound files and types so they all have different utilities.

```python
sound/                          Top-level package
      __init__.py               Initialize the sound package
      formats/                  Subpackage for file format conversions
              __init__.py
              wavread.py
              wavwrite.py
              aiffread.py
              aiffwrite.py
              auread.py
              auwrite.py
              ...
      effects/                  Subpackage for sound effects
              __init__.py
              echo.py
              surround.py
              reverse.py
              ...
      filters/                  Subpackage for filters
              __init__.py
              equalizer.py
              vocoder.py
              karaoke.py
              ...
```

If you only wanted to access a certain module from the package, you could use:

```python
import sound.effects.echo

sound.effects.echo.echofilter(input, output, delay=0.7, atten=4)
```

You could also do it like this:

```python
from sound.effects import echo

echo.echofilter(input, output, delay=0.7, atten=4)
```

or even like this:

```python
from sound.effets.echo import echofilter

echofilter(input, output, delay=0.7, atten=4)
```

Each item in the dot operator context, each item must be a package except for the last item. The last item can be a module or a package but not a class or function or variable.


-------------------------------------------------------------------------------
Next: 
[Chapter 7]({{< ref "The Python Tutorial Notes - Chapter 7" >}}) 
