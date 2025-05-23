---
aliases:
draft: false
tags:
  - computerscience
  - textbook
  - lua
title: Programming in Lua - Chapter 13
date: 2025-04-22
updated: 2025-04-22T11:42
---

---

# Bits and Bytes

Not a dense chapter, but we should recognize that Lua handles binary data very similarly to text. Let's dive right into it.

## Bitwise Operators

There are a few Lua operators that work only on integers and binary data; `&` or AND, `|` or OR, `~` or BITWISE OR, `>>` or SHIFT RIGHT, `<<` or SHIFT LEFT, and `~` which can also mean BITWISE NOT.

```lua
string.format("%x", 0xff & 0xabcd) --> cd
string.format("%x", 0xff | 0xabcd) --> abff
```

## Unsigned Integers

Essentially, unsigned integers are any numbers that can only represent non-negative values. By default, Lua does not support them, but there are workarounds that can help implement them in necessary.

## Packing and Unpacking Binary Data

You can use `string.pack` to pack values into binary strings, and `string.unpack` to accomplish the opposite;

```lua
s = string.pack("iii", 3, -27, 450)
\#s --> 12
string.unpack("iii", s) --> 3  -27  450  13
```

In the above example, we pack 3 integer values into s, 3, -27, and 450. We know it's 3 based on the first parameter, `iii`. Returning the length before going for any output is important for the output; when we unpack those numbers using again `iii` as our parameter, we get those numbers back with the position of the cursor. In this case, `13`, since we had up to 12 characters being used in `s` already.

You could even give `unpack` a third additional argument, where to start reading. The next example is a unique use case for this, `"z"` refers to a zero-terminated string;

```lua
s = "What's\0up\0chatroom?\0"
local i = 1
while i <= # s do
  local res
  res, i = string.unpack("z", s, i)
  print(res)
end
--> What's
--> up
--> chatroom?
```

---

Next:
[[Programming in Lua - Chapter 14|Chapter 14]]
