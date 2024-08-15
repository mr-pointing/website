---
aliases:
  - python
draft: false
tags:
  - computerscience
  - youtube
  - python
  - classes
title: How To Use @dataclass in Python
date: 2024-07-19
---
Modified: July 19 2024 

[Link](https://www.youtube.com/watch?v=mVea6Mu15l8) to video.

-------------------------------------------------------------------------------

Can be faster than creating a regular class.

How classes are typically written:

```python
class Fruit:  
    def __init__(self, name: str, calories: float):  
        self.name = name  
        self.calories = calories  
  
  
banana = Fruit('Banana', 10)
```


We can do the same with a `dataclass`:

```python
from dataclasses import dataclass

@dataclass  
class Fruit:  
    name: str  
    calories: float  
  
banana = Fruit('Banana', 10)
```

With the first example, we wouldn't be able to print it nicely without writing a `__str__` representation, but here, we can print out `banana` and get `Fruit(name='Banana', calories=10)`, which looks much nicer. You could also set `float = 10` so that calories are set to 10 by default.

Another nice feature that `dataclass` make up for is comparison. When using the equality operator, ` ==`,  in a regular class two instances with the same content would not return `True`, since they are not the same *instance*. You could only use `isinstance()`, which would return `True` if you compared them against one another like so:

```python
banana = Fruit('Banana', 10)  
banana2 = Fruit('Banana', 10)  
print(isinstance(banana, Fruit) == isinstance(banana2, Fruit))
```

However, this isn't very pretty, and they are just checking if they are both an instance of the same class.

We can achieve this with `dataclass`:

```python
banana = Fruit('Banana', 10)  
banana2 = Fruit('Banana', 10)  
print(banana == banana2)
```
\
Another way we could achieve this with regular classes is by writing an `__eq__` method, like so:

```python
def __eq__(self, other):
	return self.__dict__ == other.__dict__
```

With such a basic example its hard to argue over writing a few extra lines. However, when the class gets more complex, I could see using `dataclass` to be more useful.

If we set the `frozen` attribute of a `dataclass` decorator to `True`, it will make the class read only, not allowing for modifications. Dataclasses allow for the same dot operator modifications as normal classes.

Each time you create a class or data class, Python makes a dictionary for that class for it easier to grab attributes. Slots are a good idea to implement to avoid having to recreate it every time we make a new instance of the class. We use the `__slots__` method when creating our data class. We can't use default values when using slots, and must use list formatting:

```python
@dataclass
class Fruit:
	__slots__ = ['name', 'calories']

	name: str
	calories: float
```

We'll now have faster attribute access and should also reduce usage of RAM.

After Python 3.10, we could achieve the same as above even simpler:

```python
@dataclass(slots=True)
class Fruit:
	name: str
	calories: float
```

If you want to change the `string` or `repr` representation, you can always overwrite them using the appropriate `__str__`, or `__repr__` method.

If you use the `kw_only` attribute in your `dataclass`, you'll only be able to assign values via keywords only.

```python
@dataclass(kw_only=True)
class Fruit:
	name: str
	calories: float
	def __str__(self):
		return f'{self.name}: {self.calories} calories'
```

