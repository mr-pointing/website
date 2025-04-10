---
aliases: 
draft: false
tags:
  - computerscience
  - python
  - stack
title: Generate Parentheses
date: 2025-04-02
updated: 2025-04-03T16:41
---

-------------------------------------------------------------------------------

***Question:*** 
You are given an integer `n`. Return all well-formed parentheses strings that you can generate with `n` pairs of parentheses.

**Example 1:**

```python
Input: n = 1

Output: ["()"]
```


**Example 2:**

```python
Input: n = 3

Output: ["((()))","(()())","(())()","()(())","()()()"]
```

***How to Solve:*** 

This one was rough. It was hard to imagine exactly how to get all of the different configurations of the parenthesis. I started out with a basic `for` loop to create the most basic version, or the first from the examples;

```python
openP = "("
closedP = ")" 
for i in range(4):
	print((openP * i) + (closedP * i))
```

This was a good start, but I made the same critical error I've made on many neet code problems; not paying attention to the question category.

I flubbed on realizing I should be using a stack for keeping track of my collection, so after ~20 minutes I looked at the answer.

***Answer:***

What we need to do is use the stack as a way to generate these combinations. The method is really ingenious, and I honestly don't think I would have figured this out regardless of the amount of time spent;

We use the stack as a location to place our opening and closing parenthesis, then use a `join` to create a single string with a valid sequence. We start by making the most basic formation, with `n` amount of openings followed by `n` amount of closings. Then, after creating that, we use `pop` to move backwards and generate the rest of the valid combinations.

This part was slightly confusing, so I had to walk through it a few times in the debugger. So when moving backwards, after the initial creation, it will delete up until the second to last opening, then create all of the valid combinations. It will continue to do so for all opening parenthesis. Really a brain teaser, made me feel incredibly stupid, 10/10.

```python
def generateParenthesis(n: int) -> list[str]:
        stack = []
        res = []
        def backtrack(openN, closedN):
            if openN <mark> closedN </mark> n:
                res.append("".join(stack))
                return
            if openN < n:
                stack.append("(")
                backtrack(openN + 1, closedN)
                stack.pop()
            if closedN < openN:
                stack.append(")")
                backtrack(openN, closedN + 1)
                stack.pop()
        backtrack(0, 0)
        return res
```

