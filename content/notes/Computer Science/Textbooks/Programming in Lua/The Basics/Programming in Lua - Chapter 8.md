---
aliases: 
draft: false
tags:
  - computerscience
  - textbook
  - lua
  - syntax
title: Programming in Lua - Chapter 8
date: 2025-03-25
updated: 2025-03-26T16:53
---

-------------------------------------------------------------------------------

# Filling in Some Gaps


A quick send off chapter for the basics of Lua. Let's review some key components that are necessary, but maybe doesn't need an entire chapter.

## Local Variables and Blocks

Quite simply, Lua makes all variables global by default. To specify a local variable, you have to call it with `local` in front. Local variables only have a scope inside the block it was declared in.

It's considered a good programming habit to use local variables when possible. It allows for less confusion with existing global variables, it's cleaner, and also faster as access to local variables is faster than global variables.

An idiom the text offers is `local foo = foo` after declaring `foo`. As we know, we now have faster access.

## Control Structures

### `if then else`

Works just like any other if statement. Syntax works like this;

```lua
if a < 0 then a = 0 end

if a < b then return a else return b end

if line > MAXLINES then
  showpage()
  line = 0
end
```

All uses are valid in Lua. You can also nest if statements with as many `elseif` statements as you'd like.

### `while`

Repeats a block of code based on the condition being true;

```lua
local i = 1
while a[i] do
  print(a[i])
  i = i + 1
end
```

### `repeat`

An interesting structure, performs a block of code based on the condition being false;

```lua
local line
repeat
  line = io.read()
until line ~= ""
print(line)
```

### Numeric `for`

Weirdly enough, `for` is used in two different ways. For numbers, it will execute some block of code for each value given a range;

```lua
for var = exp1, exp2, exp3 do
  <something>
end
```

In the above, we move from the value of `var` set to `exp1`, until it is equal to `exp2`. `exp3` is an optional parameter indicating step. This works a lot like the `range` function in Python. One Lua idiom that's useful is using `math.huge` as the upper bound.

The value of `var` is only local to the `for` loop; if we leave the loop, we no longer have access to whatever value is associated with `var`. We'd have to use another variable to assign it too.

### Generic `for`

Really not much different, but used in the way we've been using it in past examples. We use `for` to move through some iterator, like `ipairs`, `pairs`, or `io.lines`. 

## `break`, `return`, and `goto`

Whenever we are in a block of code, we can use `break` or `return` to leave that block. On the flip side, `goto` will bring you to any location within a function.

Put simply, use `break` to finish any loop structure; it will bring you back to where you entered the loop and will not work if used outside a loop.

`return` sends back a value from a specific function.

`goto` jumps the executing code's cursor to a specified label with the syntax `::name::` . It works a lot like a continue statement. 

```lua
while some_condition do
  ::redo::
  if some_other_condition then goto continue else if yet_another_condition then goto redo end
  <some code>
  ::continue::
end
```

Here's an example using `goto` to create a simple maze game;

```lua
goto room1 -- initial room

::room1:: do
  local move = io.read()
  if move == "south" then goto room3
  elseif move == "east" then goto room2
  else
    print("invalid move")
    goto room1 -- stay in room
  end
end

::room2:: do
  local move = io.read()
  if move == "south" then goto room4
  elseif move == "west" then goto room1
  else
    print("invalid move")
    goto room2
  end
end

::room3:: do
  local move = io.read()
  if move == "north" then goto room1
  elseif move == "east" then goto room4
  else
    print("invalid move")
    goto room3
  end
end

::room4:: do
  print("Congrats! You made it!")
end
```


---
Next: 
[Chapter 9]({{< ref "Programming in Lua - Chapter 9" >}}) 
