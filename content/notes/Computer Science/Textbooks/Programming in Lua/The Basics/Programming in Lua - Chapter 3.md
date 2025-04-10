---
aliases: 
draft: false
tags:
  - computerscience
  - textbook
  - lua
  - syntax
title: Programming in Lua - Chapter 3
date: 2025-03-08
updated: 2025-03-12T14:24
---

-------------------------------------------------------------------------------

# Numbers

Up until recently, all numbers in Lua were floating point numbers. Now, Lua past version 5.3, has two representations for numbers; 64-bit *integers* and double-precision floating points, just *floats*.

The Lua interpreter will allow the input of numbers in whatever format you want, and return it that way (unless specified not too).

```lua
> 4 --> 4
> 0.4 --> 0.4
> 4.57e-3 --> 0.00457
> 0.3e12 --> 300000000000.0
> 5E+20 --> 5e+20
```

If you call `type()` on any number, it will always return as a `number` type. If you wanted to ensure you have an integer or float, you would have to specify it as a math type using `math.type()`.

Lua not only handles hexadecimal constants, but also floating-point hexadecimal constants:

```lua
> 0xff --> 255
> 0x1A3 --> 419
> 0x0.2 --> 0.125
> 0x1p-1 --> 0.5
> 0xa.bp2 --> 42.75
```

## Arithmetic Operators

Lua has the standard four big operators, `+` `-` `*` and `/`.

In addition, subtraction, multiplication, and negation, two integers produce an integer. If presented with integers and floats, they will produce a float.

For division, Lua will automatically convert all numbers to a float, and produce a float result. There is also the existence of *floor division*, `//`, that rounds down by default. This again follows the rule of any float in the mix causes the production of a float.

The Modulo operator, `%`, also works the same way it does in other languages, returning remainder. Exponents are used with the caret, `^`, and also always operate on floats. There are some interesting ways of using modulo that I never considered;

```lua
x = math.pi
x - x%0.01 --> 3.14
x - x%0.001 --> 3.141
```

## Relational Operators

- `<`: less than
- `>`: greater than
- `<=`: less than or equal too
- `>=`: greater than or equal too
- ` = = `: (should be together but causes an error in Obsidian) equality operator
- `~=`: not equal too

## The Mathematical Library

Like we've seen already, we can call on the math module for more functions and utilities we can use in our calculations;

```lua
> math.sin(math.pi / 2) --> 1.0
> math.max(10.4, 7, -3, 20) --> 20
> math.huge --> inf
```

### Random Number Generator

Three ways we can easily generate a random number:

1. `math.random()` will return a random float in the range \[0, 1)
2. `math.random(x)` will return a random integer in the range \[1, x]
3. `math.random(x, y)` will return a random integer in the range \[x, y]

### Rounding Functions

Just like with the random module, we have three options;

1. `math.floor(x)` rounds `x` down to negative infinity
2. `math.ceil(x)` rounds `x` up to positive infinity
3. `math.modf(x)` rounds `x` to 0 *and also returns the fractional part of the number* 

Weird way to explain it, but in practice it makes a lot more sense:

```lua
> math.floor (3.3) --> 3
> math.floor (-3.3) --> -4
> math.ceil (3.3) --> 4
> math.ceil (-3.3) --> -3
> math.modf (3.3) --> 3 0.3
> math.modf (-3.3) --> -3 -0.3
```

## Representation Limits

Since Lua uses 64-bit integers, we can represent numbers up to about $10^{19}$. We can actually get these upper and lower limits, through the use of `math.maxinteger` and `max.mininteger`.

```lua
> math.maxinteger --> 9223372036854775807
> math.mininteger --> -9223372036854775808
```

This is worth going over, but it's kind of strange behavior. If you exceed the limits, you'll actually *wrap back around to the beginning/end*. What does this mean? Let's look;

```lua
> math.maxinteger + 1 == math.mininteger --> true
> math.mininteger - 1 == math.maxinteger --> true
```

Weird right? These values are so large they seem insignificant, but if not anticipated, can really throw you for a loop.

Floats have a larger range ($[-2^{53}, 2^{53}]$), and up until you reach these limits, the differences between integers and floats is at best negligible.

## Conversions

Lua has a really easy to to make any number a float; add $0.0$ to it! Any integer can become a float;

```lua
> -3 + 0.0 --> -3.0
> 0x7fffffffffffffff + 0.0 --> 9.2233720368548e+18
```

Another Lua convention, we can move the other way, and forcing any number to be an integer, with the *or* operator, or the `|` sign, with a 0;

```lua
> 2^53 --> 9.007199254741e+15
> 2^53 | 0 --> 9007199254740992
```

This doesn't work the way you think it might do; it won't make any floating point number an integer if you pass in a decimal; it will actually **break**. This defeats the purpose mostly; which is why we probably want to use `math.tointeger(x)` instead, where `x` is a floating point number. Now, instead of breaking, if our `x` value has a decimal, it'll return `nil` instead. 

```lua
> 3.2 | 0
stdin:1: nuimber has no integer representation
> math.tointeger(-258.0) --> -258
> math.tointeger(2^30) --> 1073741824
> math.tointeger(5.01) --> nil
```

The text provides a useful function that will convert a number to an integer if possible, and just return it if it can't be converted;

```lua
function cond2int (x)
  return math.tointeger(x) or x
end
```

## Precedence

Here is the order of operators;

1. `^`
2. Unary Operators (`-, #, ~, not`)
3. `* / // %`
4. `+ -`
5. `..`
6. `<< >>`
7. `&`
8. `~`
9. `|`
10. `< > <= >= ~= ==`
11. `and`
12. `or`

We'll learn more about 6 - 9 in chapter 13.

### Exercises

1. Which of the following are valid numerals?
	1. `.0e12` ✔
	2. `.e12` ❌
	3. `0.0e` ❌
	4. `0x12` ✔
	5. `0xABFG` ❌
	6. `0xA` ✔`
	7. `FFFF` ✔
	8. `0xFFFFFFFF` ✔
	9. `0x` ❌
	10. `0x1P10` ✔
	11. `0.1e1` ✔
	12. `0x0.1p1` ✔

2. Explain the following results:
	1. `> math.maxinteger * 2 --> -2`
		1. The largest number wraps past the minimum, but does not reach past 0.
	2. `> math.mininteger * 2 --> 0`
		1. Smallest number plus the smallest number brings you back to 0
3. What will the following program print?

```lua
for i = -10, 10 do
  print(i, i % 3)
end
```

	1. -10	2
	-9	0
	-8	1
	-7	2
	-6	0
	-5	1
	-4	2
	-3	0
	-2	1
	-1	2
	0	0
	1	1
	2	2
	3	0
	4	1
	5	2
	6	0
	7	1
	8	2
	9	0
	10	1

4. What is the result of the expression `2^3^4`? How about `2^-3^4`?
	1. `2.4178516392293e+24`
	2. `4.1359030627651e-25`
5. The number 12.7 is equal to the fraction 127/10, where the denominator is a power of 10. Can you express it as a common fraction where the denominator is a power of two?
	1. `254/20`
6. Write a function to compute the volume of a right circular cone, given it's height and the angle between a generatrix and the axis.
7. Using `math.ranomd`, write a function to produce a pseudo-random number with a standard normal (Gaussian) distribution.


---
Next: 
[Chapter 4]({{< ref "Programming in Lua - Chapter 4" >}})

