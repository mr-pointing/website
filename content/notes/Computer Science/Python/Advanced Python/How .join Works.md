---
aliases: 
draft: false
tags:
  - computerscience
  - python
title: How .join Works
date: 2025-04-14
updated: 2025-04-29T14:25
---
[Link](https://realpython.com/python-join-string/) to article

-------------------------------------------------------------------------------

A simple built-in string method of Python, `.join()` allows you to combine strings passed through an iterable of strings, using a *separator string* as the delimiter.

```python
>>> facts = ['Giorno', 'is', 'the', 'strongest', 'Jojo']
>>> " ".join(facts)
"Giorno is the strongest Jojo"
# You could also set the delimiter into it's own variable for more modularity
>>> separator = " "
>>> separator.join(facts)
"Giorno is the strongest Jojo"
```

You don't have to use a whitespace either if you don't want too. You could just as easily concatenate them like so;

```python
>>> letters = ["R", "M", "P"]
>>> "".join(letters)
"RMP"
# Since you just need to pass in an iterable, strings themselves are technically iterables, so the following is valid 
>>> initials = "RMP"
>>> ",".join(initials)
"R,M,P"
```

## CSV Output

A simple use case, but nevertheless important. If we have a list of strings that need to get formatted for a CSV, that becomes trivial with `.join()`;

```python
colors = ['red', 'blue', 'orange']
csv_line = ",".join(colors)
```

Now, you can use that new line to pack into a file. You can also use the methods outlined in [this]({{< ref "Reading and Writing Files with Python" >}}) note.

## URL Composition

Given a base URL, and a list of sub paths, we can create complete URLs;

```python
base_url = "https://examplesite.com/"
subpaths = ["blog", "2025", "05", "join-strings"]

full_url = base-url + "/".join(subpaths)
print(full_url)
"https://examplesite.com/blog/2025/05/join-strings"
```

## Converting Numbers

Obviously, being a string method, using `.join()` on non strings will throw an error. To avoid this, make sure to typecast any values passed in to strings;

```python
countdown = [3, 2, 1]
"...".join(str(number) for number in countdown)
"3..2..1"
```

There is also a functional style approach, using `map`;

```python
countdown = [3, 2, 1]
"...".join(map(str, countdown))
"3..2..1"
```

## Practical Examples

One example straight from the article is that of a JSON log of events. Say we have the following;

```json
{
	"2025-04-29 2:00": ["click", "add_to_cart", "purchases"],
	"2025-04-29 2:10": ["click", "page_view"],
	"2025-04-29 2:20": ["page_view", "click", "add_to_cart"]
}
```