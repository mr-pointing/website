---
aliases: 
draft: false
tags:
  - computerscience
  - lua
  - textbook
  - syntax
title: Programming in Lua - Chapter 2
date: 2025-03-06
updated: 2025-03-06T18:51
---

-------------------------------------------------------------------------------

# The Eight Queens Problem

Not a whole lot going on in this chapter, but they present a fun example of Lua's capabilities. Walking through this code is worthwhile; I recommend giving it a read first, trying it out yourself, and changing some things around to get some different outcomes.

```lua
N = 8 -- board size

-- check whether position (n,c) is free from attacks
function isplaceok (a, n, c)
  for i = 1, n - 1 do	-- for each queen already placed...
    if (a[i] == c) or 	-- same column?
	   (a[i] - i == c - n) or	-- same diagonal?
	   (a[i] + i == c + n) then	-- other diagonal?
	  return false	-- place can be attacked
	end
  end
  return true
end
 
 -- print a board
function printsolution (a)
  for i = 1, N do	-- for each row
    for j = 1, N do	-- and for each column
     -- write "X" or "-" plus a space
      io.write(a[i] == j and "X" or "-", " ")
    end
    io.write("\n")
  end
  io.write("\n")
end
 
-- add to board 'a' all queens from 'n' to 'N'
function addqueen (a, n)
  if n > N then	-- checks for all queens being placed
    printsolution(a)
  else
    for c = 1, N do
	  if isplaceok(a, n, c) then
	    a[n] = c
		addqueen(a,n + 1)
	  end
	end
  end
end

-- run the program
addqueen({}, 1) 
```

### Exercises

1. Modify the program so that it stops after printing the first solution

For me, I just put `os.exit()` after the first call for `printsolution()`. 


---
Next: 
[Chapter 3]({{< ref "Programming in Lua - Chapter 3" >}}) 
