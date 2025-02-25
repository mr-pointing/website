---
aliases: 
draft: false
tags:
  - computerscience
  - algorithms
  - textbook
  - recursion
title: Grokking Algorithms - Chapter 3
date: 2025-02-08
updated: 2025-02-22T13:36
---

-------------------------------------------------------------------------------

# Recursion

*Recursion*, or the process of a sub-program calling itself, is a reoccurring concept in many different algorithms, and a foundational topic in computer science.

It *is* a hard topic to understand, but not super complicated. All code examples should be ran and written yourself to gain a full understanding.

Pseudocode is another term you should familiarize yourself with, since it will be used both by this book and by myself. Pseudocode refers to the code or instruction of a given program written out in plain English, usually written before any code is ran to ensure the logic is sound.

To start thinking about recursion, we should look at a simple task: you have to find a key inside a box within a box, but there are multiple boxes inside the initial box. How could you approach finding the key?

Basically, there are two main ways;

{{< image src="/images/whileloop.png" alt="whileloop" position="center" style="border-radius: 8px;" >}}

or,

{{< image src="/images/recursion_example.png" alt="recursion_example" position="center" style="border-radius: 8px;" >}}

The first method uses a while loop, and the second uses recursion. Both are incredibly useful and have their own merits; different situations call for different tools.

Using recursion is simple to write- which makes it easy to screw up. Take the following function definition and call:

```python
def countdown(i):
	print(i)
	countdown(i-1)

countdown(3)
```

Depending on what you're running your code on, you'll either break it or experience an infinite loop. My IDE crashed, and if you're still stuck, hit **Ctrl + C** to terminate it.

The issue we just ran into happened because we didn't define a *recursive case* and *base case*. The recursive case is when the function should call itself, and the base is when the function should stop. If we wanted to fix our countdown timer, we can check for our base case before using recursion:

```python
def countdown(i):
	print(i)
	if i <= 1:
		return
	countdown(i-1)
```

## Stack & Call Stack

Another programming concept we should understand is *stack*, and how the **call stack** works. The more you understand about that, the easier recursion will be to understand.

A stack is simply any structure with two simple actions: *push* (insert) and *pop* (remove & read). An easy example to look at would be a restaurant; as orders are taken, they are given to the chef to work on. (Technically the restaurant motif doesn't work here since restaurants work more like a queue, but we'll get to that later.) 

The call stack is your computers own stack, as it takes in processes or functions as they are called. Your computer pushes the first function in, and any subsequent functions called get pushed, and upon their completion, popped out. That first function (and all running subsequent functions that have made a call) is in a partially completed state, in suspension while the other function(s) run.

### Exercises

{{< image src="/images/grok_algo_ex3_1.png" alt="grok_algo_ex3_1" position="center" style="border-radius: 8px;" >}}

1. Based on the above call stack, what can be observed?
	- I originally, in my usual lazy fashion, only gave a single answer: Function 2 is a subfunction (or nested function) within function 1. There are a few more observations that can be made: Function 1 is called first with the variable `Name` valued as "Mr. P", the current function is Function 2, and Function 1 is currently incomplete/suspended.


## Call Stack with Recursion

This is big brain stuff, so pay close attention.

Here is the code:

```python
def fact(x):
	if x == 1:
		return 1
	else:
		return x * fact(x-1)
```

To accomplish `fact(3)`, here is the line by line walkthrough:

{{< image src="/images/grok_algo_call_stack.png" alt="grok_algo_call_stack" position="center" style="border-radius: 8px;" >}}

Stack is incredibly useful, but can take up a lot of memory if the call stack gets too big.

### Exercises

1. When a recursive call runs forever, what does that do to your stack in memory?
	- It piles up until the program terminates; a stack overflow error will eventually occur.



---
Next: 
[Chapter 4]({{< ref "Grokking Algorithms - Chapter 4" >}}) 
