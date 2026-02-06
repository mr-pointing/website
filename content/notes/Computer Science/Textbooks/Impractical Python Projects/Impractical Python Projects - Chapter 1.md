---
aliases:
draft: false
tags:
  - computerscience
  - python
title: Impractical Python Projects - Chapter 1
date: 2026-02-04
updated: 2026-02-06T08:32
---

-------------------------------------------------------------------------------


# Project #1: Generating Pseudonyms

A very simple project that we should be able to put together in a few minutes. Here's our objective; **Write a program that creates a name randomly choosing a first and last name from two given lists**. If you've solved one or two Coding Bat questions, this should be a breeze. However, it's a good idea to review exactly how we should be approaching a project of any given difficulty.

1. Understand the objective
2. Create a strategy
3. Write out a plan using Pseudocode
4. Begin coding and iterate

Seems simple enough. We already know what our objective is, so now we move onto strategy. We'll keep our names inside lists, but since we don't have to do anything except read in from this lists, we can use tuples instead. Then we have a few options on how we want to print out our newly generated name. *There are many ways to achieve most tasks in programming*. It doesn't have to be the flashiest or most exciting, it just has to get the job done. Don't ever feel bad about writing code you think won't work; you never know until you try! The last part of our strategy should be to output the newly generated name. Again, tons of ways to do this.

Now we move onto step 3, get some pseudocode written out. There is no right way to write pseudocode, so don't stress this part out too much. Just think of how you'd explain what your code is doing to someone who knows nothing about programming. Here's some basic pseudocode:

1. Create the lists for first and last name
2. Randomly select a name from each list
3. Put those selections together and return them
4. Ask the user if they want to do it again
	1. If they say yes, repeat steps 2 - 4
	2. If they say no, end the program

If you take a look at the textbook, you'll notice the author takes a few more steps than I do. Their list looks more like this;

1. Load a list of first names
2. Load a list of second names
3. Choose a first name at random
4. Assign the name to a variable
5. Choose a last name at random
6. Assign the name to a variable
7. Print the name to the screen in proper order and in red font
8. Ask the user to quit or play again
9. If the user plays again:
	1. Repeat
10. If the user quits:
	1. End and exit

Obviously, their list is not only longer but goes into more detail. This being a first and easy project, I simplified the objective heavily. However, if you have a more complicated project, this is a great approach. At this point if you've taken my courses before, we've worked on harder projects with a lot more moving parts, so I felt okay with a less detailed pseudocode. Obviously, that will change given we come across a more challenging project.

Here's the books example;

```python
import random
import sys

f_names = [
    "Baby Oil",
    "Bad News",
    "Big Burps",
    "Bill 'Beenie-Weenie'",
    "Bob 'Stinkbug'",
    "Bowel Noises",
    "Boxelder",
    "Bud 'Lite' ",
    "Butterbean",
    "Buttermilk",
    "Chad",
    "Chesterfield",
    "Chewy",
    "Cinnabuns",
    "Cleet",
    "Cornbread",
    "Crab Meat",
    "Crapps",
    "Dark Skies",
    "Dennis Clawhammer",
    "Elphonso",
    "Fancypants",
    "Figgs",
    "Foncy",
    "Gootsy",
    "Greasy Jim",
    "Huckleberry",
    "Huggy",
    "Ignatious",
    "Jimbo",
    "Joe 'Pottin Soil'",
    "Johnny",
    "Lemongrass",
    "Lil Debil",
    "Longbranch",
    '"Lunch Money"',
    '"Mr Peabody"',
    "Oil-Can",
    "Oinks",
    "Old Scratch",
    "Ovaltine",
    "Pennywhistle",
    "Pitchfork Ben",
    "Potato Bug",
    "Pushmeet",
    "Rock Candy",
    "Schlomo",
    "Scratchensniff",
    "Scut",
    "Slaps",
    "Snakes",
    "Snorki",
    "Soupcan Sam",
    "Spitzitout",
    "Squids",
    "Stinky",
    "Storyboard",
    "Sweet Tea",
    "TeeTee",
    "Wheezy Joe",
    "Winston 'Jazz Hands'",
    "Worms",
]

l_names = [
    "Appleyard",
    "Bloominshine",
    "Boogerbottom",
    "Breedslovetrout",
    "Butterbaugh",
    "Clovenhoof",
    "Clutterbuck",
    "Endicott",
    "Fewhairs",
    "Gooberdapple",
    "Goodensmith",
    "Goodpasture",
    "Guster",
    "Henderson",
    "Hooperbag",
    "Hoosenater",
    "Hootkins",
    "Jefferson",
    "Jenkins",
    "Jingley-Schmidt",
    "Johnson",
    "Kingfish",
    "Listenbee",
    "M'Bembo",
    "McFadden",
    "Moonshine",
    "Nettles",
    "Noseworthy",
    "Olivetti",
    "Outerbridge",
    "Overpeck",
    "Overturf",
    "Oxhandler",
    "Pealike",
    "Pennywhistle",
    "Peterson",
    "Pieplow",
    "Pinkerton",
    "Porkins",
    "Putney",
    "Quakenbush",
    "Rainwater",
    "Rosenthal",
    "Rubbins",
    "Snuggleshine",
    "Splern",
    "Stevens",
    "Stroganoff",
    "Sugar-Gold",
    "Swackhamer",
    "Tippins",
    "Turnipseed",
    "Vinaigrette",
    "Walkingstick",
    "Wallbanger",
    "Weewax",
    "Weiners",
    "Whipkey",
    "Wimplesnatch",
    "Winterkorn",
    "Woolysocks",
]

while True:
    first = random.choice(f_names)
    last = random.choice(l_names)

    print("\n")
    print("{} {}".format(first, last), file=sys.stderr)
    print("\n")

    repeat = input("\nWould you like to generate another name? (Press N/n to exit) ")
    if repeat.lower() == "n":
        break
```

If you know me, and most of you probably do, you noticed that the code uses `.format` instead of an `f` string. It's not *that* big of a deal, but even my most up to date formatter (called a *linter*) gives a warning that the above could be done in an `f` string. I'd probably rewrite it like so;

```python
while True:
	first = random.choice(f_names)
	last = random.choice(l_names)
	
	print(f"\n{first} {last}\n")
	
	repeat = input("\nWould you like to generate another name? (Press N\n to exit) ")
	if repeat.lower() == "n":
		break
```

## Styling

Our objective is complete, and we can all go home...almost. Technically our code works, but it isn't presentable yet. We still have a few more things to go over. First of all, one thing we should know is that there are tools we can use to actually check and see how well written and formatted our code is. We can use ***Pylint***, a program that will run our code by some tests to see if it's compliant on a few different standards. Most importantly, it will provide us with some direct feedback on what we should change, and a score to top it all off. Very useful when finishing up a large project. The syntax is also quite easy,

```bash
pylint your_python_file.py
```

There were two small issues with the code above. One is that it's not properly encased in a `main` function. Because we're building a module, that being some code that runs alongside another larger project, we want to make sure our variables are properly contained and used/called appropriately. We've actually already done this at least once, by putting the main portion of our code inside the following `if` statement;

```python
if __name__ == "__main__":
	# Code goes here
```

This time, we'll actually create a function  called `main`, define it with out function, and call it at the very end. However, that's not all we should do. Something I've explained a few times now is that everything should be explained, your functions included. We should include a doc-string wherever necessary; usually at the start of functions and the module in general. Below is a fully updated version of what our project should look like;

```python
"""Generates a random pseudonym from 2 lists of names"""
import random

def main():
	"""Chooses from 2 tuples and returns them as a string"""
	print("Welcome to my name generator")
	first = ...
	last = ...
	
	while True:
		f_name = random.choice(first)
		l_name = random.choice(last)
		
		print(f"\n{f_name} {l_name}\n")
		
		repeat = input("\nGenerate another name? (Enter to continue, N to quit)\n")
		
		if repeat.lower() == "n":
			break
	
	input("\nPress Enter to exit.")

if __name__ == "__main__":
	main()
```


---
Next: 
[Chapter 2]({{< ref "Impractical Python Projects - Chapter 2" >}}) 
