---
aliases: 
draft: false
tags:
  - computerscience
  - textbook
  - algorithms
  - dictionaries
  - datastructures
title: Grokking Algorithms - Chapter 5
date: 2025-02-27
updated: 2025-03-03T11:11
---

-------------------------------------------------------------------------------

# Hash Tables

*Hash tables* are the more formal term for Python's Dictionary structure; a key-value pairing of elements. *Hash functions* are any function that does the mapping of a value to an input.

Two main rules when implementing hash tables:
1. Pairings should be consistent
2. Key's should be unique

The way these mappings work are complex, but essentially, when using Python, grabbing values from a dictionary is pretty fast and grants instant access.

### Exercises

Which of the following four are consistent?

1. $f(x)=1$ *Returns 1 for all input* ✅
2. $f(x)=$ `random.random()` ❌
3. $f(x)=$ `next_empty_slot()` ❌
4. $f(x) = len(x)$ ✅

## Use cases of Hash Tables

Honestly, they are used pretty much everywhere. Contact lists on your phone, social media apps, sports and athletics, just to name a few. Creating one in Python is as simple as `phone_book = {}`.

Most Hash Tables are ***created with lookups in mind***. Why? Again, instant access. The internet even does it, just on an even grander scale than our examples. IP addresses are mapped to a domain name (URL) through **DNS**, *domain name resolution*.

Browsers use a DNS cache that store recently visited URL's for easy viewing. See [this note]({{< ref "AP Computer Science Principles - Unit 2#dns" >}}) on DNS for more info on how exactly that works. Caching makes things super fast, and looks like this:

```python
cache = {}

def get_page(url):
	if url in cache:
		return cache[url]
	else:
		data = get_data_from_server(url)
		cache[url] = data
		return data
```

## Collisions and Performance

To understand performance, we have to first understand what collisions are and how they happen. Unfortunately, when using hash functions, you can't always avoid keys being assigned to a spot in memory. Exactly why this happens is abstract and not necessary to understand right now. 

You could use linked lists or arrays in tables, but that also has it's own limits like memory waste and management. Hash functions & low load factor help avoid collisions, which is the worst nightmare for hash tables.


|        | Hash (avg) | Hash (worst) | Arrays | Linked Lists |
| ------ | ---------- | ------------ | ------ | ------------ |
| Search | $O(1)$     | $O(n)$       | $O(1)$ | $O(n)$       |
| Insert | $O(1)$     | $O(n)$       | $O(n)$ | $O(1)$       |
| Delete | $O(1)$     | $O(n)$       | $O(n)$ | $O(1)$       |

*Load Factor* is another concept to be aware of, measuring how full an array is (# of items/# of slots). If your load factor is too high, memory is full, and you'll end up having to resize. Good Hash functions spread the data that's stored in them evenly.


---
Next: 
[Chapter 6]({{< ref "Grokking Algorithms - Chapter 6" >}}) 
