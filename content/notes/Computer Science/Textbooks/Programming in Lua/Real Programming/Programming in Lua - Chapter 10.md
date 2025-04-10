---
aliases: 
draft: false
tags:
  - computerscience
  - textbook
  - lua
title: Programming in Lua - Chapter 10
date: 2025-04-09
updated: 2025-04-09T17:47
---

-------------------------------------------------------------------------------

# Pattern Matching

Due to Lua's goal of maintaining a lite and quick language, it relies on it's own method of pattern matching rather than POSIX regex or even Perl regex.

## Pattern Matching Functions

There are four pattern matching functions within Lua's standard string library. We've actually already seen two of them, `find` and `gsub`. We will cover those in slightly more detail, as well as the other two, `match` and `gmatch`.


### `string.find`

Simply searches for a pattern inside a given string. The return of `find` is the first position of the pattern, and the last position of said pattern. If a match isn't found, Lua returns `nil`. 

```lua
s = "Hello world!"
i, j = string.find(s, "Hello")
print(i, j) --> 1   5
print(s:find("Hello")) --> 1   5
print(string.sub(s, i, j)) --> Hello
print(s:find("lll")) --> nil
```

There are also two optional parameters you can pass in, and they work a little strangely. The third is simple enough, it's an index on where to begin the search. The fourth however, is a Boolean value to indicate a *plain search*, or a search that does not recognize patterns.

```lua
> string.find("A [word]", "["])
stdin:1: malformed pattern (missing ']')
> string.find("A [word]", "[", 1, true)
3   3
```

In the above example, because square brackets have a special relationship, when you search for one it will automatically try to find the second. In order to just find one, we should set the fourth parameter to `True`.

### `string.match`

A method that works similarly to `find`, but instead of returning Index numbers, it returns the pattern. This is useless with string data, as we can see below;

```lua
> string.match("Hello World", "Hello")
Hello
```

The power comes in when used alongside variable patterns, which we'll go into more detail later on. For now, let's look at an example;

```lua
date = "Today is 9/4/2025"
d = string.match(date, "$d+/%d+/%d+")
print(d) --> 9/4/2025
```

### `string.gsub`

A useful function that replaces a string for each pattern inside a given string. It takes three mandatory parameters; a subject string, the pattern to search for in the subject string, and the replacement string. if the replacement can't be done, it just returns the unmodified string. An optional fourth parameter allows you to control how many instances you want to change;

```lua
s = string.gsub("Lua is bunk", "bunk", "awesome")
print(s) --> Lua is awesome
a = string.gsub("A lil bit of luck", "l", "x")
print(a) --> A xix bit of xuck
b = string.gsub("A lil bit of luck", "l", "x", 2)
print(b) --> A xix bit of luck
```

Another interesting use is as an additional return, it will send back the number of changes it made. 

```lua
a, b = string.gsub("A lil bit of luck", "l", "x")
print(b) --> 3
```


### `string.gmatch`

A more complex function, `string.gmatch` returns an anonymous function that will iterate over all occurrences of a given pattern. The syntax is deceptively simple, so let's take a look before we dive into the actual pattern matching portion of this chapter. The following example will iterate over all words in the given string, and store all words in a table called `words`;

```lua
a = "Some cool words that I like"
words = {}
for w in string.gmatch(a, "%a+") do
  words[#words + 1] = w
end
```

## Patterns

Lua treats patterns like any other string; they follow the same rules as traditional strings. The only way to identify a pattern is with the percent sign.

### Character Classes

