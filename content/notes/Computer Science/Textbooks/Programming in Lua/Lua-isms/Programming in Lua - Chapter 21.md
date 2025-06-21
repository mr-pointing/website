---
aliases: 
draft: false
tags:
  - computerscience
  - textbook
  - lua
title: Programming in Lua - Chapter 21
date: 2025-05-25
updated: 2025-05-28T12:28
---

-------------------------------------------------------------------------------


# Object-Oriented Programming

Like everything in Lua, we can use tables as a stand-in for many different structures. We can accomplish *Object-Oriented Programming*, or a method of programming in which all variables and functions belong to objects, using tables (of course). Objects in OOP need an identity (self), a state, operations, life cycles, etc. Lua can accomplish a lot of this using tables.

While the verbiage used can become interchangeable, we technically define *methods* as functions that belong to objects. The *self* as a concept is integral to OOP;

```lua
Account = { balance = 0 } 
function Account.withdraw (self, v)
  self.balance = self.balance - v
end

-- or we can hide self;

function Account:withdraw (v)
  self.balance = self.balance - v

-- or, we could have defined the function with the withdraw function;

Account = { balance = 0,
			withdraw = function (self, v)
			  self.balance = self.balance - v
			end
		}

-- Addtional deposit function
function Account:deposit (v)
  self.balance = self.balance + v
end
```


## Classes

So far, we have some OOP attributes, but we need *classes*. Lua does not ship with any, but metatables can suffice as a good-enough stand in. We can create a prototype object to be used for others upon creation. If we have `A` and `B`, and want to make `B` a prototype of `A`, we use `setmetatable(A, {__index = B})`. `A` will reference `B` anytime it encounters a function it does not have. To continue on our Bank account example;

```lua
local mt = {__index = Account}

function Account.new (o)
  o = o or {} -- Create table if user does not provide one
  setmetatable(o, mt)
  return o
end

a = Account.new{balance = 0}
a:deposit(100.00) -- Many ways to write this, but essentially is equal to Account.deposit(a, 100.00)
```

All values or fields from `Account` are carried over into the new creation of `a`. Even the current code can be improved upon; we can get rid of the extra table made for the metatable and just use `Account`, and use the colon operator for that nice syntactic sugar;

```lua
function Account:new (o)
  o = o or {}
  self.__index = self
  setmetatable(o, self)
  return o
end

b = Account:new() -- We used default values in the creation of Account, so that get's inherited giving b.balance an actual value
print(b.balance) --> 0 
```

## Inheritance

We've seen hints at how inheritance is trivial to implement in Lua. To really show this off, let's clarify what our `Account` class looks like now;

```lua
Account = {balance = 0}

function Account:new (o)
  o = o or {}
  self.__index = self
  setmetatable(o, self)
  return o
end

function Account:deposit (v)
  self.balance = self.balance + v
end

function Account:withdraw (v)
  if v > self.balance then error"insufficient funds!" end
  self.balance = self.balance - v
end
```

Now, let's make a new class that inherits all the fields and functions from `Account`. Then, line 2 is what's going to actually create a new subclass;

```lua
SpecialAccount = Account:new()
s = SpecialAccount:new{limit=1000.00}
```

Now, `s` is an object of class `SpecialAccount`, and anytime we use it the `self` being used by `SpecialAccount` is not referring to `Account` anymore, but `SpecialAccount`. `s`'s metatable is `SpecialAccount`. Now we can create new methods that only belong to `SpecialAccount`, or even overwrite existing methods;

```lua
function SpecialAccount:withdraw (v)
  if v - self.balance >= self:getLimit() then
    error"Insufficient funds!"
  end
  self.balance = self.balance - v
end

function SpecialAccount:getLimit ()
  return self.limit or 0
end
```

There are a few more concepts the text reviews (Multiple Inheritance, Privacy, Dual Representation) that's not super relevant for what I want to use Lua for. So for now, I'll cut this chapter short.

### Exercises

1. Implement a class `Stack`, with methods to `push`, `pop`, `top`, and `isempty`.
2. Implement a class `StackQueue` as a subclass of `Stack`. Add a method for `insertbottom`.


---
Next: 
[Chapter 22]({{< ref "Programming in Lua - Chapter 22" >}})

