---
aliases: 
draft: false
tags:
  - computerscience
  - textbook
  - lua
title: Programming in Lua - Chapter 22
date: 2025-05-28
updated: 2025-05-30T10:43
---

-------------------------------------------------------------------------------

# The Environment

Now it's time to talk about *global variables*. Technically speaking, Lua doesn't actually have any. Why would you want global variables? For the most part they over complicate code, and can lead to messy implementation if caution isn't used. That being said, global variables can also help tremendously if used correctly. 

What it does have, are variables placed within a table called the **global environment**. It's a cheeky way to circumnavigate having to actually implement global variables. Lua uses a table named `_G` to store all of the global variables, and we can use the following to list out everything inside of it;

```lua
for n in pairs(_G) do print(n) end
```

## Global Variables with Dynamic Names

There are instances where we need to ensure we are get or set the value from a global variable. There are a few ways to do this, but the easiest way is to just use the global table;

```lua
-- Get
value = _G[varname]

-- Set
_G[varname] = value
```

The text offers some caution with the above; most often, these calls are unnecessary, and can be accomplished with basic variable assignment.


## Global-Variable Declarations

Lua doesn't implicitly need a declaration for a global variable. We can actually use metatables to keep track of any variables. The next two methods can be used to detect accesses to absent keys;

```lua
setmetatable(_G, {
  __newindex = function (_, n)
    error("attempt to write to undeclared variable " .. n, 2)
  end,

  __index = function (_, n)
    error("attempt to read undeclared variable " .. n, 2)
  end,
})

-- Now, anytime we try to access non-existent global vars..
print(a)
stdin:1: attempt to read undeclared variable a
```

Now declaring variables is pretty restricted. We could use `rawset`, which will ignore the metamethod we just made;

```lua
function declare (name, initval)
  rawset(_G, name, initval or false)
end
```

or, we can restrict assignments to global variables *only within functions*, and then allow free use in the outside of the chunk. This is done with the use of a line from the debug library, `debug.getinfo(2, "S")`, which returns the level the metamethod was called on (main area, function area, or C function). Let's rewrite the `__newindex` metamethod we defined previously;

```lua
__newindex = function (t, n, v)
  local w = debug.getinfo(2, "S").what
  if w ~= "main" and w ~= "C" then
    error("attempt to write to undeclared variable " .. n, 2)
  end
  rawset(t, n, v)
end
```

Checking for a value is also similar, since we have to use `rawget`;

```lua
if rawget(_G, var) == nil then
  error("var is undeclared", 2)
end
```

## Non-Global Environments

Time to explain what's *really* going on. We start with *free names*, which is any variable name not already in use by Lua or the chunk you're currently in.

```lua
local z = 10
x = y + z
```

In the previous example, the declaration of `x` was a free name, but `z` was not since it was in use. There is something happening behind the scenes; both `x` and `y` are actually being translated by the compiler to use an environment called `_ENV`;

```lua
local z = 10
_ENV.x = _ENV.y + z

-- Which is ACTUALLY read by the compiler as...

local _ENV = <a value>
return function (...)
  local z = 10
  _ENV.x = _ENV.y + z
end
```

Confusing right? `_ENV` can actually be any value (usually a table), but `load` helps us configure whatever is being used as the global environment to be used as `_ENV`.


## Using `_ENV`

To actually accomplish or test anything from this chapter, using interactive mode isn't going to cut it. All examples should be ran as a single chunk;

```lua
a = 20
local a = 25
print(a) --> 25
print(_G.a) --> 20
```

While they are usually referring to the same table, `_ENV` and `_G` are different. While `_G` is a global variable without anything special about it, `_ENV` is actually a local variable that all global accesses pass through. Formally, `_ENV` refers to the current environment, while `_G` is still just the global.

One big reason to use `_ENV` is the affect your coding environment. If you change the environment, you change a lot. For example, look at the following;

```lua
_ENV = {}
a = 1
print(a) --> stdin:4: attempt to call global 'print' (a nil value)
```

Since we reset the environment, we lost all of the global variables and functions, including all built-in functions. We can fix this by including `_G` inside the new environment declaration;

```lua
a = 15
_ENV = {_G = _G}
a = 1
_G.print(_ENV.a, _G.a) --> 1    15
```

## Environments and Modules

If you remember all the way back in Chapter 7, there was talk of modules polluting the global environment. Well, now that we have the power to create enclosed environments, this drawback becomes manageable. All new variables and functions exclusive to that module exist only within it's disclosed environment.

```lua
local M = {}
_ENV = M
function add (c1, c2)
  return new(c1.r + c2.r, c1.i + c2.i)
end
```

After we create a new module, we set up the `_ENV` to become that new table, and now all calls and declarations will be set up inside of `M`. Pretty useful.

### Exercises

2. Explain in detail what happens in the following program and what it will print;

```lua
local foo
do
  local _ENV = _ENV
  function foo () print(X) end
end
X = 13
_ENV = nil
foo()
X = 0
```


---
Next: 
[Chapter 23]({{< ref "Programming in Lua - Chapter 23" >}}) 

