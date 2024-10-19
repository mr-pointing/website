---
aliases: 
draft: false
tags:
  - computerscience
  - algorithms
  - textbook
title: Appendix A
date: 2024-10-02
updated: 2024-10-07T16:41
---

-------------------------------------------------------------------------------

# Summations

As we know, we analyze algorithms by their running time. When algorithms use for or while loops (iterative structures), the running time is expressed as the **sum of all the times spent on execution**.

## Summation Formulas and Properties

Say we have $a_1,a_2,...a_n$ numbers, what we call a *sequence*. While $n$ is a non-negative integer, we can say the sum of that set is $\sum_{k=1}^{n}a_k$.

- If $n=0$, value is 0.
- The value of a finite series is always well-defined
- Order terms are added in doesn't matter (what di I mean with this? who knows)

We might also have an infinite sequence, the infinite sum could be written as $\sum_{k=1}^{\infty}a_k$, or $lim_{n->\infty}\sum_{k=1}^{n}a_k$.

If there is *no limit*, we say the set **diverges**.

If there *is a limit*, we say the set **converges**.

Within a convergent series, it cannot be added in any order, but you can rearrange terms of an absolutely convergent series, or $\sum_{k=1}^{\infty}a_k$ for which the series $\sum_{k=1}^{\infty}|a_k|$ also converges.


### Linearity

For any real number $c$ and any finite sequence $a_1,a_2,...a_n$ and $b_1,b_2,...b_n$ …

- $\sum_{k=1}^{n}(ca_k+b_k)=c\sum_{k=1}^{n}a_k+\sum_{k=1}^{n}b_k$   

This property also applies to infinite convergent series, as well as summations incorporating asymptotic notation:

- $\sum_{k=1}^{n}\Theta(f(k))=\Theta(\sum_{k=1}^{n}f(k))$


### Arithmetic Series

Looking at the following summation ($\sum_{k=1}^{n}k=1+2+...+n$) we understand it as an *arithmetic series* with the value of:

- $\sum_{k=1}^{n}k=(n(n+1))/2$ which $=\Theta(n^2)$

We might also have a *general arithmetic series*, which has an additive constant over 0, $a$ and $b$, with the same total asymptotically:

- $\sum_{k=1}^{n}(a+bk)=\Theta(n^2)$


### Sums of Squares and Cubes

The following formulas apply to summations of *squares and cubes*:

- $\sum_{k=0}^{n}k^2=(n(n+1)(2n+1))/6$
- $\sum_{k=0}^{n}k^3=(n^2(n+1)^2)/4$

### Geometric Series

For real numbers, $x$, where $x != 1$, we can say the summation;

- $\sum_{k=0}^{n}x^k=1+x+x^2+....+x^n$

is a *geometric series* with a value of 

- $\sum_{k=0}^{n}x^k=(x^{n+1}-1)/(x-1)$ 

We can see an *infinite decreasing geometric series* occur when the summation is infinite and $|x|<1$:

- $\sum_{k=0}^{\infty}x^k=\frac{1}{1-x}$


### Harmonic Series

For positive integers $n$, the $n^{th}$ *harmonic number* is;

- $H_n=1+\frac{1}{2}+\frac{1}{3}+...+\frac{1}{n}$
	- Which, $=\sum_{k=1}^{n}\frac{1}{k}$
	- Which, $=ln*n+O(1)$


### Integrating and Differentiating Series

**Integration** is when you find the integral of each term in a series, and **differentiation** is when you find the derivative of each term in a series.

I don't understand this fully yet, likely because I don't understand integrals and derivatives yet. I'll come back to this.


### Telescoping Series

For any series $a_0,a_1,...a_n$,

- $\sum_{k=1}^{n}(a_k-a_{k-1})=a_n-a_0$

Since each term from $a_1 -> a_{n-1}$ is added in once and subtracted once, we say the sum **telescopes**. We could also say,

- $\sum_{k=0}^{n}(a_k-a_{k+1})=a_0-a_n$ 


### Re-indexing Summations

Sometimes, you can simplify a series by changing it's index, reversing the order of summation.

If we have the series $\sum_{k=0}^{n}a_{n-k}$, the terms in the summation are $a_n,a_{n-1},...,a_0$, we can easily reverse the order of indices by letting $j=n-k$ & rewrite this summation as:

- $\sum_{k=0}^{n}a_{n-k}=\sum_{j=0}^{n}a_j$

This process is called **reindexing**. Anytime the *summation index* appears in the body of the sum with a minus sign, is a sign to consider reindexing.

In the following example, $\sum_{k=1}^{n}\frac{1}{n-k+1}$ the summation index, $k$, is a negative. So, we can set $j=n-k+1$ and create:

- $\sum_{j=1}^{n}\frac{1}{j}$, which is actually *just a harmonic sequence*.

### Products

The finite product $a_1a_2...a_n$ can be expressed as:

- $\prod_{k=1}^{n}a_k$
	- If $n=0$, value = 1
	- You can convert product to summation using:
		- $\lg(\prod_{k=1}^{n}a_k)=\sum_{k=1}^{n}\lg a_k$  
