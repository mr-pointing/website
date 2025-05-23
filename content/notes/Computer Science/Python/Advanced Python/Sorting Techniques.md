---
aliases: 
draft: false
tags:
  - computerscience
  - python
  - sorting
  - documentation
title: Sorting Techniques
date: 2024-12-01
updated: 2024-12-07T17:39
---
[Link](https://docs.python.org/3/howto/sorting.html) to article

-------------------------------------------------------------------------------

# Sorting Basics

There are two basic ways we can ascending sort (organize from least to greatest on value) built into Python, `.sort()` on a list object, and the `sorted()` function, which takes in any iterable sequence. 

`sorted()` will actually return the sequence in order, while `.sort()` is more of a step to be done, and will actually return `None`. 

```python
>>> a = [3, 6, 1, 4]
>>> sorted(a)
[1, 3, 4, 6]
>>> a.sort()
>>> a
[1, 3, 4, 6]
```

## Key Functions

Both of the methods we looked at above have an additional parameter `key`, which takes in a function that is performed on each element within the sorted list before making any comparisons. This allows for different sorting methods; some even use lambda which is pretty cool.

```python
# Case Insensitve
>>> sorted('I\'m like, a real Loughlin Lion!'.split(), key=str.casefold)
['a', "I'm", 'like,', 'Lion!', 'Loughlin', 'real']

# Using Lambda on tuples to sort by age
>>> student_tuples = [
...     ('Leyla', 'A', 15),
...     ('Jayden', 'B', 12),
...     ('Myles', 'B', 10),
... ]
>>> sorted(student_tuples, key=lambda student: student[2])
[('Myles', 'B', 10), ('Jayden', 'B', 12), ('Leyla', 'A', 15)]

# Using Lambda to sort on named attributes
>>> class Student:
...     def __init__(self, name, grade, age):
...          self.name = name
...          self.grade = grade
...          self.age = age
...     def __repr__(self):
...          return repr((self.name, self.grade, self.age))

>>> student_objects = [
...     Student('Leyla', 'A', 15),
...     Student('Jayden', 'B', 12),
...     Student('Myles', 'B', 10),
... ]
>>> sorted(student_objects, key=lambda student: student.age)
[('Myles', 'B', 10), ('Jayden', 'B', 12), ('Leyla', 'A', 15)]
```

Using functions from the `operator` module, we can actually perform the above two examples even easier, allowing for even multiple levels of sorting;

```python
>>> from operator import itemgetter, attrgetter

# Using the student tuples from above
>>> sorted(student_tuples, key=itemgetter(2))
[('Myles', 'B', 10), ('Jayden', 'B', 12), ('Leyla', 'A', 15)]

# Using the student objects from above
>>> sorted(student_objects, key=attrgetter('age'))
[('Myles', 'B', 10), ('Jayden', 'B', 12), ('Leyla', 'A', 15)]

# Sort by grade then sort by age
>>> sorted(student_objects, key=attrgetter('grade', 'age'))
[('Leyla', 'A', 15), ('Myles', 'B', 10), ('Jayden', 'B', 12)]
```


## Descending

Simply put, if you set `reverse` to `True` in either `.sort()` or `sorted()`, you can sort in descending order versus the usual ascending order.


```python
>>> sorted(student_objects, key=attrgetter('age'), reverse=True)
[('Leyla', 'A', 15), ('Jayden', 'B', 12), ('Myles', 'B', 10)]
```


## Sort Stability

Python's sorts are called *stable* sorts, because items keep their existing order when sorted. This can allow for some complex sorts, and even things know as multi-sorts, which are just multiple sorts on top of one another. Below are some neat examples of how these can be achieved.

```python
# An example of stability; note blue's order
>>> data = [('red', 1), ('blue', 1), ('red', 2), ('blue', 2)]
>>> sorted(data, key=itemgetter(0))
[('blue', 1), ('blue', 2), ('red', 1), ('red', 2)]

# Creating a multisort function
>>> def multisort(list_to_be_sorted, specs):
...     for key, reverse in reversed(specs):
...          list_to_be_sorted.sort(key=attrgetter(key), reverse=reverse)
...     return list_to_be_sorted

>>> multisort(list(student_objects), (('grade', True), ('age', False)))
[('Myles', 'B', 10), ('Jaiden', 'B', 12), ('Leyla', 'A', 15)]
```
