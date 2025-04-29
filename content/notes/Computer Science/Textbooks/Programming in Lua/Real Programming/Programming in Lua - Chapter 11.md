---
aliases: 
draft: false
tags:
  - computerscience
title: Programming in Lua - Chapter 11
date: 2025-04-17
updated: 2025-04-29T17:30
---

-------------------------------------------------------------------------------

# Most Frequent Words

Another interlude chapter, this time going over a pretty simple concept; reading and counting all the words within a file. It accomplishes three main tasks;

1. Reads all of the text, storing each count of the occurring word within a table
2. Sorts the table based on the order of frequency
3. Prints all results for `n`

```lua
local counter = {}

for line in io.lines() do
  for word in string.gmatch(line, "%w+") do
    counter[word] = (counter[word] or 0) + 1
  end
end

local words = {}
for w in pairs(counter) do
  words[#words + 1] = w
end

table.sort(words, function (w1, w2)
  return counter[w1] > counter[w2] or
         counter[w1] == counter[w2] and w1 < w2
end)

local n = math.min(tonumber(arg[1]) or math,huge, #words)

for i = 1, n do 
  io.write(words[i], "\t", counter[words[i]], "\n")
end
```


### Exercises

1. When we apply this type of function to some text, usually we get uninteresting small words as our most frequent. Change the above code to only get words with a count of 4 or more characters.
2. Repeat the previous exercise, but instead of using length as the criteria for ignoring a word, the program should read from a text file a list of words to be ignored.


---
Next: 
[[Programming in Lua - Chapter 12|Chapter 12]]

