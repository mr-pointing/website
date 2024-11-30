---
aliases: 
draft: false
tags:
  - computerscience
  - python
title: Decorators
date: 2024-11-11
updated: 2024-11-16T10:30
---

-------------------------------------------------------------------------------


# What is a Decorator?

Essentially, a decorator, is a wrapping for function. It allows you to do something *before* and/or *after* a function is called. Let's look at a super basic example;

```python
def uppercase_word(function):  
    def wrapper():  
        func = function()  # call the function to get the return value  
        make_upper = func.upper()  
        return make_upper  
  
    return wrapper
```

Now, let's say we make a really basic function to print text out;

```python
def say_word():
	return "say wooooord"
```

We could print it out like this:

```python
decorated_function = uppercase_word(say_word())
decorated_function()
```

But, Python allows for something called *decorators*, that allow you to type the function with an `@` sign before the function call to tell that function, when called, to be wrapped in whatever function the decorator performs. We would change the `say_word()` function definition to be written like this;

```python
@uppercase_word
def say_word():
	return "say wooooord"
```

Now, whenever you call `say_word`, it will be default be wrapped in the the `uppercase_word` function.