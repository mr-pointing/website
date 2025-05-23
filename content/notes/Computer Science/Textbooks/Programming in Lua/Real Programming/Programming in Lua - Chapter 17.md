---
aliases: 
draft: false
tags:
  - computerscience
  - textbook
  - lua
title: Programming in Lua - Chapter 17
date: 2025-05-19
updated: 2025-05-19T14:54
---

-------------------------------------------------------------------------------

# Modules and Packages

When it comes to Lua, there are generally no policies set in place. However, starting with Lua 5.1, there are policies set up for modules and packages. Programmers are open to follow these policies or define their own as they see fit. We consider a *module* as some code in Lua or C, and can be loaded into an environment using the function `require` that creates and returns a table. All things defined (variables, functions, etc.) are defined in the table provided.

```lua
local mod = require "mod"
mod.foo()

# another way...
local m = require "mod"
m.foo()

# another other way...
local m = require "mod"
local f = m.foo
f()

# another other OTHER way...
local f = require "mod".foo
f()
```

Each example has the same element in common, `require`.

## The Function `require`

We've seen many times how extensible Lua is; the `require` function is no different. It acts like any regular Lua function, and has minimal assumptions as to what actually defines a module. Essentially, any chunk that defines some variables is enough.

The first thing `require` will do is check a table called `package.loaded` to see if the package is already in. If it is, `require` returns whatever value(s) associated. If it isn't in the table, Lua will search for a Lua file of the same name in `package.path`, something we'll return too later. If that file is found, the function `loadfile` is called and creates a function called a *loader*. Simple; a loader loads a module/package.

To actually do the loading of said file, we need to call the loader with two arguments; the module name and the name of the file where it got the loader. If anything gets returned, `require` sends the value back and stores it inside that `package.loaded` table we mentioned previously. If no value is returned from the loader, the table entry for `package.loaded[modname]` is empty, `require` will just send back `true`.

### Path Searching

The way Lua uses paths is quite odd. ISO C (how Lua runs) does not have a traditional directory. Instead, the path used by functions like `require`, use a list of templates that can transform a module name (which is passed when using `require`) into a filename. Weird, so let's look at an example. If we wanted to call `require('sql')`, our path might look like this; `?;?.lua;c:\windows\?;/usr/local/lua/?/?.lua`, will try to open the following files;

```lua
sql
sql.lua
c:\windows\sql
/usr/local/lua/sql/sql.lua
```

By default, the path used by `require` is the current value of `package.path`. This is set up when the module `package` is initialized, with the default value being the environment variable `LUA_PATH_5_3;`.

### Searchers

`require` is, admittidly, a lot more complex than I or the text have attempted to convey. There is a lot of abstraction happening the user doesn't need to be privy too. Except we're learners, and we should (at least) try to understand what's going on.

What we're actually doing when using `require` is calling *searcher* function to take the module name and return a loader if it's found, or a `nil` if it can't. You can check out what searchers are being used by calling the table `package.loaders`. 

## The Basic Approach to Writing Modules in Lua

Lua loves simple; just create a table, add in some values or functions, and return it. Most files you'll see simply start with,

```lua
return {
  <some luaisms...>
}
```

You could also define all functions as locals and build the returning table at the end, like in the following example;

```lua
local function new (r, i) return {r=r, i=i} end

-- defines constant 'i'
local i = complex.new(0, 1)

<other functions>

return {
  new = new,
  i = i,
  add = add,
  sub = sub,
  mul = mul,
  div = div,
  tostring = tostring,
}
```

### Exercises

1. Rewrite the implementation of a double-ended queues (Listing 14.2) as a proper module
2. Rewrite the geometric-region system (9.4) as a proper module.


---
Next: 
[Chapter 18]({{< ref "Programming in Lua - Chapter 18" >}}) 
