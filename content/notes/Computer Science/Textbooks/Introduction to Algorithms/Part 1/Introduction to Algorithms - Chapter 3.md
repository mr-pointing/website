---
aliases: 
draft: false
tags:
  - computerscience
  - algorithms
  - textbook
title: Introduction to Algorithms - Chapter 3
date: 2024-10-02
updated: 2024-10-07T16:41
---

-------------------------------------------------------------------------------


# Characterizing Running Times

As we saw in Chapter 2, order of growth gives us the ability to quantify the effectiveness of our algorithms, and compare them.

Us studying these algorithms at large enough input sizes is us studying the **asymptotic efficiency** of an algorithm. We can say an algorithm that is "*more asymptotically efficient*" is the better choice for most cases, save small inputs.

## O-notation, $\Theta$-notation, and $\Omega$-notation

We already met $\Theta$-notation in chapter 2; this is a type of asymptotic notation.

### O-notation

O-notation designates the **upper bound** on the asymptotic behavior of a function. We could say, "A function *grows no faster* than a certain rate..."

Let's examine some random function: $10n^3+100n^2-15n+20$. 

- The highest term is $10n^3$, so the rate of growth is $n^3$.
- We could write O($n^3$) to represent that.
	- We could also write O($n^4$), since O-notation denotes limits, technically all values greater than the rate of growth are true.
	- O($n^c$) for $c>$ 3 in this case.


### $\Omega$-notation

Similarly, $\Omega$-notation designates the **lower bound** on the asymptotic behavior of a function. "A function *grows at least as fast* as a certain rate..."

Given the same example as before, we can say $\Omega(n^c)$ for $c<=3$.


### $\Theta$-notation

$\Theta$-notation is a **tight bound** on the asymptotic behavior of a function. "A function *grows precisely* at a certain rate..."

If you can show a functions bounds, $O(f(n))$ & $\Omega(f(n))$, you have shown $\Theta(f(n))$.

Since from our example we know $O(n^3)$ and $\Omega(n^3)$, $\Theta(n^3)$.


### Example: Insertion Sort

What observations can we make about Insertion Sort?

1. Outer `for` loop runs $n-1$ times
2. Inner `while` loop's run depends on the values being sorted; either 0 times (best case), or $j$ times ($i-1$, worst case)

These two observations gives us the blanket statement of O($n^2$). We would say that **the running time is dictated by the inner loop**.

The blanket statement can also be said, "In all cases", but we know that it can have a time of $\Theta(n)$, so I need more clarification on this.

The worst-case, $\Omega(n^2)$, can be found using the following example:

- Say that we have an array with a size multiple of 3, 9.
- $A=[7, 8, 9, 3, 4, 1, 2, 5, 6]$
- If we have an instance where the highest values were in the first $n/3$ spots, they'd have to move like this:
	- Each of the $n/3$ (3) largest values move through each of the $A[n/3+1:2n/3]$ positions to end up somewhere in $A[2n/3+1:n]$.
	- Because the first values must move at least $n/3$ (3) times, time taken in the worst case is proportional to $(n/3)(n/3)$, which is $=n^2/9$, which $=\Omega(n^2)$.

Since we have now proved that Insertion Sort runs $O(n^2)$ in all cases and there's an input that makes $\Omega(n^2)$, the worst case is $\Theta(n^2)$.


## Asymptotic Notation: Formal Definitions







