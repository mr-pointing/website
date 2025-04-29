---
aliases: 
draft: false
tags:
  - computerscience
  - textbook
  - lua
title: Programming in Lua - Chapter 13
date: 2025-04-22
updated: 2025-04-22T11:42
---

-------------------------------------------------------------------------------

# Bits and Bytes

Not a dense chapter, but we should recognize that Lua handles binary data very similarly to text. Let's dive right into it.

## Bitwise Operators

There are a few Lua operators that work only on integers and binary data; `&` or AND, `|` or OR, `~` or BITWISE OR, `>>` or SHIFT RIGHT, `<<` or SHIFT LEFT, and `~` which can also mean BITWISE NOT.

```lua
string.format("%x", 0xff & 0xabcd) --> cd
string.format("%x", 0xff | 0xabcd) --> abff
```

## Unsigned Integers

Essentially, unsigned integers are any numbers that can only represent non-negative values. By default, Lua does not support them, but there are workarounds that can help implement them in necessary. 

## Packing and Unpacking Binary Data


