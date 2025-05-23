---
aliases: 
draft: true
tags:
  - computerscience
  - textbook
  - lua
title: Programming in Lua - Chapter 16
date: 2025-05-08
updated: 2025-05-19T10:40
---

-------------------------------------------------------------------------------

# Compilation, Execution, and Errors

Lua is an interpreted language. Regardless, Lua will always pre-compile source code to a temporary middle-form in the *compilation phase*. This is standard practice, but feels out of place knowing that interpreted languages are known to be quick and run without any compilers. This chapter is dense and nerdy, but will explain part of the process and why Lua chooses to use that system. This chapter should probably be read on it's own, as my notes will not be sufficient.

## Compilation

Funnily enough, `dofile`, a function used just last chapter, is actually an *auxiliary function*; the work is being done by another function `loadfile`.

```lua
function dofile (filename)
  local f = assert(loadfile(filename))
  return f()
end
```

`loadfile` is nice because it does not raise errors, nut returns error codes instead, which is a nicer quality of life difference. `dofile` is great for quick and dirty uses, but for more flexibility and customization we can use `loadfile`. Part of that flexibility comes from returning not just `nil` if it errors, but the code as well. It's also significantly less costly, since we can call the returned variable from `loadfile` throughout a chunk as opposed to running `dofile` once per call.

Another expensive call, `load` works similarly to `loadfile` except it's mainly used for reading from strings or functions;

```lua
f = load("i = i + 1")
i = 0
f(); print(i) --> 1
f(); print(i) --> 2
```

This should be used with caution. The following line is not only faster but more intuitive to read personally;

```lua
f = function () i = i + 1 end
```

The following example will show another reason for `load` to not be your go to option;

```lua
i = 32
local i = 0
f = load("i = i + 1; print(i)")
g = function () i = i + 1; print(i) end
f() --> 33
g() --> 1
```

`load` will always access global variables, while functions will grab local. `load` is best used for running external code. 

## Precompiled Code

We already know that Lua precompiles source code. Lua also allows for distributing code in precompiled forms, or *binary chunks*, is with the `luac` program built in. The following creates a `prog.lc` files using the precompiled version of `prog.lua`;

```lua
luac -o prog.lc prog.lua
```

Precompiled code is not always smaller but always faster to run, and has the benefit of protecting against changes of sources. You should never run untrusted precompiled code, as that can lead to loads of different potential malicious injections.

## Errors

Due to the amount of applications that rely on Lua, crashes aren't desirable. We must be able to handle errors, which Lua does well. Anytime Lua runs into an unexpected condition it will raise an error, or you can directly call an error using the `error` function with some message for the error;

```lua
print "Give me a number please: "
n = io.read("n")
if not n then error("invalid input") end
```

Because this happens so often, Lua has a built-in function that can handle this for us, `assert`. It checks if the first argument is false, and if it is raises an error with the provided message;

```lua
print "Give me a number please: "
n = assert(io.read("n"), "invalid input")
```

Whenever running into *exceptions*, Lua has two ways of dealing with them, either returning an error code of `nil` or `false`, or raising an error. There is no explicit decision between the two, but the general rule is that *an exception that is easily avoided should raise an error; otherwise it should return an error code*.

## Error Handling and Exceptions

Since Lua is used alongside other languages, often we don't need Lua to do any much handling. If we do want to handle errors, we should use `pcall` or a *protected call* to encapsulate our chunks.

```lua
local ok, msg = pcall(function ()
  <some code>
  if unexpected_condition then error() end
  <some code>
  print(a[i])
  <some code>
end)

if ok then
  <regular code>
else
  <error-handling code>
end
```

Now, if there are no errors, `pcall` returns `true` alongside any values returned by the call. Otherwise, it returns `false` with the corresponding error message.

## Error Messages and Tracebacks

We can use any value for an error message, not just strings. During an internal error, Lua will generate the default error object, a string. If it's not a string, it's the value passed to the function `error`.

```lua
local status, err = pcall(function () error("my error") end)
print(err) --> stdin:1: my error
```

Let's look at how Lua will handle the following;

```lua
function foo (str)
  if type(str) ~= "string" then
    error("string expected")
  end
  <regular code>
end
```

If someone tries to make the following incorrect call;

```lua
foo({x = 1})
```

Lua will think the error is `foo`'s fault, rather than the person who made this call. We can fix this by appending 2 to the error call (`error("string expected", 2)`). This will let Lua know the error happened on level 2 instead of 1 (our function).

A *traceback* is the collection of calls that lead to an error message. In order to retrieve this, we have to actually make it before the call to `pcall` returns it. We can use `xpcall` in this scenario, where the second argument is a message handler function designed to call before the stack unwinds, and collects all the relevant information on the error. The two message handlers provided by Lua are `debug.debug` and `debug.traceback`. The latter is more verbose and is used by the stand-alone interpreter by default. 

### Exercises

1. Write a function, `loadwithprefix`, that works like `load`, except it adds its extra first argument as a prefix to the chunk being loaded. It should call `load` that returns the prefix, then `load` for the remaining original chunk.


---
Next: 
[Chapter 17]({{< ref "Programming in Lua - Chapter 17" >}}) 
