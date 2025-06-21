---
aliases: 
draft: false
tags:
  - computerscience
  - textbook
  - lua
title: Programming in Lua - Chapter 20
date: 2025-05-23
updated: 2025-05-23T12:20
---

-------------------------------------------------------------------------------


# Metatables and Metamethods

There are a few things that aren't possible within Lua by default, like adding tables, comparing functions, or calling a string. All of this and more is possible with the implementation of *metatables*. Metatables give us the ability to give context to unused operators for objects. Metatables have *metamethods*, or methods that are within metatables that are called in these new situations. 

The text refers to metatables as a restricted type of class, but they don't fail to mention that they're even more strict, since the operations are limited. Any value in Lua can have a metatable, but they are split up into tables or userdata who have their own metatables, while all variables share one giant metatable.

```lua
t = {}
print(getmetatable(t)) --> nil
t1 = {}
setmetatable(t, t1)
print(getmetatable(t) == t1) --> true
```

We can only set metatables of tables, and the string library has a metatable for strings.

## Arithmetic Metamethods

We can easily make set union, intersection, and others;

```lua
local Set = {}

function Set.new (l)
  local set = {}
  for _, v in ipairs(l) do set[v] = true end
  return set
end

function Set.union (a, b)
  local res = Set.new{}
  for k in pairs(a) do res[k] = true end
  for k in pairs(b) do res[k] = true end
  return res
end

function Set.intersection (a, b)
  local res = Set.new{}
  for k in pairs(a) do
    res[k] = b[k]
  end
  return res
end

function Set.tostring (set)
  local l = {}
  for e in pairs(set) do
    l[#l + 1] = tostring(e)
  end
  return "{" .. table.concat(l, ', ') .. "}"
end

return Set
```

Then, we can modify and some functions;

```lua
local mt = {} -- creates a metatable for sets

-- modify Set.new() which creates sets
function Set.new(l)
  local set = {}
  setmetatable(set, mt)
  for _, v in ipairs(l) do set[v] = true end
  return set
end

-- now every new set has the same metatable
s1 = Set.new{10, 20, 40, 50}
s2 = Set.new{30, 1}
print(getmetatable(s1) == getmetatable(s2)) --> true

-- We can create how the addition sign works
mt.__add = Set.union
s3 = s1 + s2
print(Set.tostring(s3))  --> {1, 10, 20, 30, 50}

mt.__mul == Set.intersection
print(Set.tostring((s1 + s2)*s1)) --> {10, 20, 30, 50}
```

We could also change for subtraction, float division, floor division, negation, modulo, exponentiation, concatenation, and all bitwise operators.

Lua will always use the metamethod of an object if that corresponding metatable has a metamethod, then check the second value for a metatable with the same metamethod of the first. If the metamethods are the same, the action will be performed. If not found, an error will be raised. We can prepare for incoming issues like this with the following change;

```lua
function Set.union (a, b)
  if getmetatable(a) ~= mt or getmetatable(b) ~= mt then
    error("Attempt to 'add' a set with a non-set value", 2)
  end
  <rest of code>
```

## Relational Metamethods

Just like with the mathematical operations above, we can manipulate relational operators as well. Less than, equal to, and less than or equal to. There are no others. We can continue with the previous example with the concept of set containment: `a <= b` means that `a` is a subset of `b`.

```lua
mt.__le = function (a, b) -- subset
  for k in pairs(a) do
    if not b[k] then return false end
  end
  return true
end

mt.__lt = function (a, b) -- proper subset
  return a <= b and not (b <= a)
end

mt.__eq = function (a, b) -- equality
  return a <= b and b <= a
end
```

## Library-Defined Metamethods

Since metatables are just regular tables, anyone can use them; this leads to libraries defining and using their own fields within metatables. If we look at a quick example, the `print` function will use `tostring` to format output. However, this doesn't always do the thing we want. For a table, we get the following;

```lua
print({}) --> table: 0x7f8958fc5e28
```

What Lua actually does here is check if we have overwritten the `__tostring` metamethod, and uses that if there is one. Since we've already written a `tostring` method for our set example, we can follow suit and do the following;

```lua
mt.__tostring = Set.tostring
s1 = Set.new{10, 4, 5}
print(s1) --> {4, 5, 10}
```

Not only can we redefine existing functions, we can also set up our metatables to not allow any changes or views. If you give a value to `__metatable`, both calls to `getmetatable` and `setmetatable` will cause issues;

```lua
mt.__metatable = "None of your beeswax!"

s1 = Set.new{}
print(getmetatable(s1)) --> None of your beeswax!
setmetatable(s1, {})
  stdin:1: cannot change protected metatable
```

## Table-Access Metamethods

All we've done so far is change the way Lua interacts with situations that would otherwise raise an error; let's change some of the **behavior** of Lua in otherwise normal circumstances.

### The `__index` Metamethod

We have seen many times that whenever you are trying to access a field that doesn't exist within a table, we get `nil` as a result. What's happening behind the scenes is a search for an `__index` metamethod to provide something to send back. If there isn't, *then* we get `nil`. 

The most straightforward example of when we'd need this is when wanting object inheritance. The text uses a great example of Window creation (physical windows, not computer windows). We start with the base version;

```lua
prototype = {x = 0, y = 0, width = 100, height = 100}
```

Then build out from here;

```lua
local mt = {} -- Create the metatable
function new (o)
  setmetatable(o, mt)
  return o
end

mt.__index = function (_, key) -- Set up the __index metamethod
  return prototype[key]
end

w = new{x=10, y=20}
print(w.width) --> 100
```

Lua developers have seen this happen so often they actually developed a shortcut; just set the `__index` metamethod to the table declaration. Instead of a function, pass in a table;

```lua
mt.__index = prototype
```

This is a fast and easy to read approach. Obviously, a function pass has more flexibility, which we will sometimes need. If you want to access a table without having it reach out to it's `__index` metamethod, you could use `rawget(t, i)`, where `t` is a table and `i` is the value you're searching for.

### The `__newindex` method

The counterpart for `__index`, but instead of affecting accesses, `__newindex` affects table updates. Whenever assigning a value to a table with a new index, the table first looks for `__newindex`, and calls that instead of assigning. If the metamethod is a table, assignment is done within the table. There is also `rawset(t, k, v)` which is the equivalent of `t[k] = v` without using the `__newindex` metamethod.

With both metamethods, `__index` and `__newindex`, Lua can create read-only tables, default value tables, and helps out with object-oriented programming with it's inheritance.

#### Tables with Default Values

```lua
function set_default (t, d)
  local mt = {__index = function () return d end}
  setmetatable(t, mt)
end

tab = {x=10, y=20}
print(tab.x, tab.z) --> 10   nil
set_default(tab, 0)
print(tab.x, tab.z) --> 10   0
```

Now, anytime you try to access a non-existent index in `tab`, `0` will be returned. Pretty useful, but can be expensive if you have a lot of default values. Since we hard-coded the `0` in for the value of `d`, we are unable to use this metatable for other tables with different default values. If we wanted to use only one metatable, we would have to adjust it accordingly;

```lua
-- If we are not worried about name clashing
local mt = {__index = function (t) return t.___ end}
function set_default (t, d)
  t.___ = d
  setmetatable(t, mt)
end

-- If we are worried about name clashing
local key = {}
local mt = {__index = function (t) return t[key] end}
function set_default (t, d)
  t[key] = d
  setmetatable(t, mt)
end
```

### Exercises

1. Define a metamethod `__sub` for sets that return the difference of two sets (`a - b` returns elements from `a` that are not in `b`)
2. Define a metamethod `__len` for sets so that `#s` returns the number of elements in the set `s`


---
Next: 
[Chapter 21]({{< ref "Programming in Lua - Chapter 21" >}}) 
