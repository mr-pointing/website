---
aliases:
  - python
draft: false
tags:
  - computerscience
  - python
  - documentation
  - datastructures
title: The Python Tutorial Notes - Chapter 5
date: 2024-06-10
---
Modified: July 19 2024 

-------------------------------------------------------------------------------

## **Data Structures**

6/10/2024

### **5.1 More on Lists**

Methods for Lists:
- `list.append(x)`
	- Adds an item to the end of the list
	- Equivalent to `a[len(a):] = [x]` 
- `list.extend(iterable)`
	- Extend the list by appending all items from an iterable
- `list.insert(i, x)`
	- Insert an item into a given position, where `i` is the index location and `x` is the value
- `list.remove(x)`
	- Remove the first item from the list whose value is equal to `x`, `ValueError` if no such item
- `list.pop([i])`
	- Remove the item at the given position in the list, and return it. Without an index, it will remove and return the last item in the list. `IndexError` if the list is empty or the index is out of the list range
- `list.clear()`
	- Remove all items from the list. Equivalent to `del a[:]`
- `list.index(x[, start[, end]]`
	- Return zero-based index from the value `x`. `ValueError` if `x` does not exist.
	- Parameters interpreted as slices from the list in `[]` format
- `list.count(x)`
	- Return the number of times `x` appears in the list
- `list.sort(*, key=None, reverse=False)`
	- Sort the items of the list in place
	- Arguments used for sort customization
	- `key` can be set to things like `key=str.lower` 
	- There's a good [doc](https://docs.python.org/3.12/howto/sorting.html#sortinghowto) on sorting I want to go over later
- `list.reverse()`
	- Reverse the elements of the list in place
- `list.copy()`
	- Return a copy of the list
	- Same as `a[:]`

```python
>>> cats = ['Atticus', 'Peaches', 'Aphrodite', 'Aphrodite']
>>> cats.count('Peaches')
1
>>> cats.count('Shroomie')
0
>>> cats.index('Aphrodite')
2
>>> cats.index('Aphrodite', 2)
3
>>> cats.reverse()
>>> cats
['Aphrodite', 'Aphrodite', 'Peaches', 'Atticus']
>>> cats.append('David')
>>> cats
['Aphrodite', 'Aphrodite', 'Peaches', 'Atticus', 'David']
>>> cats.sort()
['David', 'Aphrodite', 'Aphrodite', 'Atticus', 'Peaches']
>>> cats.pop()
'Peaches'
```


Methods like `insert`, `remove` or `sort` modify the list and actually return `None`.

Not all data can be sorted or compared; integers cannot be compared to strings and `None` can't be compared to other types.

List methods make it easy to use as a **Stack**. Last element added is the first element retrieved, **last-in, first-out.** `append()` adds directly to the end of the list, and `pop()` retrieves and removes the last element.

You can also use a list as a **Queue**, where the first element added is the first element retrieved, **first-in, last-out**. They aren't very efficient at it though. You can use `collections.deque` to replicate it though.

```python
>>> from collections import deque
>>> queue = deque(['Adam', 'Eve', 'Steve'])
>>> queue.append('God')
>>> queue.append('Satan')
>>> queue.popleft()
'Adam'
>>> queue.popleft()
'Eve'
>>> queue
dequ(['Steve', 'God', 'Satan'])
```


**List Comprehension** is an easier way to create lists using shortened syntax. If you have some sort of iteration that needs to happen, whether modified or not, you can easily make new lists using such info.

```python
>>> squares = []
>>> for x in range(10):
>>> 	squares.append(x**2)
>>> squares
[0, 1, 4, 9, 16, 25, 36, 49, 64, 81]
```

We can achieve the same with either

```python
squares = list(map(lambda x: x**2, range(10)))
squares = [x**2 for x in range(10)]
```

The latter is clearly, more readable and easier to understand.

You can add conditionals, and even complicated structures:

```python
>>> from math import pi
>>> [str(round(pi, i)) for i in range(1, 6)]
['3.1', '3.14', '3.142', '3.1416', '3.14159']
>>> vec = [-4, -2, 0, 2, 4]
>>> [x for x in vec if x >= 0]
[0, 2, 4]
```


### **5.2 The `del` statement**

To delete an item from a list based on it's index instead of it's value, we can use the `del` statement. Instead of `pop()` which returns a value, `del` can remove slices and even clear a list. It can also delete entire variables

```python
>>> a = [69, 420, 6969, 4200]
>>> del a[0]
>>> a
[420, 6969, 4200]
>>> del a[0:]
>>> a
[420]
>>> del a
```


### **5.3 Tuples and Sequences**

Tuples are a sequence type, along with list and range. Tuples consist of any number of values separated by a comma. They can be nested, and are *immutable*, which means they cannot be altered once made. They can however, contain items that are mutable. 

```python
>>> t = 123, '360 no scope', 420
>>> t[0]
123
>>> t
(123, '360 no scope', 420)
>>> u = t, 69
>>> u
>>> ((123, '360 no scope', 420), 69)
>>> t[0] = 456
Traceback (most recent call last):
  File "<stdin>", line 1, in <module>
TypeError: 'tuple' object does not support item assignment
>>> v = ([1,2,3],[4,5,6])
```


6/14/2024

Even though they are similar to lists, we use them for different purpose. Mostly this is the case because of the immutability of the tuple versus the list. When you need to store a value that doesn't need to change and is in some specific order, tuple over list makes sense. The only thing you must do is if you have only one item, you must leave a comma after the value, regardless of there not being anything following it. Empty parenthesis are okay for an empty tuple. 

A fun thing you can do with tuples is unpack them, like so,

```python
>>> t = "hello", 123, 456
>>> x, y, z = t
>>> x
"hello"
>>> y
123
>>> z
456
```


### **5.4 Sets**

Sets are unordered, no-duplicate collection of elements. Use cases are membership testing(?) and eliminating duplicate entries. Sets also support math operations like union, intersection, difference, and symmetric difference.

```python
>>> bag = {'sword', 'potion', 'potion', 'spell', 'axe', 'spell'}
>>> print(bag)
{'sword', 'potion', 'spell', 'axe'}
>>> 'axe' in bag
True
>>> 'wand' in bag
False

>>> a = set('abracadabra')
>>> b = set('alakazam')
>>> a
{'a', 'r', 'b', 'c', 'd'}                       # sets are naturally unordered
>>> a - b
{'r', 'd', 'b'}                                 # letters in a but not in b
>>> a | b
{'a', 'c', 'r', 'd', 'b', 'm', 'z', 'l'}        # letters in a or b or both
>>> a & b
{'a', 'c'}                                      # letters in both a and b
>>> a ^ b
{'r', 'd', 'b', 'm', 'z', 'l'}                  # letters in a or b but not both

>>> a = {x for x in 'abracadabra' if x not in 'abc'}
>>> a
{'r', 'd'}
```


### **5.5 Dictionaries**

Dictionaries are comparable to other languages "associative arrays". Basically, a key, value pair. Unlike sequences where index determines location, that key is your index. 

Keys can be numbers, strings, tuples (as long as there are no mutable structures inside), and lists (you can mutate the list via `.append()` or `.extend()`).

```python
>>> tel = {'jack': 4098, 'baki': 4139}
>>> tel['yujiro'] = 4127
>>> tel
{'jack': 4098, 'baki': 4139, 'yujiro': 4127}
>>> tel['baki']
4139
>>> del['jack']
>>> tel['retsu'] = 4127
>>> tel
{'baki': 4139, 'yujiro': 4127, 'retsu': 4127}
>>> list(tel)
['baki', 'yujiro', 'retsu']
>>> sorted(tel)
['baki', 'retsu', 'yujiro']
>>> 'baki' in tel
True
>>> 'retsu' not in tel
False

# dict() constructor
>>> dict([('baki', 4120), ('retsu', 0909)])
{'baki': 4120, 'retsu': 0909}

# dict comprehension
>>> {x:x**2 for x in (2, 4, 6)}
{2: 4, 4: 16, 6: 36}

# using keyword arguments
>>> dict(baki=123, yujiro=456, retsu=999)
{'baki': 123, 'yujiro': 456, 'retsu': 999}
```

### **5.6 Looping Techniques**

When looping through dictionaries, you can use the `items()` method to get both the key and the value.

```python
>>> knights = {'Arthur': 'The Giant Douche', 'Robin': 'The Turd Sandwich'}
>>> for k, v in knights.items()
		print(k, v)

Arthur The Giant Douche
Robin The Turd Sandwich
```

When looping through a sequence, the position of index and corresponding value can be obtained at the same time using `enumerate()`.

```python
>>> for i, v in enumerate(['la', 'ti', 'da']):
>>> 	print(i, v)
>>
0 la
1 ti
2 da
```

To loop over two or more sequences at the same time, you can use the `zip()` function.

```python
>>> questions = ['name', 'purpose', 'motto']
>>> answers = ['lancelot', 'slay dragons', 'get money']
>>> for q, a in zip(questions, answers):
>>> 	print('What is your {0}? It is{1}.'.format(q, a))
>>
What is your name? It is lancelot.
What is your purpose? It is slay dragons.
What is your motto? It is get money.
```

To loop over a sequence in reverse, use the `reversed()` function.

```python
>>> for i in reversed(range(1, 10, 2)):
>>> 	print(i)
>>
9
7
5
3
1
```

To loop over a sequence that is sorted, use the `sorted()` function. You can combine that with `set()` to go through a sorted list of unique values.

```python
>>> friends('yujiro', 'baki', 'baki', 'baki')
>>> for f in sorted(set(friends)):
>>> 	print(f)
>>
baki
yujiro
```

It is usually better to create a new list than sort and manipulate over an existing list.


6/15/2024

### **5.7 More on Conditionals**

Conditions used in `while` and `if` statements can contain any operators, not just comparisons. 

`in` and `not in` are membership tests that determine if a value is in or not in some container (sequence, iterable). They can also compare if two objects are the same object or not.

Comparisons can also be chained: `a < b == c` will test whether `a` is less than `b` and moreover `b` equals `c`.  They can be combined using `and` or `or`. 

`and` and `or` are *short-circuit* operators; meaning their arguments are evaluated from left to right and evaluation stops when a condition is met. IF `a` and `c` are true, but `b` is false, `a and b and c` does not evaluate `c`.

```python
>>> string1, string2, string3 = '', 'Dio', 'Kars'
>>> non_null = string1 or string2 or string3
>>> non_null
'Dio'
```


### **5.8 Comparing Sequences and Other Types**

Sequence objects are usually only compared to other objects with the same sequence type. They are compared using *lexicographical* ordering; one item is compared directly against another, and so on until potential matches are exhausted. 

-------------------------------------------------------------------------------
Next: 
[Chapter 6]({{< ref "The Python Tutorial Notes - Chapter 6" >}})
