---
aliases:
  - algorithms
draft: false
tags:
  - computerscience
  - algorithms
  - textbook
title: Introduction to Algorithms - Chapter 2
date: 2024-07-24
---
Modified: August 02 2024

-------------------------------------------------------------------------------

## Getting Sorted

This chapter is meant to familiarize yourself with the framework used throughout the book.

## 2.1 Insertion Sort

Solves a sorting problem (obviously).

The numbers to be sorted are known as *keys*. 

The input comes in the form of an array with $n$ elements. 

A reason to sort is often because those keys are associated with other data, *Satellite data*.

Key + Satellite = *Record* 

We can think of a spreadsheet, with student records having many pieces of data. Any piece can be the key; whatever the key is, is how the record is sorted.

They offer the code into pseudocode, and I turned it into Python.

**Pseudocode**:

Where A is an array and $n$ is the # of values.

$Insertion-Sort(A, n)$
1. $for\  i = 2 \ to \ n$
2.      $key = A[i]$
3.      $j = i - 1$
4.      $while\ j > 0\ and\ A[j] > key$
5.           $A[j+1] = A[j]$
6.           $j = j - 1$
7.      $A[j+1] = key$

```python
def insertion_sort(nums:list) -> list:  
	"""Sort a list using insertion-sort algorithm."""
    max_len = len(nums)  
    for i in range(1, max_len):  
        key = nums[i]  
        j = i - 1  
        while j >= 0 and nums[j] > key:  
            nums[j + 1] = nums[j]  
            j -= 1  
        nums[j+1] = key  
    return nums  
  
number_list = [6, 3, 8, 1, 10, 2, 1]  
  
print(insertion_sort(number_list))
```

Let's think of this like a deck of cards. In the example, at the beginning of each iteration of our for loop, indexed by $i$, the subarray consisting of elements $A[1:i-1]$ constitutes the currently sorted hand, and the remaining sub array $A[i+1:n]$ corresponds to the pile of cards still on the table.

We state these properties of $A[1:i-1]$ formally as a *loop invariant*:

```ad-note
At the start of each iteration of the **for** loop, of lines 1 - 8, the subarray of $A[1:i-1]$ consists of the elements originally in $A[1:i-1]$, but in sorted order.
```

Loop invariants help us understand why an algorithm is correct. We need to show three things:

1. **Initialization:** It's true prior to the first iteration of the loop.
2. **Maintenance:** If it was true before, it remains true before the next iteration.
3. **Termination:** The loop terminates, and when it does, the invariant - usually along with the reason that the loop was terminated = gives us a useful property that helps show that the algorithm is correct.

When the first two hold true, the loop invariant is true prior to every iteration of the loop.

A loop invariant proof is a form of mathematical induction (prove a base case, then an inductive step).

The third property might be the most important since it proves correctness.

Unlike mathematical induction, where the inductive step infinitely, in the loop invariant the "induction" stops when the loop terminates. 

Let's review how the induction proves each of the three points:

1. **Initialization:** We start by showing it holds before the loop begins, when $i$ is 2, since logically there is only one element that **has** to be sorted (obviously).
2. **Maintenance:** Using the logic of the for loop, and that it *increments* up by one each turn, we preserve the loop invariant (we'll talk about the while loop later).
3. **Termination:** Due to the condition, $i$ being greater than $n$ or $i = n + 1$, it will end, and it has $A[1:n]$ sorted, so the algorithm holds correct.

Some Pseudocode Conventions:

- Indentation indicates block structure.
- Looping constructs while, for, repeat-until, and if-else work just like they do in C, C++, Java, and Python.
	- The for loop's counter retains the value that broke the loops bound.
- // denotes a comment.
- Variables $i$, $j$, $key$, etc. are always local unless specified.
- In Python specifically, $for\ i = 1\ to\ n$ is equivalent to `for i in range(1, n+1)`.
	- Also in Python, the loop counter retains $n$, not $n+1$ because lists may contain a non-numeric.
- Indexing lists/arrays works similarly to Python, except this book uses 1-origin over 0-origin slicing `:` indicates a subarray.
- Data objects will often exist, and it's attributes are access via dot method.
- The book treats variable representing an array or object as a pointer to the data representing the array/object.
	- If you set $y=x$, and change $x.f$ to 3, $y.f$ is also 3 now.
- Parameters are passed by value, instead of by reference. 
	- The procedure receives its own copy of the parameters, and if it assigns a value to a parameter, the change is not seen by the calling procedure.
- Return statements return control back to the point of call & often can return values. Often, the book will contain a few return values, which is unconventional for most languages.
- *Short-circuiting* is when you use $and$ and $or$ to bypass quick conditionals.
	- With $and$, if $x$ and $y$, and $x=false$, $y$ is not checked.
	- With $or$, if $x$ and $y$, and $x=false$, $y$ has to be checked.
- Error is an error.


### Exercises 2.1

1. Using Figure 2.2 (insertion sort diagram), illustrate the operation of insertion sort on an array containing the sequence (31, 41, 59, 26, 41, 58).

{{ $image := .Resources.GetMatch "Insertion Sort Diagram.jpeg" }}
{{ with $image }}
  <img src="{{ .RelPermalink }}" width="{{ .Width }}" height="{{ .Height }}">
{{ end }}




2. Consider the following procedure, Sum-Array. It computes the sum of the $n$ numbers in array $A[1:n]$. State a loop invariant for this procedure, and use it's initialization, maintenance, and termination properties to show that the Sum-Array procedure returns the sum of numbers in $A[1:n]$.

$Sum-Array(A, n)$
1. $sum = 0$
2. $for\ i = 1\ to\ n$
3.      $sum = sum + A[i]$
4. $return\ sum$

**Invariant:** After the initial start of each iteration of the **for** loop of lines 2 & 3, the variable sum sill contain the running sum of $A[1:i-1]$.

**Initialization:** Sum is 0, then after the first loop, always equal to $A[1:i-1]$.

**Maintenance:** For loop moves from first element to $n$ (max size).

**Termination:** Returns $sum$ after loop completes.

3. Rewrite the insertion-sort procedure to sort into decreasing order instead of increasing order.

```python
def insertion_sort(nums:list) -> list:  
	"""Just change > to < keys"""
    max_len = len(nums)  
    for i in range(1, max_len):  
        key = nums[i]  
        j = i - 1  
        while j >= 0 and nums[j] < key:  
            nums[j + 1] = nums[j]  
            j -= 1  
        nums[j+1] = key  
    return nums  
```

7/31/24

4. Consider the following searching problem, and write pseudocode for linear search, which scans through the array from beginning to end, looking for $x$. Using a loop invariant, prove that your algorithm is correct.


**Input:** A sequence of $n$ numbers ($a_1,a_2,...,a_n$) stored in an array $A[1:n]$ and a value, $x$.

**Output:** An index $i$ such that $x$ equals $A[i]$ or the special value $NIL$ is $x$ does not appear in $A$.

$Linear-Sort(A, x)$
1. $n =\  length\ of\ A$
2. $for\ i = 1\ to\ n$
3.      $if\ A[i]\ =\ x$
4.           $return\ i$
5. $return\ NIL$

**Loop Invariant:** For each iteration of the for loop on lines 2, 3, and 4, each value of $A$ is compared to $x$. If any value is, the index $i$ is returned. If no value is found, $NIL$ is returned.

**Initialization:** $n$ creates our bound, so we don't go over and get an index error.

**Maintenance:** Unless the condition is met, no changes are made, except for loop iteration.

**Termination:** The last command is returning $NIL$, ensuring closure.


## 2.2 Analyzing Algorithms

*Analysis* is the method of predicting the output of an algorithm based on numerous factors. Energy, time, space, etc.

In order to analyze properly, you need to first understand the environment, limitations & specifications, etc.

The book uses the *Random Access Memory (RAM)* method:

- Everything is stored in the same fashion (think of arrays, allocating the same space for each element).
- Each command requires the same time (instruction or data processing).
- Each instruction happens one after another with no congruency
- Some pre-built instructions:
	- Arithmetic (add, subtract, multiply, etc.)
	- Data movement (load, copy, store)
	- Control (conditional/unconditional branch, return)
- Data types are:
	- Integers (Booleans are just integer checks for `0=false` and `1=true`)
	- Floats
	- Characters

### Analyzing Insertion Sort

You could run it on your computer given the code above. You could time it, but that wouldn't tell you much.

The reason is that every computer environment is different, along with different input factors that make comparing directly difficult.

Instead, we can analyze the algorithm used itself, or, how long each instruction takes to complete.

We'll do this in two steps:

1. Come up with a formula for running time.
2. Use the important parts of the formula in an easy to read notation.


