---
aliases: 
draft: false
tags:
  - computerscience
  - python
title: Generators
date: 2025-04-29
updated: 2025-07-20T11:36
---
[Link](https://wiki.python.org/moin/Generators) to article 1.
[Link](https://realpython.com/introduction-to-python-generators/) to article 2.

--------------------------------------------------------------


# What is a Generator?

Straight from the Python wiki, *Generators* are functions built to act like an iterator, which most commonly are used in for loops. Generators were made with the intention to have iterator functions, meaning we could take the following;

```python
def first_n(n):
    """
    Builds and returns a List
    """
    num, nums = 0, []
    while num < n:
        nums.append(num)
        num += 1
    return nums


sum_of_first_n = sum(first_n(100))
print(sum_of_first_n)
```

Can be remade with the following;

```python
def first_gen_n(n):
    """
    Generator version of first_n
    """
    num = 0
    while num < n:
        yield num
        num += 1


sum_of_first_gen_n = sum(first_gen_n(1000))
print(sum_of_first_gen_n)
```

The big benefit is savings on memory due to the lazy generation of values, or only when needed generation. If you made a list of 1 million elements, you need 1 million units of space for your values. With a generator, you simply retrieve each value one at a time when needed, saving a ton of space.

Another instance you might see a generator be used is similar to how we use list construction;

```python
> generator_comp = (num**2 for num in range(5))
> generator_comp
<generator object <genexpr> at 0x7fc6495faa80>
```

As you can see, we don't get the contents of the comprehension result, but a generator object instead. The way to actually obtain that info is a mix of `yield` and `next`; `yield` we already saw, and it does the returning of the value. It also keeps track of the state, so after it returns something, it knows what's next in line when it needs to be called again. It's called using `next`, which grabs the result of the first `yield` found within a generator/iterator.

```python
> print(next(generator_comp))
0
> print(next(generator_comp))
1
> print(next(generator_comp))
4
```

