---
aliases: 
draft: false
tags:
  - computerscience
  - textbook
  - lua
title: Programming in Lua - Chapter 15
date: 2025-05-04
updated: 2025-05-08T20:39
---

-------------------------------------------------------------------------------


# Data Files and Serialization

Writing data is usually much cleaner than reading in data. There are many different ways in which the process can be corrupted. This calls for writing well written, error-preventative code. Problem is, that's pretty hard. We can do one better; we can make our data easier to read in by writing it in readable formats. Lua makes this easy. We can write code that will generate our data objects for us. 

Lua has been used for *data description*, alongside languages like XML and JSON. They have their own pros and cons, but what makes Lua so strong is it's ease to write and read. Lua runs and compiles lighting fast (reads, compiles, and runs a program with 10 million assignments within 4 seconds).

## Data Files

we'll come back later to using other people's data later. If we are creating our own data, we can write our data out using Lua constructors.

If we had the following CSV file;

```csv
Thus Spoke Zarathustra, Freidrich Neitchze, 1883, 281
Wind and Truth, Brandon Sanderson, 2024, 1329
```

would be written as;

```lua
Entry{
  "Thus Spoke Zarathustra", "Freidrich Neitchze", 1883, 281
}
Entry{
  "Wind and Truth", "Brandon Sanderson", 2024, 1329
}
```

Now, if we write a file that runs this with a proper definition for `Entry` we can count the number of entries if we call this file `data`;

```lua
local count = 0
function Entry() count = count + 1 end
dofile("data")
print("Number of entries: " .. count)
```

Remember, `dofile` opens and runs the program, calling each `Entry` and performing the according function.

If the file size being large isn't a problem for you, you could also use key-value pair system of naming each attribute, called *self-describing data*.

```lua
-- data.lua
Entry{
  name="The Secret History",
  author="Donna Tart",
  year=1992,
  pages=572
}

-- collect authors
local authors = {}
function Entry (b) authors[b.author or "unknown"] = true end
dofile('data')
for name in pairs(authors) do print(name) end
```

## Serialization

Serialization is the process of converting some data into a stream of bytes or characters to either save or send it somewhere. The following will reconstruct saved values into whatever given program you desire;

```lua
function serialize (o)
  local t = type(o)
  if t <mark> "number" or t </mark> "string" or t <mark> "boolean" or t </mark> "nil" then
    io.write(string.format("%q", o))
  else <other cases>
  end
end
```

Our objective here is to save our data. For tables, which are harder, come in different forms depending on the type. For tables without cycles;

```lua
  local t = type(o)
  if t <mark> "number" or t </mark> "string" or t <mark> "boolean" or t </mark> "nil" then
    io.write(string.format("%q", o))
  else t == "table":
    io.write("{\n")
    for k, v in pairs(o) do
      io.write(string.format(" [%s] = ", serialize(k)))
      serialize(v)
      io.write(",\n")
    end
    io.write("}\n")
  else
    error("cannot serialize a " .. type(o))
  end
end
```


### Exercises

1. Modify the above code so that it indents nested tables


---
Next: 
[Chapter 16]({{< ref "Programming in Lua - Chapter 16" >}})  
