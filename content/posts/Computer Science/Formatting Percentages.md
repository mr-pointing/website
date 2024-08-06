---
aliases:
  - formatting
draft: false
tags:
  - computerscience
  - python
  - formatting
title: Formatting Percentages
date: 2024-07-03
---
Modified: July 03 2024 

-------------------------------------------------------------------------------

7/3/2024

Taken from [this](https://pythonmldaily.com/posts/python-show-number-as-percentage-with-format-and-f-string) article.

Often in projects, we want to format our large `float` types as smaller percentages.

There are three main ways to do this:

1. Rounding and Float/String Types:

`round()` takes two parameters: a value and a number to round too. Then, we can use a little complicated string statement.

```python
>>> number = 0.8839133112
>>> n2 = round(number, 4)
>>> print(n2)
0.886
>>> print(str(n2 * 100) + '%')
```


2. Format()

Alternatively, if that seems a bit complicated, we can just `format()` instead.

```python
>>> print(format(n2, ".2%"))
```


3. F-string

We can also use formatted string literals, which to me seems like the best way.

```python
print(f'{n2:.2%}')
```