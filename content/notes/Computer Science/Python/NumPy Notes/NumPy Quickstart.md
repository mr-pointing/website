---
aliases: 
draft: false
tags:
  - computerscience
  - python
  - documentation
  - datastructures
title: NumPy Quickstart
date: 2024-09-30
updated: 2024-09-30T18:00
---
[Link](https://numpy.org/doc/stable/user/quickstart.html) to documentation.

-------------------------------------------------------------------------------

# Prerequisites

What should you know to get the most out of this lesson? At the very least, the fundamentals of Python. You should also refer to [this]({{< ref "What is NumPy" >}}) to get a fundamental understanding of the reasons why we'd want to use `ndarray` in the first place.

What are we doing this lesson then? We're going to learn about what one, two, and $n$ dimensional arrays actually are, some algebra operations on `ndarray` objects *without* `for` loops, and even more advanced things like what axis and shape properties are.


# Basics

We know that the multidimensional array object, `ndarray`, is the core of NumPy. An alias it is just `array`, which might be confusing, so I'll try my best not to confuse them with Python's built-in `array` type.

`ndarray` has a few major attributes that we'll either look at directly or is commonly used:

- `ndarray.ndim`: returns the number of *axes* or dimensions or the array
- `ndarray.shape`: returns the dimensions of the array in tuple form indicating the size of the array in each dimension; where `n` are rows and `m` are columns, `shape` returns `(n,m)`
- `ndarray.dtype`: returns the type of elements in the array
- `ndarray.itemsize`: returns the size (in bytes) of each element in the array
- `ndarray.data`: contains the actual elements of the array but is rarely used due to array indexing

```python
>>> import numpy as np
>>> a = np.arange(15).reshape(3, 5)
>>> a
# array of 0 to 14 in 3x5 array structure
>>> a.shape
(3, 5)
>>> a.ndim
2
>>> a.dtype.name
'int64'
>>> a.itemsize
8
>>> a.size
15
>>> type(a)
<class 'numpy.ndarray'>
>>> b = np.array([6, 7, 8])
>>> b
array([6, 7, 8])
>>> type(b)
<class 'numpy.ndarray'>
```

## Array Creation

As we just saw in the example above, we were able to create an array in two different ways. The first, through `arange()`, and the second through `array()`. 

Our syntax for `arange()` is extremely similar to `range()`: `arange(start, stop, step)`. One method we also should know about is the `.reshape(x, y)` method, which reformats your array into an `x`x`y` dimensional array. When using `arange()`, you need to make sure you have a valid amount of data for the size of your array.

You can also use `array(x)`, where `x` is a valid list or tuple. Below are some examples on how to use the creation in some creative ways:

```python
>>> a = np.array([1, 2, 3])
>>> b = np.array([(4,5,6), (7,8,9)], dtype=float)
```

Another way, for the sake of creating quick test arrays, you can easily make arrays filled with zeros or ones.

```python
>>> c = np.zeros((3, 4))
>>> d = np.ones((2, 3, 4), dtype=np.int64)
>>> e = np.empty((2, 3))
```

## Printing Arrays

Printing arrays is a breeze. There are some unique conventions that you can read about in the docs- the arrangement of the array isn't so relevant to work I do every day, so I don't feel so inclined to dive deeper. 

I'd say experiment with using the `print()` statement with your arrays and see what you get. More often than not you'll retrieve the array in whichever dimensions you've set it too, unless your array is large enough, in which case it will cut out the middle and return only the corners. You can turn this off however if you're dead set on getting the entire array.

## Basic Operations
