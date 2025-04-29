---
aliases: 
draft: false
tags:
  - computerscience
  - textbook
  - lua
title: Programming in Lua - Chapter 12
date: 2025-04-19
updated: 2025-04-22T11:34
---

------------------------------------------------------------------------------

# Date and Time

Not Lua's strong-suit, but there are ways to retrieve and filter on date and time. Although, the system is quite weird.

Lua officially has two ways of representing date and time. First is a single number, known as the number of seconds from the *epoch*, or some fixed date. POSIX and Windows use the date January 1st, 1970, 0:00 UTC.

The second is through a table that's a lot more human readable. *Date tables* have fields for `year`, `month`, `day`, `hour`, `min`, `sec`, `wday`, `yday`, and `isdst`. All are integers save for `isdst`, which is a Boolean for daylight savings. There is no time zone set.

## `os.time`

`os.time` returns the epoch number. There are a bunch of mathematical expressions you can run on that number to collect the important info like the year, day, time, etc;

```lua
local d1 = os.time()
local date2year = 365.242 -- days in a year
local sec2hour = 60 * 60 -- seconds in an hour
local sec2day = sec2hour * 24  -- seconds in a day
local sec2year = sec2day * date2year  -- seconds in a year

-- To retrieve the year
print(d1 // sec2year + 1970) --> 2025.0
print(d1 % sec2day // sec2hour) --> 21 (05 PM)
print(d1 % sec2hour // 60) --> 58
print(d1 % 60) --> 49
```

You could also get the reverse using the parameters noted above;

```lua
os.time({year=1970, month=1, day=1}) --> 54000
```

## `os.date`

Known as the reverse of `os.time`, it takes in an Epoch number, and a formatting string, and returns the date in a human readable format. There are a few nifty ways of getting information from `os.date`;

```lua
dates_t = os.date('*t') -- returns a table with index keys for each of these(year, month, day, yday, wday, hour, min, sec, isdst)
os.date('A %A in %B') --> Basic print statement that grabs the day and the month
t = 906000490
print(os.date("%Y-%m-%d", t)) --> 1998-09-16
```


## Date and Time Manipulation

Due to the way Lua handles dates and times, caution is advised. Normalization of time between two random dates, inclusion of daylight savings times and leap years, there are many conflictions that can occur. Whenever we want to do calculate the difference between two datetime objects, you can use `os.difftime` like so;

```lua
local t5_3 = os.time({year=2015, month=1, day=12})
local t5_2 = os.time({year=2011, month=12, day=16})
local d = os.difftime(t5_3, t5_2)
print(d // (24 * 3600)) --> 1123.0
```

Another cool thing we can do using `difftime` is to calculate the running time of a code block;

```lua
local x = os.clock()
local s = 0
for i = 1, 100000 do s = s + i end
print(string.format("elapsed time: %.2f\n", os.clock() - x))
```


### Exercises

1. Write a function that returns the date-time exactly one month after a given date-time (Assume the numeric coding of date-time).
2. Write a function that returns the day of the week (coded as an integer, one is Sunday) of a given date.
3. Write a function that takes a date-time (coded as a number) and returns the number of seconds passed since the beginning of its respective day.
4. Write a function that takes a year and returns the day of it's first Friday.
5. Write a function that computes the number of complete months between two given dates.
6. Write a function that computes the number of complete days between two given dates.
7. Does adding one month and then one day to a given date give the same result as adding one day and then one month?
8. Write a function that produces the system's time zone.


---
Next: 
[Chapter 13]({{< ref "Programming in Lua - Chapter 13" >}})

