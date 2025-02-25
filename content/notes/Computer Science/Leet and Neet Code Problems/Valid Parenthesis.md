---
aliases: 
draft: false
tags:
  - computerscience
  - python
  - stack
title: Valid Parenthesis
date: 2025-02-22
updated: 2025-02-22T13:40
---

-------------------------------------------------------------------------------


***Question:*** You are given a string `s` consisting of the following characters: `'('`, `')'`, `'{'`, `'}'`, `'['` and `']'`.

The input string `s` is valid if and only if:

1. Every open bracket is closed by the same type of close bracket.
2. Open brackets are closed in the correct order.
3. Every close bracket has a corresponding open bracket of the same type.

Return `true` if `s` is a valid string, and `false` otherwise.

**Example 1:**

```java
Input: s = "[]"

Output: true
```


***How to Solve:*** We have to keep track of the parenthesis as they open, which is perfect for a stack. The reason is the order of the closing matters; if we have 3 openings, `[{(` , the first closing we should find should be for the most recent parenthesis, `)`. If we encounter any other first, it is not valid. A stack is a first in last out structure, which is perfect for what we're looking for.


***Answer:***

```python
def isValid(s: str) -> bool:
        o_dict = {'(':')', '[':']', '{':'}'}
        current = []
        for v in s:
            if v in o_dict.keys():
                current.append(o_dict[v])
            elif len(current) >= 1 and v == current[-1]:
                current.pop()
            else:
                return False
        return True if not current else False
```

