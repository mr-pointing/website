---
aliases: 
draft: false
tags:
  - computerscience
  - textbook
  - lua
  - syntax
title: Programming in Lua - Chapter 5
date: 2025-03-17
updated: 2025-03-19T19:45
---

-------------------------------------------------------------------------------

# Tables

Funnily enough, *tables* are the only data structure natively in Lua. Tables can be used to represent basic arrays, sets, records, and others. We'll see some of these created this chapter.

By default, a table acts like a Python dictionary, or an associative array. They can contain any number or string value, **except for nil**. The tables themselves are considered objects. Programs only manipulate references to a table; Lua will never create a hidden copy of your table.

Making a table is very simple;

```lua
> a = {}  --> creates a new table
> k = "x" 
> a[k] = 10 --> creates a new entry, with the key = "x" and value as 10
> a[20] = "great" --> creates a new entry, with the key = 20 and value as "great"
> a["x"] --> 10
> k = 20
> a[k] --> "great"
> a["x"] = a["x"] + 1 --> increments entry "x"
> a["x"] --> 11
```

Something important to bring up before we move on is that tables will always be *anonymous*. This means if you use a statement like `b = a`, `b` isn't a new table, it's the **exact same** table.

## Table Indices

Since tables work with a key-value pair relationship, an index for your table can be whatever you'd like. If you try to call any index that doesn't exist, you'll just get `nil` in return. You can also refer to any index with a dot operator, `table.index`.

```lua
> a = {}
> a[10] = 100
> a["eleven"] = 110
> a[10] --> 10
> a[11] --> nil
> a.eleven --> 110
```

## Table Constructors

We've already been using *table constructors*; these are the statements that create and initialize tables. We've made empty tables, but that's not what makes Lua unique. We have to look at the next example for what makes these so versatile;

```lua
> jojos = {"Johnathan", "Joseph", "Jotaro", "Josuke", "Giorno", "Jolyne", "Johnny", "Josuke", "Jodio"}
> jojos[1] --> Johnathan
> jojos[6] --> Jolyne
> jobros = {part1 = "Speedwagon", part2 = "Caesar"}
```

Tables can also be nested. Commas can be left after the last entry, or not as they are optional.

## Arrays, Lists, and Sequences

To make an array that any other language might already support, create a table with the keys as numbers. If you already know how much space you need, the following function can help you out;

```lua
> a = {}
> for i = 1, 10 do
.   a[i] = io.read()
. end
```

Lua uses the `nil` system to implicitly keep a tables length like this; any index past the length (in the above example, 10) returning `nil`, meaning the previous index is the length. This is *only true when the list is a sequence, or has no `nil` values in the range*. You can use the `#` operator on any sequence to return it's length. If there are holes, it will **not** be accurate.

## Table Traversal

Text provides a very nice example of a simple table traversal with key-value pairs;

```lua
t = {10, print, x = 12, k = "hi"}
for k, v in pairs(t) do
  print(k, v)
end
--> 1   10
--> k   hi
--> 2   function: 0x420610
--> x   12
```

The order is random due to the way Lua stores tables. If we have a list without, we can use `ipairs` instead;

```lua
t = {10, print, 12, "hi"}
for k, v in ipairs(t) do
  print(k, v)
end
--> 1   10
--> 2   function: 0x420610
--> 3   12
--> 4   hi

-- or for a sequence...

t = {10, print, 12, "hi"}
for k = 1, #t do
  print(k, t[k])
end
--> 1   10
--> 2   function: 0x420610
--> 3   12
--> 4   hi
```

## Safe Navigation

Essentially, in some languages like C#, there are *safe navigation operators* that allow you to traverse a list or table to check for the existence of a column or sub table without breaking if encountering any `nil` values.

```c#
zip = company?.director?.address?.zipcode
```

Lua can sort of do this without having a safe navigation operator;

```lua
zip = (((company or {}).director or {}).address or {}).zipcode
```

## The Table Library

Allowing Lua to create some more data structures we should be familiar with, let's start with `table.insert()`. This is a basic insert function, that takes in a parameter as a position in the list to be inserted into (with everything after being pushed back one) or can be left without a parameter to insert to the end of the list. A fun function they give uses the input stream to store them as a sequence;

```lua
t = {}
for line in io.lines() do
  table.insert(t, line)
end
print(#t) --> number of lines read
```

Another useful function is `table.remove()` which again takes an optional parameter as a table position to pop from, or without to remove from the end of the list. We can create a very basic stack or queue (`insert` being push while `remove` acting as pop).

### Exercises

1. What will the following script print?

```lua
sunday = "monday"; monday = "sunday"
t = {sunday = "monday", [sunday] = monday}
print(t.sunday, t[sunday], t[t.sunday])
```

My guess, `sunday monday sunday`. I was wrong, it's `monday sunday sunday`.

6. Write a function to test whether a given table is a valid sequence.

```lua
function valid_sequence (seq)
  i = 0
  for k, v in pairs(seq) do
    i = i + 1
  end
  if i == #seq then
    return true
  end
  return false
end

t = {10, print, x = 12, k = "hi"}
s = {10, print, 12, "hi"}

print (valid_sequence (t))
print (valid_sequence (s))
```


---
Next: 
[Chapter 6]({{< ref "Programming in Lua - Chapter 6" >}})

