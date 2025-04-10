---
aliases: 
draft: false
tags:
  - computerscience
  - textbook
  - lua
title: Programming in Lua - Chapter 9
date: 2025-03-26
updated: 2025-04-09T09:04
---

-------------------------------------------------------------------------------


# Closures

The first advanced topic, more of a clarification, let's discuss the true nature of functions and how they're treated in Lua.

Any function inside Lua is a *first-class value*, meaning they are treated with similar properties as strings and numbers. This implies that not only can we store functions inside of variables, but we can also pass functions as arguments.

Another concept that gives Lua additional flexibility is *lexical scoping*, meaning nested functions have automatic access to variables in their enclosing function.

## First-Class Values

Just like we mentioned above, we can use functions in really interesting ways, like storing them as table values or even rewriting existing functions;

```lua
> a = {p = print}
> a.p("Hello World!") --> Hello World!
> print = math.sin
> a.p(print(1)) --> 0.84147...
> math.sin = a.p
> math.sin(1, 2) --> 1   2
```

The basic syntax of a function can be written in either of the following ways;

```lua
function foo(x) return 2*x end
or
foo = function (x) return 2*x end
```

In our second example, the `function(x) body end` portion is known as the *function constructor*, and the layout of this syntax means we can have something called *anonymous functions*. Essentially, functions that are not named that are called exclusively in the context they're written in. `print` as a function is just a name, `print` is only a variable that performs the printing function.

We consider any function that takes another function as an argument to be a **higher order function**. For example, if you wanted to sort a table based on a field called `name` in reverse alphabetical order, you would use the `sort` function like so;

```lua
table.sort(network, function (a, b) return (a.name > b.name) end)
```


## Non-Global Functions

Not only can we use global variables to store functions, but we've seen them stored as table fields. Here's a great example from the text of a unique Lua way to create some table scoped functions;

```lua
Lib = {}
function Lib.foo (x, y) return x + y end
function Lib.goo (x, y) return x - y end
```

We can even use them in local variables. This becomes really useful in creating non-conflicting functions. We call these **local functions**. The syntax is as simple as;

```lua
local function f (<params>)
 <body>
end
```

It is prone to errors if not used correctly. If you want to use recursion, the text offers a nice solution to this by initializing the variable as local, then passing in the function;

```lua
local fact
fact = function (n)
  if n == 0 then return 1
  else return n * fact(n - 1)
  end
end
```


## Lexical Scoping

Like we just learned, the ability to store functions within a function is a powerful method, them being able to access variables save space and time. The text demonstrates a great use case for this- a counter.

```lua
function newCounter ()
  local count = 0
  return function ()
           count = count + 1
           return count
        end
end

c1 = newCounter()
print(c1()) --> 1
print(c1()) --> 2
```

In the above example, the variable `count` inside the closing function within `newCounter` is what we consider a *non-local variable*. It is technically not a global variable or a local variable, it belongs to `c1`. Now, if we make a new instance of `newCounter`, it'll be totally separate;

```lua
c2 = newCounter()
print(c2()) --> 1
print(c1()) --> 3
print(c2()) --> 2
```

When discussing closures, we consider the value the closure itself, not the function. Weird, but this justifies things like *callback functions* (functions that are used simulate multiple similar options) and overwriting existing functions. The later is extremely interesting, as this allows for the user to implement their own versions of already existing functions to suit their needs. A really neat example is the ability to create secure *sandboxes*, or secure environments, by restricting the files a program can access;

```lua
do
  local oldOpen = io.open
  local access_OK = function (filename, mode)
    <check access stuff>
  end
  io.open = function (filename, mode)
    if access_OK(filename, mode) then
      return oldOpen (filename, mode)
    else
	  return nil, "access denied"
	end
  end
end
```

### Exercises

2. What will be the output of the following chunk?

```lua
function F (x)
  return {
    set = function (y) x = y end,
    get = function () return x end
    }
  end
o1 = F(10)
o2 = F(20)
print(o1.get(), o2.get())
o2.set(100)
o1.set(300)
print(o1.get(), o2.get())
```


---
Next: 
[Chapter 10]({{< ref "Programming in Lua - Chapter 10" >}}) 
