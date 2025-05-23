---
aliases: 
draft: false
tags:
  - computerscience
  - textbook
  - lua
title: Programming in Lua - Chapter 18
date: 2025-05-19
updated: 2025-05-19T14:54
---

-------------------------------------------------------------------------------

# Iterators and the Generic `for`

Let's learn how to make our own *Iterators* in Lua. We'll accomplish this by taking a look at the `for` loop in more detail; more specifically, the **generic** `for` loop.

## Iterators and Closures

We consider an iterator to be any construction that will allow is to iterate over the elements within some collection of objects. Most commonly we use functions to accomplish this. We make calls to the function when we want the next item, and so on. We've seen this with `io.read` in the past.

A crucial part of an iterator is keeping track of it's state, or at what point in the collection the iterator is currently at. This is to avoid sending out duplicate entries or skipping. We can use *closures* to keep track. 

Closures were brought up in chapter 9, and are a somewhat confusing concept (at least I think so), and they are described as a function that is direct access to one or more local variables from within it's own enclosed environment. What's important to remember is that a closure construction has two functions; the closure and the *factory*, the function that actually makes the closure and the variables enclosed. In order to help me better understand closures, *instead of* asking ChatGPT to explain like I am 5 years old, I just googled it and found [this](https://dev.to/inidaname/explain-closures-to-me-like-i-am-five-2il) article that helped out a lot.

A simple list iterator without the index positions as a result can be created using the following;

```lua
function values (t)
  local i = 0
  return function () i = i + 1; return t[i] end
end
```

Our new function `values` is the factory, and every time we call the factory a new closure is generated, which in turn is a new iterator. Now, anytime we call the new iterator, the next value of `t` will be spat out. We can use this example in a `while` loop;

```lua
t = {10, 20, 30}
iter = values(t)
while true do
  local element = iter()
  if element == nil then break end
  print(element)
end
```

This is cool, and some people like this, but we can improve this code and the readability by implement the generic `for`;

```lua
t = {10, 20, 30}
for element in values(t) do
  print(element)
end
```

The text also provides an example of an iterator meant to traverse all the words from standard input;

```lua
function allwords ()
  local line = io.read()
  local pos = 1
  return function ()
    while line do
      local w, e = string.match(line, "(%w+)()", pos)
      if w then
        pos = e
        return w
      else
        line = io.read()
        pos = 1
      end
    end
    return nil
  end
end
```

The above code is a little complex so let's dissect;

1. We establish some local variables to help us with navigation; `line` to get the current line, and `pos` to get the current position in the line.
2. We return our iterator function
3. While there are lines, repeat the search for a line;
	1. Collect `w` and `e`, a word and it's position
	2. If a word was found, set the next position to after the current word and return the word
	3. If there was no word to be found, try the next line and restart the position, `pos`
4. If there are no more lines, end the traversal by returning `nil`

The unfortunate reality of iterators is that while they are rather verbose to write and read, using them is trivial;

```lua
for word in allwords() do
  print(word)
end
```

## The Semantics of the Generic `for`

Although not a complete issue, every time we use one of the previous iterators we are creating a new closure for each new loop. There are situations in which this creates too much overhead, leading to a slew of issues. One way to avoid this is by using the generic `for` to track the iteration state.

Not only does our generic `for` keep track of the iterator function internally, it also holds an *invariant state*, and a *control variable*. The syntax is simple enough;

```lua
for <var-list> in <exp-list> do
  <body>
end
```

`var-list` can be one or more variables separated by commas, while the `exp-list` is the same concept just with expressions. Whatever the first or sometimes only variable in the `var-list` becomes our control variable.

The first thing done by our `for` loop is the evaluation of the `exp-list`. 