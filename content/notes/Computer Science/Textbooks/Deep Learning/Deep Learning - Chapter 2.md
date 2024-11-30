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
updated: 2024-11-18T12:31
---

-------------------------------------------------------------------------------


# Linear Algebra

This book covers all topics of linear algebra that are important to deep learning, not necessarily all topics within Linear Algebra. For a text more focused in linear algebra, see [here](https://cosmathclub.wordpress.com/wp-content/uploads/2014/10/georgi-shilov-linear-algebra4.pdf).


## Scalars, Vectors, Matrices, and Tensors

### Scalars

Single numbers, usually denoted by a lowercase variable name, and introduced with some information on the number. 

**Ex.** 
- Let $s \in R$ be the slope of the line for a *real-valued* scalar
- Let $n \in N$ be the number of units for a *natural number* scalar

### Vectors

An ordered array of numbers, obtainable via the index position of the number in the array. Usually denoted with a lowercase variable name in bold. The elements start counting at 1, and are usually subscript attached to the name of the vector to show each element.

We also need to say what type of numbers are stored in the vector; if the numbers are type $R$ and have $n$ numbers, it's the set of $R^n$. A common way of writing vectors; 

{{< image src="/images/vector_example.png" alt="vector_example" position="center" style="border-radius: 8px;" >}}

Each number is a point in space giving a coordinate point. The fact that we write it vertically instead of horizontally is purposeful, and we'll see why later.

To *slice* or grab only certain elements, we can write a few different methods of notation. If we define the set $S={1, 3, 6}$, we can say that $x_s$ to refer to the elements $x_1, x_3,$ and $x_6$. We could also say $x_{-1}$ to refer to the set of all elements *except* for $x_1$. Similarly, $x_{-S}$ will refer to all of $x$ without the elements defined in set $S$.


### Matrices

Where vectors are one dimensional arrays, matrices are two dimensional arrays. Similar rules apply for notation, this time instead of a lowercase we'll use uppercase bold for matrices. To notate a real-valued matrix with a height or $m$ and width of $n$, we can write that as $A \in R^{m*n}$. 

- $A_{1,1}$ returns the top left number, while $A_{m, n}$ returns the bottom right.
- `:` dictates horizontal coordinates; $A_{i,:}$ is the horizontal cross section of $A$, or the $i$-th *row* of $A$, where $A_{:,i}$ is the vertical $i$-th *column* of $A$.

This is a basic example of what a matrix looks like:

{{< image src="/images/matrix_position.png" alt="matrix_position" position="center" style="border-radius: 8px;" >}}

### Tensors

Basically, a multidimensional array with more than 2 dimensions. It also uses a different typeface for identification, so for this note and all ongoing notes I'll be using just bold with not LaTeX wrapping. We would call a tensor **A**, and the element of **A** at coordinates $(i,j,k)$ appears at **A**$_{i,j,k}$.


### Transposing

Transposing is an operation that is common and can be done across all 4 constructs we just saw. Technically, transposing is done on matrices, so we'll have to justify how it works for each.

Transpose is a mirror image of a matrix dictated by the *main diagonal*, which is a diagonal line that runs from left to right going downwards. We denote a transposed matrix with a capital **T** as superscript (or `\intercal` in LaTeX. It sounds harder than it looks;

{{< image src="/images/transposing.png" alt="transposing" position="center" style="border-radius: 8px;" >}}

- Scalars are thought of a matrix with a single entry, so the transpose of a scalar is itself; $a = a^\intercal$
- Vectors are a matrix with a single column, so the transpose of a vector is a matrix with a single row. This is why writing the vector $x$ as $x=[x_1,x_2,...x_n]$ technically isn't correct, and is actually the transposed version of $x$. For the sake of writing and not having many easy ways to horizontally, you'll find some people write their vectors out transposed; $x=[x_1,x_2,x_3]^\intercal$.

Some very basic mathematics can be done between structures;

- Matrices can be added if they have the same shape by adding element by element; $C=A+B$ where $C_{i,j}=A_{i,j}+B_{i,j}$.
- You can add a scalar to a matrix or multiply a matrix by a scalar by moving the scalar through the matrix;
	- $D=a*B+c$ where $D_{i,j}=a*B+c$ 
- In deep learning, we can unconventionally perform the addition of a matrix and a vector, returning a separate matrix. This is done by adding the vector to each row of the matrix, otherwise known as *broadcasting*
	- $C=A+b$ where $C_{i,j}=A_{i,j}+b_j$


## Multiplying Matrices and Vectors

There are three main types of multiplication, or *products* we can derive from multiplication amongst matrices; **matrix product**, **Hadamard product**, and **dot product**.

Matrix product is taking two matrices and multiplying them to create a new, third matrix. Matrix $A$ must have the same amount of columns as matrix $B$ has rows; $A$ has a shape of $m*n$ while $B$ has the shape of $n*p$, the shape of our new matrix $C$ has a shape of $m*p$. We could also simply write this as $C=AB$.

What we're actually doing when performing matrix multiplication is getting the *dot product* of our first matrices row and adding it to the product of our second matrices column and moving up from there. The actual mathematical syntax is as follows: $C_{i,j}=\sum_k A_{i,k}B_{k,j}$.

Dot product is what you *think* matrix multiplication is; the product of each element of a matrix against another and added together. Usually represented as $A\cdot B$.

I've never done matrix multiplication before, or not enough to actively remember it. Below are some examples;

Example on matrices of the same shape:

{{< image src="/images/matrix_product_example1.png" alt="matrix_product_example1" position="center" style="border-radius: 8px;" >}}


Example on matrices of different shape:

{{< image src="/images/matrix_product_example_2.png" alt="matrix_product_example_2" position="center" style="border-radius: 8px;" >}}


The difference between dot product and element-wise product is that in dot product, you are multiplying the components and add the products up, while in element-wise you multiply corresponding components, but don't have to worry about summation of anything. You simply return a new vector with the same dimensions as your original vectors.

Matrix properties follow some of the properties of numbers learned in Algebra, but not all;

- Distributive
	- $A(B+C)=AB + AC$
- Associative
	- $A(BC)=(AB)C$
- 