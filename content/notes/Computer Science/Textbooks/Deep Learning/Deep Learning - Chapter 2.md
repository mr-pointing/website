---
aliases: 
draft: false
tags:
  - computerscience
  - AI
  - machinelearning
  - textbook
  - math
title: Deep Learning - Chapter 2
date: 2024-10-31
updated: 2024-11-04T12:30
---

-------------------------------------------------------------------------------


# Linear Algebra

This book covers all topics of linear algebra that are important to deep learning, not necessarily all topics within Linear Algebra. For a text more focused in linear algebra, see [here](https://cosmathclub.wordpress.com/wp-content/uploads/2014/10/georgi-shilov-linear-algebra4.pdf).


## Scalars, Vectors, Matrices, and Tensors

### Scalars

Single numbers, usually denoted by a lowercase variable name, and introduced with some information on the number. 

**Ex.** 
- Let $$s \in R$$ be the slope of the line for a *real-valued* scalar
- Let $$n \in N$$ be the number of units for a *natural number* scalar

### Vectors

An ordered array of numbers, obtainable via the index position of the number in the array. Usually denoted with a lowercase variable name in bold. The elements start counting at 1, and are usually subscript attached to the name of the vector to show each element.

We also need to say what type of numbers are stored in the vector; if the numbers are type $$R$$ and have $$n$$ numbers, it's the set of $$R^n$$. A common way of writing vectors; $$x=[x_1,x_2,...,x_n]$$. Each number is a point in space giving a coordinate point.

To *slice* or grab only certain elements, we can write a few different methods of notation. If we define the set $$S={1, 3, 6}$$, we can say that $$x_s$$ to refer to the elements $$x_1, x_3,$$ and $$x_6$$. We could also say $$x_{-1}$$ to refer to the set of all elements *except* for $$x_1$$. Similarly, $$x_{-S}$$ will refer to all of $$x$$ without the elements defined in set $$S$$.


### Matrices

Where vectors are one dimensional arrays, matrices are two dimensional arrays. Similar rules apply for notation, this time instead of a lowercase we'll use uppercase bold for matrices. To notate a real-valued matrix with a height or $$m$$ and width of $$n$$, we can write that as $$A \in R^{m*n}$$. 

- $$A_{1,1}$$ returns the top left number, while $$A_{m, n}$$ returns the bottom right.
- `:` dictates horizontal coordinates; $$A_{i,:}$$ is the horizontal cross section of $$A$$, or the $$i$$-th *row* of $$A$$, where $$A_{:,i}$$ is the vertical $$i$$-th *column* of $$A$$.