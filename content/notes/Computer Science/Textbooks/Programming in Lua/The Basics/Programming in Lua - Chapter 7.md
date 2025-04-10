---
aliases: 
draft: false
tags:
  - computerscience
  - textbook
  - lua
  - syntax
title: Programming in Lua - Chapter 7
date: 2025-03-23
updated: 2025-03-25T18:44
---

-------------------------------------------------------------------------------

# The External World

Lua is not the language for powerful performance with the exterior world. Even the text admits that most use of Input and Output are done through the host application or external libraries. Lua can handle basic file manipulation, which we'll review now.

## The Simple I/O Model

Lua assumes the use of two streams, the *current input stream* and the *current output stream*. Using C terminology, the current input is default `stdin` while output is `stdout`. We can route either using `io.input` and `io.output`, respectively.

`io.write` will take in any amount of strings and write them to the currently set output stream. A nice tip the text uses is avoiding the concatenation operator to create dynamic strings;

```lua
io.write(a..b..c) --> avoid
io.write(a, b, c) --> nice!
```

Now with `io.write` introduced, `print` should only be used for quick printing/debugging;

```lua
> io.write("sin(3) = ", math.sin(3), "\n") 
--> sin(3) = 0.14112000805987
```

`io.read` takes a few different arguments, controlling how the content is read;

| Parameter | Value                                      |
| --------- | ------------------------------------------ |
| `"a"`     | reads the whole file                       |
| `"l"`     | reads the next line (dropping the newline) |
| `"L"`     | reads the next line (keeping the newline)  |
| `"n"`     | reads a number                             |
| `num`     | reads `num` characters as a string         |
Working with reading and writing to files is quite strange. After reading all contents to a file, if you try to assign that same file to another variable using the same connection as before, you get nothing in return, since you already read everything in. Honestly it gets easier in the next part, let's just jot down some of the important functions they gave us;

```lua
local lines = {}

for line in io.lines() do
  lines[#lines + 1] = line
end

table.sort(lines)

for _, l in ipairs(lines) do
  io.write(l, "\n")
end
```


## The Complete Model

For more advanced stuff, we'll have to rely on C. Opening a file is a great place to start; we can use `io.open` and pass in a file path and a *mode*. Mode determines what the opening can do; `w` for write, `r` for read, and `a` for appending. You can also use `b` for binary files.

This is where we get better control over our file opening. We can use assert to check for errors, open a file, and have a variable display it's contents;

```lua
local f = assert(io.open('a.txt', 'r'))
local t = f:read('a')
f:close()
print(t)
```

You can also define which output stream your content flows too; `io.stdin`, `io.stdout`, and `io.stderr`.

```lua
io.stderr:write(message)
```

`io.lines` will also work as `io.read` does, and changes the read to another stream. 

## Other Operations on Files

Some cool functions:

- `io.tmpfile`: returns a stream over a temporary file, that opens it in a read and write mode that automatically deletes the file upon completion of the program
- `flush`: an execution statement for all pending writes to a given file
	- `io.flush()` for current output stream
	- `f:flush()` for stream `f`
- `seek`: gets and sets the current position of a given string
	- Syntax: `seek(whence, offset)`
	- When used on a file, just pass in one of these offsets
		- `cur`: default, current stream position
		- `set`: sets the position to the beginning of the file
		- `end`: sets the position to the end of the file
- `os.rename`: changes the name of a file
- `os.remove`: removes a file

## Other System Calls

Some cool system calls;

- `os.exit`: exits a program
- `os.getenv`: gets value of an environment variable
	- `print(os.getenv("HOME"))`
- `os.execute`: runs a system command
	- `function createDir (dirname); os.execute("mkdir " .. dirname); end`
- `io.popen`: runs a system command, but creates and connect a new input/output stream

### Exercises

1. Write a program that reads a text file and rewrites it with its lines sorted in alphabetical order. When called with no arguments, it should read from standard input and write to standard output. When called with one file name argument, it should read from that file and write to standard output. When called with two file name arguments, it should read from the first file and write to the second.

Just getting the first part was hard enough on my own, mostly because I wasn't understanding how to properly write to a text file, but after looking through my notes and the text I realized I just need to call it with the right permissions after reading, rather than passing in both at the same time;

```lua
function sort_text()
  f = assert(io.open('a.txt', 'r'))
  
  local newt = {}
  
  for count = 1, math.huge do
    local line = f:read("l")
	if line == nil then break end
	newt[#newt + 1] = line
  end
  

  table.sort(newt)
  
  f:close()
  f = assert(io.open('a.txt', 'w'))
  for _, l in ipairs(newt) do
    f:write(l, "\n")
  end
  
  f:close()
end

sort_text()
```


---
Next: 
[Chapter 8]({{< ref "Programming in Lua - Chapter 8" >}}) 
