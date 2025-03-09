---
aliases: 
draft: false
tags:
  - computerscience
  - textbook
  - algorithms
  - machine_learning
title: Grokking Algorithms - Chapter 13
date: 2025-03-07
updated: 2025-03-07T16:57
---

-------------------------------------------------------------------------------

# Where To Go Next

What a journey this has been! The next few sections are light on detail, and geared more towards exposure. Please feel free to dive into each of these topics on your own, as each is large enough to devote an entire chapter to.

## Linear Regression

Given a data set of points, a line of best fit is generated to make predictions. This is one of the first topics covered when you begin learning about Machine Learning (due to how easy it is to set up), so you're likely going to have first hand experience with this soon enough.

## Inverted Indexes

This topic is how search engines actually work. Inverted Indexes use a hash structure that maps words to places they appear. Then, given a new entry, it'll compare the words as they appear with other metrics it was trained on to return results similar to what you're searching for.

## Fourier Transformation

An algorithm used in separating the make-up of some input. The book uses a fantastic example of "*Given a smoothie, it will return the ingredients of that smoothie*." Not only can it do this with text, but also audio (think of boosting of lowering levels) and image (think compression).


## Parallel Algorithms

A huge topic in itself; nowadays, the only way to *really* improve performance is to split the processing power of a program into multiple units, or specifically CPU/GPU cores. Inherently hard to design because of this.

There are so many variables at play when building parallel algorithms; how do you evenly split the workload? How about **Amdahl's Law**, which states that when optimizing one part of a system, performance gains are inherently limited by how much *that* part took? Or how about *load balancing*, when a task runs too fast & idle time wastes precious resources? Tough questions.


## map/reduce

Known as a distributed algorithm, map/reduce runs over multiple devices. Google actually popularized this with their MapReduce service. Great when you want to increase the speed of a lot of computational work.

## Bloom Filters

Bloom filters are probabilistic data structures; gives an answer that could be incorrect, but is likely correct. Think of our approximation algorithms from earlier in the text. They are useful since they take up such little space.


## HyperLogLog

Approximates the number of unique elements in a set. Again, this is an approximation algorithm, so the return will be close, but not exact.


## HTTPS and the Diffie-Hellman Key Exchange

This is actually a really interesting look into how the internet actually works. HTTPS works by encrypting a message using a special key. You have to send the encrypted message **and** the key into a function in order to un-encrypt the data to be read. However, since there are in fact malicious people out there looking to steal your data, it is dangerous to send both the hash and key together. 

This is where Diffie-Hellman comes in. It provides a safe way to read encrypted data between two clients without sending any secret keys. 

1. Generate keys (for both clients)
2. Generate a common pattern for both
3. Overlay the pattern over both keys
	1. This makes a public key
4. Overlay the public key into the private keys

Now, both of you have a key you can use to encrypt your messages. Neat!

