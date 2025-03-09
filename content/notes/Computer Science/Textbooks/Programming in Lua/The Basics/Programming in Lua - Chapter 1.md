---
aliases: 
draft: false
tags:
  - computerscience
  - lua
  - textbook
  - syntax
title: Programming in Lua - Chapter 1
date: 2025-03-02
updated: 2025-03-06T18:47
---

-------------------------------------------------------------------------------

# Getting Started

Just like any other language, standard output is a great first step. To do so on a windows machine, you have to download Lua much like you do Python, and run it via the command line. The fastest way I did this was through a command line installer [scoop](https://scoop.sh/), and installed it with `scoop install lua`. Then just use `lua` to run your environment.

A simple `print()` will put anything on the screen:

```lua
> print("Hello world!")
Hello World!
```

Or you can save files and run entire files, say if the above was stored in a `hello.lua` file, simply call `lua hello.lua`.

The next example is how to write a basic factorial function using recursion:

```lua
-- defines a factorial function
function fact (n)
  if n == 0 then
    return 1
  else
    return n * fact(n - 1)
  end
end

print("Enter a number: ")
a = io.read("*n")   -- reads a number
print(fact(a))
```

## Chunks

We call any piece of Lua can execute a *chunk*. A chunk can be a file or even a single command. You could more formally define one as a **sequence of commands**. It can be as large as we wish, Lua can compile large chunks without issue.

With Lua installed on your device, you can begin typing in the Lua environment. To exit, use `os.exit()`. You could even pass in files into interactive mode with it `-i` option. Or, you can `dofile("filename")` in interactive mode to load it as a library, like in the example below:

```lua
> dofile('fact.lua')
> n = fact(3)
> n    -> 6
```

A useful way to work with Lua is through a combination of the command line and a lite text editor.

## Lexical Conventions

We consider *names* to be valid if they are a combo of any string of letters, numbers, and underscores, as long as it doesn't begin with a digit or an underscore followed by capitals (`_VERSION`). Some use `_` as a valid variable for dummy data.

Lua is case sensitive and does have a slew of reserved words. Comments are denoted with two hyphens (`--`) and multiline comments (`--[ [ some content ] ]--`).

Lua does not need a separator between statements but a semicolon is allowed for readability, and line breaks are not significant.


## Global Variables

For Lua, *Global Variables* do not need declarations in order to use them. Lua has this cool system where calling an undeclared variable won't actually break it, it will just return `nil`. Interesting way to determine if a variable exists or not.

```lua
> b --> nil
> b = 10
> b --> 10
> b = nil
> b --> nil
```

## Types and Values

Lua is dynamically typed. Variables will take any value you pass them, meaning there are *no type definitions*. There are eight basic types; *nil, Boolean, number, string, userdata, function, thread,* and *table*. The one I didn't recognize at all was userdata, which they explained as representations for new datatypes created by applications.

### Nil

Lua's non-value, mostly used like we said above, to represent the absence of meaningful data. A cool tip is you can actually delete variables by setting them to `nil`.

### Booleans

Having both *true* and *false*, they act much like many other language Boolean expressions. One Lua-ism is in conditional testing, you'll get a return of `false` on only two occasions: a Boolean `false` value or set to `nil`. Everything else is true (including 0 and an empty string!).

You can do some cool things with Lua's logical operators; `and` returns false if the first operand is false, and otherwise simply returns the second operand. `or` will give back the first operand if not false, and again just send back the second's value. This is called *short-circuit operation*, where the second parameter isn't read unless it has to be.

```lua
> 4 and 5 --> 5
> nil and 13 --> nil
> false and 13 --> false
> 0 or 5 --> 0
> false or 'hi' --> 'hi'
> nil or false --> false
```

Another Lua-ism they provide is the statement `x=x or v`, which really means `if not x then x = v`. Basically sets `x` to `v` if `x` is not already set or `false`.

More examples!, `(a and b or c)`. `and` has a higher precedence `or`. For the maximum of two numbers, you can use `(x>y) and x or y`.

You can also use the `not` operator to get a return of a Boolean.

## The Stand-Alone Interpreter

Like I mentioned above, we can use the Lua interpreter to do some neat things. Some more useful options:

- `-e` allows for entry of code prior to entering interactive mode
	- `lua -e "print(math.sin(12))"`
- `-l` allows to pass in a Lua file as a library
	- `lua -llib`


### Exercises

1. Run the factorial example. What happens if you enter a negative number? How can you avoid that? Modify the code to avoid the issue.

The issue is that it get's caught in a recursive loop and breaks. One way to fix this is include `if n < 0 return nil` before checking to see if it's equal to 0.

2. Running the factorial example, load the function with the `-l` option and the `dofile()` method. Which do you prefer?

I personally preferred the `dofile()` method, because it allowed for me to use the function multiple times. In the `-l` method I couldn't get it to be globally recognized.

3. Can you name another language that uses `--` for comments?

SQL!

5. What is the value of `type(nil)==nil`, and can you explain why?

It will return `false`, which makes sense. The type of `nil` is a `nil` type, which is *not* `nil`. 

6. How can you check whether a value is a Boolean without using `type()`?

```Lua
function isbool (x)
  return x <mark> true or x </mark> false
end
```

7. Are the parenthesis necessary in the following example? `(x and y and (not z)) or ((not y) and x)`

No, but they could be useful for readability.

8. Write a script that print's it's own name without knowing it in advance

`print("My name is '"...arg[0]..."'")`

Genuinely confused on how anyone was supposed to know that from just reading the first chapter but I'll take it.



---
Next: 
[Chapter 2]({{< ref "Programming in Lua - Chapter 2" >}}) 
