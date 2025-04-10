---
aliases: 
draft: false
tags:
  - computerscience
  - textbook
  - lua
  - syntax
title: Programming in Lua - Chapter 4
date: 2025-03-12
updated: 2025-03-15T18:29
---

-------------------------------------------------------------------------------

# Strings

A string is basically a representation of some text. They can be tiny, or huge, depending on how you'd like. We consider strings as a sequence of bytes, which we can go into more detail on later. For now, just know we can store any binary data as a string, or even Unicode representation.

Any string we make in Lua is immutable, so we can't alter it once it's made. Any alterations would have to be made to an entirely new string. Not only that, but Lua also has *automatic memory management*, so we don't have to concern ourselves with allocation and deallocation.

```lua
> a = "My string!"
> b = string.gsub(a, 'My', 'Our')
> a --> My string!
> b --> Our string!
> #a --> 10
```

A helpful operator we'll use a bunch is the length operator, or *#*. Just be careful, in certain encodings it doesn't count characters but bytes instead.

The concatenation operator is two dots, `..`. This operator also always creates a new string.

## Literal Strings

A *literal string* is any string in single or double quotation marks. If you use one, you can use the other within the same string without escaping which is a nice feature. It also has similar escape characters as Python does,

| Name            | Command |
| --------------- | ------- |
| bell            | \a      |
| back space      | \b      |
| form feed       | \f      |
| newline         | \n      |
| carriage return | \r      |
| tab             | \t      |
| vertical slash  | \v      |
| backslash       | \\\     |
| double quote    | \\"     |
| single quote    | \\'     |

Lua allows representation of characters through many formats; numeric values, hexadecimal, ASCII, and even UTF-8 characters.

```lua
> x = '\x41'
> x --> A
> y = 'ALO\n\''
> y --> ALO
		123'
> z = '\u{3b2}'
> z --> β
```

## Long Strings

You can have like, *really* long strings in Lua. They are really easy to format, just put your text between double square brackets. If you end up needing to use double quotes, you can use some amount of equal signs between the brackets to differentiate them. Just make sure to use the same amount of signs for both the opening and closing.

## Coercions

Funny things start to happen when you start mixing numbers and strings. For one, Lua will convert any string to a number if that string meets a numeric operator. Not only that, but Lua will convert any number to a string when expecting a string. The text recommends not counting on these in your programs, but to acknowledge their existence for potential bug fixing.

```lua
> print (10 .. 20)
1020
> "10" + 1
11.0
```

We can take any string and explicitly make it a number using the `tonumber()` function. You can even do some crazy things with an additional parameter to define your base number;

```lua
> tonumber ("   -3 ") --> -3
> tonumber ("  10e4 ") --> 100000.0
> tonumber ("10e") --> nil (not valid number)
> tonumber ("0x1.3p-4") --> 0.07421875
> tonumber ("100101", 2) --> 37
> tonumber ("100101", 36) --> 60467473
> tonumber ("fff", 16) --> 4095
> tostring(10) == "10" --> true
```

The last line is a small example of the reverse; how to turn a number into a string, but we have no control over the formatting of it. To avoid major issues, Lua doesn't allow comparison between numbers and strings like `2 < "15"`.

## The String Library

At the basic level, you can't do much with strings. That's what the string library is for. Let's go over some useful methods;

- `string.len(s)` will return the length of `s` (equal to `#s`)
- `string.rep(s, n)` will repeat the given string `s`, `n` times
- `string.reverse(s)` will reverse the string `s`
- `string.lower(s)` will return all the uppercase characters in `s` as lowercase
- `string.upper(s)` will return the reverse of the above
- `string.sub(s, i, j)`returns the characters from index `i` to `j` from string `s`
	- Important detail, this does not change the value of the original string, but creates a new string all together
- `string.char(x)` will return the converted characters for the given number
- `string.byte(s)` will return the converted number for the given characters
	- Useful tech; `string.byte(s, 1, -1)` to return all codes of all characters in `s`
- `string.format()` will allow for more advanced string formatting
	- Takes a few different types of substitutions
		- `d` for integer
		- `x` for hexadecimal
		- `f` for floating point
		- `s` for strings
- `string.find(s, w)` searches for patterns; returning the index numbers if `w` exists in `s`
- `string.gsub(s, w, m)` replaces all occurrences of `w` in `s` with `m`
	- Also returns the amount of replacements made

Before getting into examples, we can call any function with two different ways; like the above, or with a shorten-er, `s:function`; 

```lua
> x = "I love lucy!"
> string.len(x) --> 12
> x:rep(2) --> I love lucy!I love lucy!
> x:reverse() --> !ycul evol I
> x:upper() --> I LOVE LUCY!
> x:sub(6, 10) --> e luc
> string.char(97) --> a
> string.byte('abc') --> 97
> tag, title = "h1", "My Title"
> string.format("< %s>%s</%s>", tag, title) --> <h1>My Title</h1>
> x:find("luc") --> 8    10
> x:gsub("lucy", "money") --> I love money!	1
```


## The Unicode Library

As far as internet standards go, UTF-8 is the dominant decision for Unicode, and even has it's own library. This is because some of the functions we saw above won't work on Unicode characters. This lead to the `utf8` library. It has extremely similar functions, like `utf8.len()`, and `utf8.char()`.

### Exercises

1. How can you embed the following XML into a Lua string? In two different ways?

```XML
<![CDATA[
  Hello world
]]>
```

```lua
x = [===[
<![CDATA[
  Hello world
]]>
]===]

or

x = '<!\u{5B}CDATA\u{5B}\nHello world\n\u{5D}\u{5D}>'
```

2. Suppose you need yo write a long sequence of arbitrary bytes as a literal string. What format would you use and why?

I would use the `[ [ ] ] ` format (with spacing intentional for Obsidian).

3. Write a function that can insert a string into a given position of another one `insert("Hello world", 1, "start: ")`:

```lua
function insert (text_string, num, in_text)
  print (text_string:sub(1, num) .. in_text .. text_string:sub(num + 1, -1))
end
```

4. Redo the previous exercise for UTF-8 strings

I think you could do this with a structure like a table or list; take all the characters from a Unicode string, gets the codes for them, then uses the concatenation to insert them into the string using normal string functions. 

5. Write a function to remove a slide from a string; the slice should be given by its initial position and length;

```lua
function remove (text_string, pos, leng)
  print(text_string:sub(1, pos) .. text_string:sub((pos + leng) - 1), -1)
end
```

I can change the above with using multiple assignment to separate the index out.

---
Next: 
[Chapter 5]({{< ref "Programming in Lua - Chapter 5" >}}) 
