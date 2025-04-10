---
aliases: 
draft: false
tags:
  - computerscience
  - textbook
  - lua
  - syntax
title: Programming in Lua - Chapter 6
date: 2025-03-19
updated: 2025-03-24T18:04
---

-------------------------------------------------------------------------------

# Functions

Functions in Lua are the main method of abstracting out commands. We've been using functions the entire time. Like most other languages, we can accomplish direct tasks or solve complicated problems with repeatable calls.

When calling functions, we use parenthesis, even when there are no parameters. The only time we can leave parenthesis out is when the argument is a literal string or a table constructor.

A fun addition of Lua is the colon operator, which supports method like calling;

```lua
> print(8*9, 9/8)
> print "Hello World"
> f{20, 30}
> o:foo(x) --> where o is an object and foo is a method
```

Since Lua programs have the ability to use either Lua or C functions, you will likely want to use C functions for better performance and functions not found through base Lua.

We can easily define our own functions with the following syntax;

```lua
function add (a)
  local sum = 0
  for i = 1, #a do
    sum = sum + a[i]
  end
  return sum
end
```

The function is made up of a *name*, *parameters*, and a *body*. The way Lua uses parameters with returns is interesting. When passing parameters, Lua will return `nil` for any empty parameters and discard extra parameters. Take the following function;

```lua
function f (a, b) print(a, b) end
```

The following calls exemplify the above point;

```lua
f() --> nil nil
f(3) --> 3 nil
f (3, 4) --> 3 4
f (3, 4, 5) --> 3, 4 (5 is discarded)
```


## Multiple Results

Another interesting feature of Lua has to be the multiple return feature. We've already seen in the last few chapters that this is possible, so it's not a totally new concept. All you need to do is use a comma after a `return` statement. They offer a nice function to find a maximum element of a sequence;

```lua
function maximum (a)
  local mi = 1
  local m = a[mi]
  for i = 1 #a do 
```

When using it, we can pack variables in the same line. In a multiple line assignment, the position of your calls matter. In the following example, let's use the following functions;

```lua
function foo () end
function foo1 () return "a" end
function foo2 () return "a", "b" end
```

We can observe the way Lua handles returns and calls;

```lua
x, y = foo2() --> x = "a", y = "b"
x = foo2() --> x = "a"
x, y, z = 10, foo2() --> x = 10, y = "a", z = "b"
x, y = foo() --> x = nil, y = nil
x, y = foo1() --> x = "a", y = nil
x, y = foo2(), 20 --> x = "a", y = 20
x, y = foo(), 20, 30 --> x = nil, y = 20
```

You can place a parenthesis on a function call to force only one result. You can do the same with all `return` statements, so `return(f(x))` will only return 1 result no matter how many results `f(x)` produces.

## Variadic Functions

When we say something is *variadic*, we mean it can take it a variable number of arguments. We denote these with 3 dots (`...`), and all the arguments collected are compiled together and called the *extra arguments*. This 3 dots expression is called a *vararg expression*, and returns all extra arguments of the function.

A function that looks like this;

```lua
function foo (a, b, c)
```

can become

```lua
function foo (...)
  local a, b, c = ...
```

An issue arises if we care about trailing `nils`, or `nil` values at the end of a table. We have no way in Lua to detect this automatically, but Lua has a method called `table.pack` that takes in any number of arguments and creates a table with it. Not only that, but it has a useful field called `n` that carries the total amount of arguments inside that new table;

```lua
function nonils (...)
  local arg = table.pack(...)
  for i = 1, arg.n do
    if arg[i] == nil then return false end
  end
  return true
end
```

Lua also has this weird `select` function, that returns all parameters passed after the position of the number provided in the first position. Weird, but see;

```lua
print(select(1, "a", "b", "c")) --> a, b, c
print(select(2, "a", "b", "c")) --> b, c
print(select(3, "a", "b", "c")) --> c
print(select("#", "a", "b", "c")) --> 3
```

`select` can also help us build a faster add than the one we previously made, as long as we have a small amount of arguments, due to the cost of a table being less than many select calls;

```lua
function add (...)
  local s = 0
  for i = 1, select("#", ...) do
    s = s + select(i, ...)
  end
  return s
end
```


## `table.unpack`

This unique function allows you to return all elements in a list;

```lua
print(table.unpack{10,20,30}) --> 10 20 30
a, b = table.unpack{10,20,30} --> a = 10, b = 20, 30 is discarded
```

There is also `table.pack` which will do the opposite; pack transforms a list into a Lua list or table, and unpack takes a real Lua list or table into a return list. This allows for generic call mechanisms, which essentially let you call any function with any number of arguments. This is not allowed in some languages. An example of this in Lua;

```lua
f(table.unpack(a))
```

## Proper Tail Calls

A *proper tail call* is when a function calls another function as it's final action. In the case of Lua, this means when a function calls another function, and the first has nothing left to do, no information is stored about that function. When the second function called returns, it goes straight to where the first was called, without any lag from the first. 

```lua
function f (x) x = x + 1; return g(x) end
```

### Exercises

1. Write a function that takes an array and prints all elements

```lua
function print_all (t)
  for i = 1, #t do
	print (t[i])
  end
end
```

2. Write a function that takes an arbitrary number of values and returns all of them, except the first one

```lua
function no_first (...)
  local t = table.pack(...)
  table.remove(t, 1)
  return t
end
```

3. Write a function that takes an arbitrary number of values and returns all of them, except the last one

```lua
function no_first (...)
  local t = table.pack(...)
  table.remove(t)
  return t
end
```

---
Next: 
[Chapter 7]({{< ref "Programming in Lua - Chapter 7" >}})

