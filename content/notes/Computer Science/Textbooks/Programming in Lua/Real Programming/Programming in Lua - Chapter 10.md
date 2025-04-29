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

| Sign | Representation                     |
| ---- | ---------------------------------- |
| .    | All characters                     |
| %a   | Letters                            |
| %c   | Control characters                 |
| %d   | Digits                             |
| %g   | Printable characters except spaces |
| %l   | Lowercase letters                  |
| %p   | Punctuation characters             |
| %s   | Space characters                   |
| %u   | Uppercase letters                  |
| %w   | Alphanumeric characters            |
| %x   | Hexadecimal digits                 |
To get the compliment to any of these commands, just use the uppercase version of the sign. In the below example, we use uppercase A to get all non-letter characters.

```lua
> string.gsub("hello, up-down!", "%A", ".")
hello..up.down.
```

There are some characters that are known as *magic characters*, (`( ) . % + - * ? [ ] ^ $`) that must be escaped explicitly using the `%` sign. An interesting we can do if none of the above classes can help us, is create our own with *char sets*. Char sets are create with two brackets, like in the following `[%w_]` that captures alphanumeric characters as well as underscores, or the following example that counts the number of vowels;

```lua
_, nvow = string.gsub(text, "[AEIOUaeiou]", "")
```

We could also use ranges when defining charsets, but it's pretty specific since most useful ranges are already defined. One way we can improve our uses of patterns is with modifiers. These allow for multiple parts or repetitions. 

| Sign | Meaning                     |
| ---- | --------------------------- |
| `+`  | 1 or more repetitions       |
| `*`  | 0 or more repetitions       |
| `-`  | 0 or more lazy repetitions  |
| `?`  | Optional (0 or 1 occurence) |
```lua
> string.gsub("one, and two; and three", "%a+", "word")
word, word word; word word
> string.match("the number 1324 is even", "%d+")
1324
```

The `*` sign is essentially the same but will catch no repetitions. It's mostly used for catching spaces, like in this example `%(%s*%)`. The subtraction modifier will also catch 0 or more repetitions, but this time instead of looking for the longest, it will look for the shortest. A quick example to differentiate the two is when we want to get rid of all comments in a file;

```lua
> test = "int x; /* x */ int y /* y */"

> print((string.gsub(test, "/%*.*%*/", "")))
int x;
> print((string.gsub(test, "/%*.-%*/", "")))
int x;  int y;
```

The question mark will do exactly as it says; catch an optional character. If we wanted to find an optional sign on a number in a text string, we could use `[+-]?%d+`. The question mark after the char set makes the signs optional. These modifiers can only be applied to a character class, not patterns.

If a pattern begins with a caret (`^`), it will only search the beginning of the string. Likewise, the dollar sign will only search the end of the string. The following will check if the string represents an integer number without any trailing characters: `^[+-]?%d+$`. The caret and dollar sign are only magic at the beginning and end, respectively.

An interesting character class is `%b`, or balanced strings. It takes two parameters, `x` and `y`, where both are distinct characters. You can pick any two, but these are most commonly used with enclosing structures, like `%b()` or `%b<>`.

## Captures

*Captures* are a feature in Lua that allow you to retrieve substrings that match parts of the pattern you're sending in. They're written like normal patterns, except we encase what we want to capture inside of parenthesis;

```lua
pair = "name = Luis"
key, value = string.match(pair, "(%a+)%s*=%s*(%a+)")
print(key, value) --> name  Luis

date = "Today is 4/17/2025"
m, d, y = string.match(date, "(%d+)/(%d+)/(%d+)")
print(m, d, y) --> 4  17  2025
```

## Replacements

Working very similarly to Python's format string, we can also use `string.gsub` to pass in a function to call that function for each match made and replace that match with something else. In our case, we're going to replace with global variables, called with Lua's global table `_G`. If there is no key, there is no replacement.

```lua
function expand (s)
  return (string.gsub(s, "$(%w+)", _G))
end

name = "Lua", status = "great"
print(expand("$name is $status, isn't it?"))
 --> Lua is great, isn't it?
```

If the value isn't guaranteed to be a string, we can modify our `expand` function slightly,

```lua
function expand (s)
  return (string.gsub(s, "$(%w_)", function (n)
    return tostring(_G[n])
    end))
end
```

## Tricks of the Trade

As we learned, pattern matching is an extremely powerful tool in your toolbox. With great power comes great responsibility; pattern matching is *not* a replacement for a good parser. You should never write a pattern that ends with the minus modifier, since that will only get you an empty string. Be careful when using `.*` since it can often return more than you're expecting.

### Exercises

1. Write a function `split` that receives a string and a delimiter pattern and returns a sequence with the chunks in the original string separated by the delimiter. Ex `t = split("a whole new world", " ") --> t = {"a", "whole", "new", "world"}`.
2. The patterns `%D` and `[^%d]` are the same. What about `[^%d%u]` and `[%D%U]`?


---
Next: 
[Chapter 11]({{< ref "Programming in Lua - Chapter 11" >}})
