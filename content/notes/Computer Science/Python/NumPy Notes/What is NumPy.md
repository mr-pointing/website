---
aliases: []
draft: false
tags:
  - computerscience
  - documentation
  - datastructures
  - python
title: What is NumPy
date: 2024-06-20
updated: 2024-09-30T17:09
---

[Link](https://numpy.org/doc/stable/) to documentation

-------------------------------------------------------------------------------

# What is NumPy?

Python lists are great- easy to use, easy to understand, and perfect for quick one-and-done scenarios. However, there is a huge downside to lists. In most cases, since lists can accept any data type by default, this leaves lists open to unexpected data types you might not want around your list data. 

NumPy is a solution to this issue, specifically in the realm of scientific computing. It's primary use is for it's *multidimensional array objects* and *assortment of fast methods for arrays*. 

The one I've seen used the most and what the doc's say is the core of NumPy, is the `ndarray` object. There are some clear differences between this `ndarray` and Python's built-in `list`;

- `ndarray`'s are homogenous; only one data type per array, which is efficient for memory
- the `n` is in reference for n-dimensions, meaning we can easily denote how many matrices we have
- `ndarray`'s have a fixed size, while `list`'s are dynamic
	- If you change the size of an `ndarray`, you're actually creating a new one and deleting the old one
- Advanced mathematical operations are generally easier to complete on `ndarray`'s with less code

NumPy is a foundational tool for many scientific packages in Python. In order to understand how to use those packages, you'll also have to know how to use `ndarray` objects.

Let's look at an example to see just how fast NumPy is.

To multiply the each element within a list to another corresponding element within a different list in Python it looks like this:

```python
c = []
for i in range(len(a)):
	c.append(a[i]*b[i])
```

This is certainly working code, but inefficient for sufficiently large numbers (say, a million).

With NumPy arrays, the above becomes:

```python
c = a * b
```

The above is an example of vectorization. There's some C-code behind the scenes that makes the operations intensely fast that's abstracted out. There's layers we're not seeing that are at work, that we don't necessarily need to worry about.

# Why is NumPy Fast?

Vectorized code like we saw above was obviously clearer and more concise. This leads to plenty of advantages. Less code the better (in most cases), which leads to less bugs. It also more accurately represents how actual math looks, which can make it easier to manipulate and use. 


---
Next: 
[NumPy Quickstart]({{< ref "NumPy Quickstart" >}}) 
