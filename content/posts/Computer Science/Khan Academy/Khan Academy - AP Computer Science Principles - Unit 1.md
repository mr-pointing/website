---
aliases:
  - internet
draft: true
tags:
  - computerscience
  - internet
title: Khan Academy - AP Computer Science Principles - Unit 1
date: 2024-07-20
---
Modified: August 02 2024 

-------------------------------------------------------------------------------

Most of this I should know, being a computer science teacher. However, outlining this should make teaching this rather boring portion easier. I want to try implementing more diagrams while I teach; I'll be looking forward to stealing their ideas. 

## Bits and bytes

### How do computers represent data?

All computers understand is **Binary**, 0's and 1's.

The video explains the example of using one single wire to transfer electricity through it; on or off. This is the most fundamental understanding of how our computers function. This is just one single bit. Common machines use hundreds of thousands of bits to achieve their objective.

With text, it's easier to visualize. Every character has a value related to some makeup of a 0 and a 1. Images are harder, since they're made up of tiny pixels. Each pixel holds a color. Each color can thankfully be represented by a number. Think about videos, that are rendering 30 to 60 images per second.

Audio can also be broken down into numbers, usually by vibrations as a waveform, and that waveform as a number.

Bits hold only a single value, on or off. Generally only binary decisions are used by single bits. 

Computers will use multiple bits to represent more complex data. The more bits, the more information deliverable. 

We can see that a sequence of two bits can represent four ($2^2$) distinct values:

$00, 01, 10, 11$

While a sequence of three bits can represent eight ($2^3$) distinct values:

$000, 001, 010, 011, 100, 101, 110, 111$

While a bit is a single piece of information, a byte is a unit that consists of 8 bits.

The conversion is pretty simple: multiple by 8 to go from bits to bytes, and divide by 8 to go from bytes to bits.

## Binary Numbers

The binary number system works very similarly to how decimal numbers work.

In decimal numbers, you multiply each number by a different power of 10. You start in the ones' place, the tens' place, and the hundreds' place. 234 is equal to $(2 * 100) + (3 * 10) + (4 * 1)$. Ones' place is $10^0$, tens' place is $10^1$, and hundreds' place is $10^2$. 

The binary number system multiplies to the power of 2 instead of 10. 

The decimal number 1, can be represented in binary as 0001. That's the same as $(0 * 8) + (0 * 4) + (0 * 2) + (1 * 1)$, or $0 + 0 + 0 + 1$, which gives you 1.

The decimal number 10, in binary is 1010. We know this because of $(1 * 8) + (0 * 4) + (1 * 2) + (0 * 1)$, which is $8 + 0 + 2 + 0$, which equals 10. 


### Converting decimal to binary

{{ $image := .Resources.Get "decimal_to_binary.png" }}
<img src="{{ $image.RelPermalink }}" width="{{ $image.Width }}" height="{{ $image.Height }}">


## Limitations of Storing Numbers

### Number limits, overflow, and roundoff

Storing numbers requires some work for binary representation. We run into issues with problems like *roundoff*, *overflow*, and *precision*. These issues are usually centered around memory issues.

### Integer representation

An integer is any whole number: $1, 10, 230, -400$ are all integers. In order to store integers, for however many bits the number is stored in, the first indicates the sign, and the others contain the absolute value.


{{ $image2 := .Resources.Get "Khan Academy - AP Computer Science Principles - Unit 1.png" }}
<img src="{{ $image2.RelPermalink }}" width="{{ $image.Width }}" height="{{ $image.Height }}">


### Overflow

Let's suggest we only have 4-bits of memory to store our integers on a computer. That means we could only store up to the number 7. If we were to then try to go beyond it, like say with the following code:

```python
x = 7
y = x + 1
```

`x` is easily able to be stored, but `y` would give us a problem since it goes beyond the capabilities of our systems memory. This type of error is called an *Overflow Error*. Some systems might throw this error, truncate it to 7, or wrap back to 1. 

Thankfully, 64-bit is the common standard.

### Floating-point representation

Floating-point numbers represent every number that isn't an integer-irrational, fractional, etc.

In floating-point representation, a number is multiplied by a base that's raised to some exponent.

In mathematics it often looks like this: $300=3*10^2$

Since computers use the binary system instead of the decimal system, it looks like this: $128=1*2^7$.

Numbers between the powers of 2 end up looking more so like this: $160=1.25*2^7$, or $0.25=1*2^-2$.

Modern 64 bit systems use 1 bit for the sign, 11 bits for the exponent, and 52 bits for the number in the front.

### Roundoff errors

There are still some issues since there are some numbers that can't be easily represented. $.3^-$ (repeating) is an infinitely repeating sequence that can't be stored in any device. The computer will eventually have to round at some point. A *roundoff error* is when we get an unexpected error due to the computers rounding of a complicated-to-represent number.