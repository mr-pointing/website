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

Using arithmetic operators on arrays will actually perform the math on the *elements* rather than the array itself. We call this *elementwise*. Here's a basic example:

```python
>>> import numpy as np
>>> a = np.array([20, 30, 40, 50])
>>> b = np.arange(4) # makes array([0, 1, 2, 3])
>>> c = a - b
>>> c
array([20, 29, 38, 47])
>>> b ** 2
array([0, 1, 4, 9])
>>> a < 35
array([True, True, False, False])
```

There is another operation called *matrix product* using the `@` sign, but that's too advanced for what we're doing. 

You can see from the above examples that we're actually creating new arrays when we're performing these operations. In order to actually modify existing arrays, we could use something like `+=` or `*=`:

```python
>>> a = np.ones((2, 3), "int64")  
>>> b = np.array([1, 2, 3], [4, 5, 6], "int64")
>>> a += b
>>> a
[[2 3 4]
 [5 6 7]]
```

Notice that we defined our data type. Had we declared differing data types, we would actually get an error when trying to perform the operation. Like we already know from the last lesson, you cannot perform operations on unlike datatypes.

However, if we didn't specify one of them, and set the other to `float64` instead of an `int64`, NumPy will actually *upcast* the integer into a float. 

NumPy arrays have some pretty useful methods we can access via the dot operator: 

```python
>>> rg = np.random.default_rng(1)
>>> a = rg.random((2, 3))
>>> a
[[0.51182162 0.9504637  0.14415961]
 [0.94864945 0.31183145 0.42332645]]
>>> a.sum()
3.290252281866131
>>> a.min()
0.14415961271963373
>>> a.max()
0.9504636963259353
```


The first line here is actually somewhat special. It's acts like a random number generator, creating a number between 0 and 1. Then, we can use it to create the arrays used in the example. NumPy actually has it's own `random` module which we can use just like we do above. 

## Universal Functions

There are some mathematical functions that are automatically packaged with NumPy. The list is comprehensive, so rather than try to go over all of them right now, you can view them all [here](https://numpy.org/doc/stable/user/quickstart.html#universal-functions).


## Indexing, Slicing, & Iterating

One-dimensional arrays can be indexed and sliced through the same ways that a regular Python list can be. Nothing too complicated there. It becomes more complicated once we start introducing more dimensions:

```python
>>> a = np.array([10, 11, 12], [46, 47, 48], [73, 74, 75])
>>> a[0]
[10, 11, 12]
>>> a[1]
[46, 47, 48]
>>> a[0][1]
11
>>> a[1:]
[[46 47 48]
 [73 74 75]]
>>> a[2, 2] # equivalent to using a[2][2]
75
>>> a[:, 1] # returns all the elements in the second column
[11, 47, 74]
```

There's a little more nuance to it; I recommend reading the documentation if you're interested. Otherwise, play around with a few different indexes and see what you get.

Iterating over the elements within an array can be done in two ways, over the rows or through each element using the `.flat` attribute:

```python
>>> for row in a:
...    print(row)
...
[10 11 12]
[46 47 48]
[73 74 75]
>>> for element in a.flat:
...    print(element)
...
10
11
12
46
47
48
73
74
75
```


# Shape Manipulation


## Changing the Shape of an Array

When we talk about the shape of the array, we are talking about how many rows it has by the amount of elements in each row.

For our above example, `a`, we can get the shape by printing the `.shape` attribute for your array:

```python
>>> a.shape()
(3, 3)         # 3 rows x 3 elements
# Let's say we add [111, 112, 113] to our array
>>> a.shape()
(4, 3)         # 4 rows x 3 elements
```

There are many different ways we can alter the shape of our array, depending on what we're trying to do. We can flatten it (return all elements as a single dimensional array), reshape it (change the shape and layout of the data) and transpose (rows and columns are flipped).

```python
>>> a.ravel()
[ 10  11  12  46  47  48  73  74  75 111 112 113]
>>> a.reshape(3, 4)
[[ 10  11  12  46]
 [ 47  48  73  74]
 [ 75 111 112 113]]
>>> a.T
[[ 10  46  73 111]
 [ 11  47  74 112]
 [ 12  48  75 113]]

```

An important distinction being made is that these arrays are not being reshaped back into the array, but returns a whole new array.


## Stacking Together Different Arrays

Often, you'll want to actually combine different arrays together, but not necessarily do any calculations. Stacking can help with that. There are a few different ways to stack, but we're just going to look at 2 common stack methods: vertical and horizontal.

```python
# Make use of rng to make two arrays
>>> rg = np.random.default_rg(1)
>>> a = np.floor(10 * rg.random((2, 2)))
>>> a
[[5. 9.]
 [1. 9.]]
>>> b = np.floor(10 * rg.random((2, 2)))
>>> b
[[3. 4.]
 [8. 4.]]
>>> np.vstack((a, b))
[[5. 9.]
 [1. 9.]
 [3. 4.]
 [8. 4.]]
>>> np.hstack((a, b))
[[5. 9. 3. 4.]
 [1. 9. 8. 4.]]
```

## Splitting into Smaller Arrays

Not only can we combine arrays, we can break down arrays into smaller arrays. The ways we can do so are using `hsplit` or `vsplit`, which will split it horizontally or vertically respectfully.

```python
>>> a = np.floor(10 * rg.random((2, 12)))
>>> a
[[5. 9. 1. 9. 3. 4. 8. 4. 5. 0. 7. 5.]
 [3. 7. 3. 4. 1. 4. 2. 2. 7. 2. 4. 9.]]
>>> np.hsplit(a, 3)
[array([[5., 9., 1., 9.],
       [3., 7., 3., 4.]]), array([[3., 4., 8., 4.],
       [1., 4., 2., 2.]]), array([[5., 0., 7., 5.],
       [7., 2., 4., 9.]])]
>>> np.vsplit(a, 2)
[array([5., 9., 1., 9., 3., 4., 8., 4., 5., 0., 7., 5.]), array([3., 7., 3., 4., 1., 4., 2., 2., 7., 2., 4., 9.])]
```

Horizontal split is dictated by the amount of columns, while vertical split is dictated by the arrays row count. If you try to split into an indivisible amount, it will break.


# Copies and Views

Up until now, I've briefly mentioned how new arrays are generated from some of the functions we've used. Now, let's get a more formal definition for exactly what happens in each Scenario.

## No Copy

When doing basic assignments, there are no copies made of the array. In the example below we have an array, `a`, and we make `b` as a reference to `a`. There is only *one* array, and `a` and `b` reference it at the same time.

```python
>>> a = np.array([[0, 1, 2, 3],
...               [4, 5, 6, 7],
...				  [8, 9, 10, 11]])
>>> b = a     # no new object is made
>>> b is a    
True
```


## View or Shallow Copy

We can use `view` to make a new array object that looks at the same data. We can change the *shape* of our view and the original array won't change, but if we edit any values of the created array, the values in the original array will change.

```python
# Using a from the previous example
>>> c = a.view()
>>> c is a
False
>>> c = c.reshape((2, 6))
>>> a.shape
(3, 4)
>>> c[0, 4] = 1234
>>> a
array([[   0,    1,    2,    3],
       [1234,    5,    6,    7],
       [   8,    9,   10,   11]])
```


## Deep Copy

In the instance we do want a complete copy of an array, we can use the `copy` method:

```python
>>> d = a.copy()
>>> d is a
False
>>> d[0, 0] = 9999
>>> a
array([[   0,    1,    2,    3],
       [1234,    5,    6,    7],
       [   8,    9,   10,   11]])
```

There is a larger list of functions that can be done in NumPy, which can be found [here](https://numpy.org/doc/stable/user/quickstart.html#functions-and-methods-overview).
