---
aliases:
  - python
draft: true
tags:
  - computerscience
  - python
  - documentation
  - classes
title: The Python Tutorial Notes - Chapter 9
date: 2024-06-28
---
Modified: July 19 2024 

-------------------------------------------------------------------------------

## **Classes**

6/28/2024

Classes combine data storage and functionality into one package. When you make a new class, you are making a new *type* of object. A new *instance*, or occurrence of that type are able to be made using function call of the class.

A class is made up of attributes and methods defined by the classes definition. 

Python classes follow closely to other Object Oriented Programming languages classes in the following ways:
- Class inheritance allows multiple base classes
- Derived classes can override any methods of its base class or classes
- Methods can call the method of a base class with the same name

Classes follow the dynamic nature of Python: created at runtime, and can be modified further after initialization.

### **9.1 A Word on Names and Objects**

Objects have individuality, and have multiple names across multiple scopes that can be bound to the same object, otherwise known as aliasing in other languages. 


### **9.2 Python Scopes and Namespaces**

*Namespace* is the mapping from names to objects. Within Python they are stored as dictionaries. The most important thing to understand is that there is no relation between names in a different namespace; two different modules can define a function called `maximize`, but since you have to use a prefix to call which `maximize` you'd like, there is no confusion. 

Going forward, *attribute* is going to be used to define anything belonging to that class that would following a dot operator. That would be any value or method. There is a direct mapping between the module's attributes and the global names defined in the module; they share the same namespace.

Attributes are read-only or writable. Assignment is possible: 

```python
>>> modname.the_answer = 42
>>> print(modname.the_answer)
42
>>> del modname.the_answer
>>> print(modname.the_answer)
Traceback (most recent call last):
  File "<stdin>", line 4, in <module>
AttributeError: 'modname' object has no attribute 'the_answer'
```

Namespaces are generally created at different points and have different lifespans. The namespace for built-in names is created when the interpreter starts for example, and as we know the namespace for a module starts when the line is executed. 

Global namespaces and module namespaces last until the end of the program. For more local instances like a function, the local namespace is created when the function is called, and eventually deleted when the function returns or raises and exception not handled by the function. 

We can define a *scope* as the textual region of a program where a namespace is directly accessible; basically, you can access something without having to use a prefix for another namespace. 

When searching for an object, the scopes are used dynamically: Namespaces are searched for in this order:
1. The innermost scope, which is searched first, containing local names
2. The scopes of any enclosing functions, which are searched starting with the nearest enclosing scope that contains non-local, but also non-global names
3. The next-to-last scope contains the current module's global names
4. The outermost scope is the namespace containing built-in names

If a name is declared as global, it joins the outermost scope. We can use the `nonlocal` statement to rebind variables found outside of the innermost scope.

We say local scope references local names of the current function. Outside functions, the local scope references the same namespace as the global scape: the module's namespace.

If there is no `global` or `nonlocal` statement, assignments default to the innermost scope. Assignments don't copy data, they bind names to objects. 

```python
def scope_test():
	def do_local():
		spam = "local spam"
	def do_nonlocal():
		nonlocal spam
		spam = "nonlocal spam"
	def do_global():
		global spam
		spam = "global spam"
	
	spam = "test spam"
	do_local()
	print("After local assignment:", spam)
	do_nonlocal()
	print("After nonlocal assignment:", spam)
	do_global()
	print("After global assignment:", spam)

scope_test()
print("In global scope:", spam)
```

will result in the following output:

```
After local assignment: test spam
After nonlocal assignment: nonlocal spam
After global assignment: nonlocal spam
In global scope: global spam
```

\
### **9.3 A First Look at Classes**

A basic class definition can look like this:

```python
class ClassName:
	<statement-1>
	.
	.
	.
	<statement-N>
```

Just like functions, they should obviously be defined before they are used.

When a new class definition is entered, a new namespace is created, and used as the classes local scope. All assignments to local variables go into this new namespace. 

A class object is essentially a wrapper around the contents of the namespace created by the class definition. 

7/1/2024

Objects in classes support two kinds of operations: attribute references and instantiation.

Attribute reference is similar to other objects in Python as far as syntax: `obj.name`. Whatever names were used in the classes definition are considered these attribute references:

```python
class MyClass:
	"""A simple example class"""
	i = 12345
	def f(self):
		return 'no justice! no peace!'
```

In the above example, `MyClass.i` and `MyClass.f` are valid attribute references, returning an integer and a function object, respectively. I swear, I type some of this out, then read it, and it's the same thing. 

Class attributes can be assigned to, so something like the following is legal:

```python
MyClass.i = 10
``` 

The triple quotes sets the `__doc__` attribute for the class, and is also good practice to use it for explaining function processes.

Class instantiation, or creating the instance of a class, uses function notation:

```python
x = MyClass()
```

This will create an empty object, of type `MyClass`.  In order to specify how we want our instance object to act when created, we can use the `__init__()` method in our class definition:

```python
def __init__(self):
	self.data = []
```

When we use this `__init__` statement, we can start to make our class objects more complex, see below:

```python
>>> class Complex:
... 	def __init__(self, realpart, imagpart):
... 		self.r = realpart
... 		self.i = imagpart
...
>>> x = Complex(3.0, -4.5)
>>> x.r, x.i
(3.0, -4.5)
```

With instance objects, the only operations understood are by attribute references. Two major kinds of valid attribute names: data attributes and methods.

Data attributes are like local variables, they don't need to be declared prior. They come into existence when assigned too. We can create whole new variables in those instances, without worrying about them having to exist inside the class. For example, using the `x` object we instantiated in the prior example:

```python
x.counter = 1
while x.counter < 10:
	x.counter = x.counter * 2
print(x.counter)
del x.counter
```

This will print 16 without any issue.

The other instance attribute reference is a method. A method is just a function that "belongs to" an object.

Here's a deeper dive look; `x.f` is a valid method reference, since `MyClass.f` is a function. `x.i` is not, since `MyClass.i` is not. However, `x.f` is not the same thing as `MyClass.f`, it is a method object, not a function object.

7/2/2024

Quick note about method objects: they are usually just used, but can also be stored. In the example below, we can see using a regular class method as well as storing it inside a variable.

```python
>>> x.f()
no justice! no peace!
>>> xf = f()
>>> while True:
...     print(xf())	
no justice! no peace!
no justice! no peace!
no justice! no peace!
# repeats forever
```

Even though in the above syntax for defining the `f()` method, we use the word `self` which might make you think we should have passed a parameter when we used it. Actually, what `self` is referring too is the specific instance in which you are using the method: the above call `x.f()` is equivalent to `MyClass.f(x)`.

The above scenario can be explained as so, that I'm both paraphrasing and quoting from the doc: When a method is called from an instance usage, the class is searched for that function object. If found, it packages references to the function object and the instance object as a new method object. When this method object is called with an argument list, a brand new argument list is made from the instance object and the original argument list, and the function object is called with that new argument list. 

Kind of confusing, but also shouldn't be so complicated when you draw it out.

*Class variables* are variables that are shared by all instances of a class, while *instance variables* are variables that only exist within the instance of that individual class.

```python
class Dog:
	kind = 'canine'                  # class variable
	def __init__(self, name):        
		self.name = name             # instance variable
```


In the above example, something like a dictionary that holds the tricks a dog can do, lets call it `tricks`, shouldn't be shared by all dogs, since not all dogs know the same tricks.

```python
class Dog:
	def __init__(self, name):
		self.name = name
		self.tricks = []
	def add_trick(self, trick):
		self.tricks.append(trick)
```

In the above example, we don't need to pass tricks as a parameter since we can just make an empty list and set it in the initialization of the instance. We also made a function that can add whatever tricks that dogs know into it, letting us access it. Notice how the function needs to pass itself in order to ensure it can be accessed by each independent instance of the class.

```python
>>> b = Dog('Buddy')
>>> p = Dog('Pugsley')
>>> b.add_trick('play dead')
>>> p.add_trick('sit')
>>> b.tricks
['play dead']
>>> p.tricks
['sit']
```


### **9.4 Random Remarks**

If the same name is reference in both the instance and the class, the attribute lookup will prioritize the instance of it. 

```python
>>> class Dog:
... 	kind = 'canine'
...
>>> cat = Dog()
>>> print(cat.kind)
canine
>>> cat.kind = 'feline'
>>> print(cat.kind)
feline
```

Data attributes may be reference by methods as well as by clients of an object.

Clients should always use data attributes with care, since they could mess up invariants. 

There is no shorthand for referencing data attributes from within methods. In the below example, `counter` exists twice: as a class variable, an instance variable.

We also see that methods can call other methods just by using the `self` argument.

```python
class MyClass:
	counter = 0
	def adder(self):
		self.counter += 1
		MyClass.counter += 1
	def adder_again(self):
		self.adder()
		self.adder()
```

Methods can reference global names in the same ways ordinary functions can. The global scope associated with a method is the module containing its definition.

Each value is an object, and therefore has a class (or type). It is stored as `object.__class__`.

### **9.5 Inheritance**

Like many other languages, classes accept inheritance. Essentially, the new class takes in all of the attributes of the base class. The syntax is as follows:

```python
class DerivedClassName(BaseClassName):
	<statement-1>
	.
	.
	.
	<statement-n>
```

If you need to use a class from another module, you can do it like this:

```python
class DerivedClassName(modname.BaseClassName)
```

7/3/2024

When discussing attribute references, if a requested attribute is not found in the instantiated class, the search then goes to look in the base class. The rule is applied recursively if the base class is a derived class.

Derived classes can override methods of the base class. An overriding method also might just want to extend the base classes method, rather than replace it. To use the original base class method, you can always just use `BaseClassName.methodname(self, arguments)`.

Python has two built-in functions that work with inheritance:
1. `isinstance()`: checks an instances' type:
	1. `isinstance(obj, int)` will only be `True` if `obj.__class__` is `int` or a class derived from `int`.
2. `issubclass()`: checks class inheritance
	1. `issubclass(bool, int)` is `True` since `bool` is a subclass of `int`.
	2. `issubclass(float, int)` is `False` since `float` is not a subclass of `int`.

You can use multiple inheritance as well in Python:

```python
class DerivedClassName(Base1, Base2, Base3):
	<statement-1>
	.
	.
	.
	<statement-N>
```

The attribute search in this situation would search the derived class, then base 1, then recursively through base 1's base classes, then to each other base class. 

7/4/2024

### **9.6 Private Variables**

The "normal" private variables other languages have, that exist in an instance and cannot be accessed except from inside that object don't exist within Python. There is a followed convention however, where you lead the private variable with an underscore and that variable should be treated as a non-public part of the API.

You could also use two underscores before, which replaces the text from `__spam` to `_classname__spam` where `classname` is the current class name with leading underscores stripped. This is called *name mangling*. Name mangling can be helpful by letting subclasses override methods without breaking interclass method calls.

```python
class Mapping:
	def __init__(self, iterable):
		self.items_list = []
		self.__update(iterable)
	def update(self, iterable):
		for item in iterable:
			self.items_list.append(item)
	__update = update           # private copy of the original update()                                    method
class MappingSubclass(Mapping):
	def update(self, keys, values):
		# provides new signature for update()
		# but does not break __init__()
		for item in zip(keys, values):
			self.items_list.append(item)	
```


### **9.7 Odds and Ends**

Similar to C's `struct`, Python has `dataclasses`, in order to bundle together a few named data items.

```python
from dataclasses import dataclass

@dataclass
class Employee:
	name: str
	dept: str
	salary: int
```

```python
>>> richie = Employee('richie', 'computers', 101)
>>> richie.dept
computers
>>> richie.salary
101
```

Instance methods objects also have attributes. `m.__self__` is the instance object with the method `m()`, and `m.__func__` is the function object corresponding to the method. 

### **9.8 Iterators**

Most container objects can be looped over using a `for` statement:

```python
for element in [1, 2, 3]:
	print(element)
for element in (1, 2, 3,):
	print(element)
for key in {'one':1, 'two':2}:
	print(key)
for char in '123':
	print(char)
for line in open('myfile.txt'):
	print(line, end='')
```

This is a prevalent structure in Python. Behind the scenes, `for` is calling the `iter()` method on the container object. That function returns an iterator object that defines the method `__next__()`, which accesses elements in the container one at a time. When there are no more elements,  `__next__()` raises a `StopIteration` exception which tells the `for` loop to terminate. The below code exemplifies this:

```python
>>> s = 'abc'
>>> it = iter(s)
>>> it
<str_iterator object at 0x10c90e650>
>>> next(it)
'a'
>>> next(it)
'b'
>>> next(it)
'c'
>>> next(it)
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
   next(it)
StopIteration
```

You can even add your own iterator behavior to your own classes. If you define a `__iter__()` method, which will return an object with a `__next__()` method. If the class defines `__next__()`, then `__iter__()` can return `self`:

```python
class Reverse:
	"""Iterator for looping over a sequence backwards"""
	def __init__(self, data):
		self.data = data
		self.index = len(data)
	def __iter__(self):
		return self
	def __next__(self):
		if self.index == 0:
			raise StopIteration
		self.index = self.index - 1
		return self.data[self.index]
	
```

```python
>>> rev = Reverse('spam')
>>> iter(rev)
<__main__.Reverse object at 0x09012498>
>>> for char in rev:
...     print(char)
...
m
a
p
s
```

Printing the object `rev` would just print `spam` without any reversing. The reversing happens when iterating through the object. 


### **9.9 Generators**

Generators are simple tools to create iterators. The are written like regular functions except use the `yield` statement to return data. 

```python
def reverse(data):
	for index in range(len(data)-1, -1, -1):
		yield data[index]
```

```python
>>> for char in reverse('golf'):
... print(char)
...
f
l
o
g
```

Generators are basically the same as the iterator class we made with a built-in `__iter__()` and `__next__()` methods created automatically. Local variables and execution states are also automatically saved between calls, making the functions easier to write/read without instance variables like `self.index` and `self.data`.


### **9.10 Generator Expressions**

Some generators can be made using a syntax similar to list comprehension but instead of square brackets, you use parentheses. They are more memory friendly but obviously, less versatile than full generator definitions. 

```python
>>> sum(i*i for i in range(10))
285

>>> xvec = [10, 20, 30]
>>> yvec = [7, 5, 3]
>>> sum(x*y for x,y in zip(xvec, yvec))
260

>>> unique_words = set(word for line in page for word in line.split())

>>> valedictorian = max((student.gpa, student.name) for student in graduates)

>>> data = 'golf'
>>> list(data[i] for i in range(len(data)-1, -1, -1))
['f', 'l', 'o', 'g']
```



-------------------------------------------------------------------------------
Next: 
[Chapter 10]({{< ref "The Python Tutorial Notes - Chapter 10" >}})
