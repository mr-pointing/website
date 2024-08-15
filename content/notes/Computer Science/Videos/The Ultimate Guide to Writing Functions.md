---
aliases:
  - python
  - functions
draft: false
tags:
  - computerscience
  - youtube
  - python
title: The Ultimate Guide to Writing Functions
date: 2024-07-19
---
Modified: July 23 2024 

[Link](https://www.youtube.com/watch?v=yatgY4NpZXE) to video.

-------------------------------------------------------------------------------

### Tip 1: Do one thing, and do it well

A function should perform a single task.

Think about the level of abstraction; the function should be on the same level of abstraction.

He brings up two examples, one of a function that iterates through a collection, checking each value against a matcher to return if one exists. He says this has two levels of abstraction; the iteration, and the comparison.

He then uses another function that does a Luhn Checksum, then validates the persons card if said checksum returns positive. He brings up that this is doing way too much, and actually decides to split this up. Mostly because the calculation does so many things in comparison to our first example with just two objectives. 

He then brings up that even the broken up second half, that uses the checksum as a separate function and calculates some other authorization, is doing two things at once, retrieving information and returning. This leads into the second tip.

### Tip #2: Separate commands from queries

A function either does a query or does a command.

He changes the second function, the validating card function, to not have it's own function to return a value, but just perform a return on some statement.

### Tip #3: Only request information you actually need

Before, the function to validate the card would take in the entire person object, retrieving their name, home information, etc. This is hardly usable due to it taking up more space and not being as scalable. 

He updates it to take in just the persons credit card information. This also changes the call to validate, as you don't pass a person, but a persons credentials.

He also brings up that you could make them passable as keywords if you wanted by changing the passing to start with `keyword=`, and putting `*,` at the beginning of the function definition you are calling with.

### Tip #4: Keep the number of parameters minimal

With our new function that takes in the persons credit card number, expiry month and year, we now have a function that takes in three parameters. Even this looks more cluttered, and we can shorten this even further by implementing the credit card info as a class by itself. 

Instead of making a dictionary in the person class, which was my first thought, he actually makes a separate class with the `Protocol` attribute. I need to learn what this does because I don't understand how Python knows to grab `number`, `exp_month`, and `exp_year` without being explicitly told it's a card type.

He also goes over how to just remove the card information from the user all together, create a separate card class, and pass in a type `card` when you create the `person` class.

The rest of the video was okay. I have a lot more work to understand about Python classes and functions, so for right now I think I'm set.