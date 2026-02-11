---
aliases:
draft: false
tags:
  - computerscience
  - python
title: Impractical Python Projects - Chapter 2
date: 2026-02-06
updated: 2026-02-11T12:07
---

-------------------------------------------------------------------------------


# Project #2: Finding Palingram Spells

This project is going to be pretty difficult unless we elaborate on some vocab words. First off, a *palindrome* is any word that can be spelled the same both forwards and backwards; think of radar, kayak, or madam. The next step up would be if we had an entire sentence that can be spelled the same forwards or backwards, which is called a *palingram*. The motivation for this project is based off a super hero called Zatanna, who got cursed to only speak and cast spells in palingrams. In order for her to fight as a super-hero, she would need a plethora of palingrams to choose from, like *stack cats*, or *puff up*. 

What we're going to do in this project is build a program that will take in a dictionary from the internet and use it to discover palingrams. Then we'll use a new tool set to analyze the performance of our code, followed by how to pick up good "aggressive" phrases that will work well as spells for Zatanna.

## Getting a Dictionary

When I say dictionary, you probably imagine a book with not only words in it, but things like pronunciations, definitions, and all sorts of things of that nature. However, for the purposes of this project, we're only going to use a file with the actual words in it, nothing else. All of that other stuff will only get in our way, since we're trying to just find palingrams. We're going to follow along with the exact steps the author of this text took, [here](http://wordlist.aspell.net/12dicts/). For an extra challenge, try using one of the other files provided in table 2-1 of the text!

### Handling Exceptions

Something we've looked at this year without going into too much detail about is handling exceptions. *Exceptions* are errors that happen during program execution, like if your program tries to open a file that doesn't exist or have permission to open. To avoid most issues, it's best practice to use a `try & except` clause whenever opening a file. If you want more detail on how exactly this works, check out [The Python Tutorial Notes - Chapter 7]({{< ref "The Python Tutorial Notes - Chapter 7" >}}) & [The Python Tutorial Notes - Chapter 8]({{< ref "The Python Tutorial Notes - Chapter 8" >}}).

The syntax is as follows; 

```python
try:
	with open(file) as in_file:
		# Do something
except IOError as e:
	print(f"{e}\nError opening {file}. Terminating program.")
	sys.exit(1)
```

One thing I want to point out quickly is that in this specific example, we only hit the exception clause given our error is an Input/Output error, which is why we say `IOError`. If any other error occurs, it won't be caught.

```python
"""Load a text file as a list.

Arguments:
- Text file name (and directory path, if needed)

Exceptions:
- IOError if filename not found
  
Returns:
- A list of all words in a text file in lower case.

Requires:
- sys

"""
import sys

def load(file):
	"""Open a text file & return a list of lower case strings"""
	try:
		with open(file) as in_file:
			loaded_txt = in_file.read().strip().split('\n')
			loaded_txt = [x.lower() for x in loaded_txt]
			return loaded_txt
	except IOError as e:
		print(f"{e}\nError opening {file}. Terminating program.")
		sys.exit(1) 
```

Based on our experience, we know like 90% of this code. I just want to explain the first call with `loaded_txt`; `.read()` will read in from the file, `.strip()` tells the read-in data to delete any leading or trailing whitespace, and `.split()` actually makes the `string` being returned into a `list`, making splits using the newline-character.  

## Finding Palindromes

Now that we have our words, we should perform the easier operation and try to find palindromes before we move onto palingrams. This will be our next objective.

The strategy is relatively simple in discussion: check every word to see if it's the same both forwards and reversed. How can we do this? Slicing of course! I've taught you the basics of slicing, now we should use it in a more complex setting. A really easy way to get the reversed version of any word is by slicing like this;

```python
word = "Loughlin"
print(word[:])
# Loughlin
print(word[::-1])
# nilhguoL
```

Our pseudocode here is also pretty basic:

1. Load in the dictionary file
2. Initialize a list to hold all palindromes
3. Loop through the dictionary file
4. Check each loop iterations word against a reversed version of itself
	1. If they are the same, add that word to the palindrome list
	2. If they are not, continue the loop
5. Print the list of palindromes

I feel like we could write this code on our own, so try to give it a shot without looking at the solution below...how'd it go? Does it work? If no, try again! If you tried again and still missed the mark, don't stress, let's take a look at the texts' solution;

```python
"""Generates a list of palindromes based off a dictionary file"""

import load_dictionary
word_list = load_dictionary.load('2of4brif.txt')
pali_list = []

for word in word_list:
	if len(word) > 1 and word == word[::-1]:
		pali_list.append(word)

print(f"\nNumber of plaindromes found: {len(pali_list)}")
print(*pali_list, sep='\n') 
```

## Finding Palingrams

To keep this from getting a little too complex, we'll just look for two word palingrams. This gives us a nice relationship between our words; one word will be our *core* word, or the word that set's up for the other word to complete the palindromic-sequence. 

Now, to fully understand how to capture and compare against this core word is a lot of logic, so make sure you're strapped in. We can make some inferences about our core word that will help us better understand how to actually perform our search;

1. It can have odd or even number of letters
2. One slice of our word (called the contiguous part) spells another word when read backwards
	- *Think of how NURSES has NUR to begin, or RUN backwards!*
3. The slice can take up a portion or all of the core word
4. The OTHER part of your core word that is not made up of the contiguous part is also a palindromic sequence
	- *Think of how in NURSES, since NUR spells run, SES is also a palindromic sequence!*
5. The palindromic sequence *can* take up a portion or all of the core word
6. The palindromic sequence does **not** have to be a real word
7. The two parts (contiguous and palindromic) cannot overlap or share letters 
8. The sequence is reversible

If you're confused, that's okay, it takes some deep thinking to wrap your whole head around. To add onto the confusion, let's throw in another condition; *if the reversed word takes up the whole core word and is NOT a palindrome, it's a **semordnilap**, not a palindrome.* A semordnilap is a palindrome that spells a **different** word than when spelled backwards; think of **bats** and **stab**, or **flow** and **wolf**. 

So what we're going to attempt to do is check a word for these sequences. We check each word one letter at a time, both from the end and beginning of the word. If you think about it, if we have a single word with a semordnilap in it, we just need to add the reversed word to the core word to create a palindrome. In **STACK***, we see that cats is a reversed word in it, and since the *k* is technically a palindromic-sequence since it's a single word, we can add both stack *and* cats as a combo to our list of palindromes. Again, totally fine to be slightly confused. I think it will start to make more sense after we think about our pseudocode and finally our code;

1. Load our digital dictionary
2. Start an empty list to hold our palingrams
3. Loop through the list of words
	1. retrieve the length of the word
	2. Use a new variable to hold word reversed
	3. Check to make sure the length is greater than 1
		1. Begin to loop through the letters of each word
			1. If the reversed word portion at the front of the core word is in the original word list and the letters after it form a palindromic sequence:
				1. Append the word and reversed word to palingram list
			2. If the reversed word portion at the end of the core word is in the original word list and the letters before it form a palindromic sequence:
				1. Append the reversed word and word to palingram list
4. Sort palingram list in alphabetical order
5. Print all word-pair palingrams from list

If you are still confused (I know I am) follow along with the code below and try to trace a word or two through it;

```python
"""Find all word-pair palingrams in a dictionary file"""
import load_dictionary

word_list = load_dictionary.load('2of4brif.txt')

def find_palingrams():
	"""Find the dictionary palingrams"""
	pali_list = []
	for word in word_list:
		end = len(word)
		rev_word = word[::-1]
		if end > 1:
			for i in range(end):
				if word[i:] == rev_word[:end-i] and rev_word[end-i:] in word_list:
					pali_list.append((word, rev_word[end-i:]))
				if word[:i] == rev_word[end-i:] and rev_word[:end-i] in word_list:
					pali_list.append((rev_word[:end-i], word))
	return pali_list
	
palingrams = find_palingrams()

# Sort palingrams
palingrams_sorted = sorted(palingrams)

# Display list of palingrams
print(f"\nNumber of palingrams = {len(palingrams_sorted)}")
for first, second in palingrams_sorted:
	print(f"{first} {second}")

```

## Profiling

Before we decide whether or not the code is successful, we should run some diagnostic testing to see if there are areas in which we can improve. For one, depending on your machine, the process we just wrote can take a good amount of time. On the author's machine, it took about 3 minutes. On my machine, it was probably over a minute. We don't have to settle for approximations; we can run a test ourselves that will not only tell us exactly how long it takes, but also in which areas we are spending the most time so we can see and improve our code.

We're going to use a library called `cProfile`, which is built in the C language to run profiles on code. Create a new python file called `cprofile_test.py` and insert the following code;

```python
import cProfile
import find_palingrams
cProfile.run('find_palingrams.find_palingrams()')
```

Run it and you should get something similar to what I have below;

```bash
  62622 function calls in 49.976 seconds

   Ordered by: standard name

   ncalls  tottime  percall  cumtime  percall filename:lineno(function)
        1    0.000    0.000   49.976   49.976 <string>:1(<module>)
        1   49.969   49.969   49.976   49.976 find_palingrams.py:8(find_palingrams)
        1    0.000    0.000   49.976   49.976 {built-in method builtins.exec}
    60388    0.005    0.000    0.005    0.000 {built-in method builtins.len}
     2230    0.001    0.000    0.001    0.000 {method 'append' of 'list' objects}
        1    0.000    0.000    0.000    0.000 {method 'disable' of '_lsprof.Profiler' objects}
```

So I was a little off, my code ran in just under a minute. Pretty good! But we can definitely do better. We see it ran for 49 seconds, and found 2,230 palingrams (we know that's what it is because it says we used the `append` that many times!). Another way we could find time it took is with `time.time()`, which should be called before and after we use the function we want to time, like so;

```python
start_time = time.time()
palingrams = find_palingrams()
end_time = time.time()
```

So we know from the above that moving through out list is the likely cause of our function taking so long. We want to alleviate that, and one way we can is using a different structure to hold our words in a set instead of a list. We know that sets have a faster lookup time, which is all we're going to do with our list of words. It's actually a really easy fix as far as our code goes, here is ***just the find_palingram function fixed***:

```python
def find_palingrams():
	"""Find dictionary palingrams."""
	pali_list = []
	words = set(word_list)
	for word in words:
		end = len(word)
		rev_word = word[::-1]
		if end > 1:
			for i in range(end):
				if word[i:] == rev_word[:end-i] and rev_word[end-i:] in words:
					pali_list.append((word, rev_word[end-i:]))
				if word[:i] == rev_word[end-i:] and rev_word[:end-i] in words:
					pali_list.append((rev_word[:end-i], word))
	return pali_list
```

Now try running it and see how much faster it gets...for me, I was able to get it to work in **0.07** seconds! Crazy fast.


---
Next: 
[Chapter 3]({{< ref "Impractical Python Projects - Chapter 3" >}}) 
