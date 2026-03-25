---
aliases:
draft: false
tags:
  - computerscience
  - python
  - textbook
title: Impractical Python Projects - Chapter 3
date: 2026-02-11
updated: 2026-03-24T11:59
created: 2026-03-24T09:02
---

-------------------------------------------------------------------------------

# Project #3: Solving Anagrams

Another string-based project, this time centered around anagrams. An *anagram* is a word that can be spelled using the letters of another word. For example, **Elvis** creates *lives*, *evils*, and *veils*. We'll complete three projects; finding anagrams from a single word, finding phrase anagrams from your name, and finally end with a Harry Potter Voldemort game.

## Finding Single-Word Anagrams

Just like the last few chapters, the first portion or first project is always the easiest. This one isn't so bad; most of you could write this one without much help if you remember the process from the last chapter. One key part of finding anagrams is that they'll always have the same amount of letters, otherwise it wouldn't be much of anagram. Python doesn't have any built-in operators that will do this for us, so we'll have to write one. We're also going to use the dictionary we used from last chapter, and load it as strings.

So we know that we need to make sure they have the same amount of characters, but we can't see how many of those characters are the same, unless we found out all of the characters in one string, counted them, checked to make sure the second string has the same characters, and finally the same count of characters. That's a lot, but an easy way to start thinking about this programmatically is to convert each string into a list. Then, we can end up using list methods that will give us an easier time.

Here's a quick example;

```python
>>> word = list('stop')
>>> word
['s', 't', 'o', 'p']
>>> anagram = list('pots')
>>> anagram
['p', 'o', 't', 's']
```

We turned two strings into two lists- piece of cake. However, if we compare them we don't actually get our desired result;

```python
>>> word == anagram
False
```

Instead of having to turn them to lists then find a way to compare them, we can actually kill two birds with one stone; if we use the `sorted()` built-in function, it will take any string and make it a list of the characters in sorted order. Now, if we compare both variables, even if they were just regular old strings, they would work just fine;

```python
>>> word = list('stop')
>>> anagram = "pots"
>>> sorted(word) == sorted(anagram)
True
```

So here is the logic for our next code project;

1. Load the dictionary file into a list(we'll user the same as last project)
2. Create a list for anagrams
3. Ask the user for a word
4. Loop through the word list, comparing each word to the `sorted()` version of the users word
	1. If the words are the same, add them to the anagram list
5. After the loop is done, print out how many anagrams you have, followed by a list of them

```python
"""
Finds all anagrams in a dictionary given a word from the user
"""

import load_dictionary

word_list = load_dictionary.load("2of4brif.txt")

user_word = input("Enter a word you want to find anagrams of: ").lower()
user_sort = sorted(user_word)
ana_list = []

for word in word_list:
    # if len(word) == len(user_sort):
    if sorted(word) == user_sort and user_sort != word:
        ana_list.append(word)

print(f"{len(ana_list)} anagrams were found for {user_word}", *ana_list, sep="\n")
```

## Finding Phrase Anagrams

Now that we know how to find single word anagrams, let's try and see how many words we can get from a name or word. Each word we find will be a subset of our original word, or will only contain a certain amount of the letters from the original. We'll allow a user to build an anagram phrase based off of the letters in their name.

Using a name, getting anagrams works best if we get some that make sense in context; like how we can take Clint Eastwood and rearrange it to get *old west action*, or take George Bush and get *he bugs Gore*. Obviously, letting the computer do that job for us seems incredibly challenging, unless you already know how to teach a computer to understand human context (in which case, why are you reading this?). Instead of having to teach our program and run into the realm of machine learning, we can allow our program to have our user pick words as the phrase gets built. As the user picks a word, the letters used will have to get *cancelled*, since we use them only once. The remaining letters will try to get another word going, and again prompt the user to pick the word next chosen.

The above point makes clear that not only should we have the same letters in our word, but the same *count* of letters as well. Python actually has a module that has a type of container that helps us out in this case;  the `collections` module has a `Counter` datatype, that works like a dictionary with the entry as the key and the count of how many times that entry occurs in a list as the value. Here's a quick example;

```python
from collections import Counter
jojos = ['Johnathan', 'Joseph', 'Jotaro', 'Josuke', 'Giorno', 'Jolyne', 'Johnny', 'Josuke', 'Jodio']
count = Counter(jojos)
print(count)
> Counter({'Johnathan': 1, 'Joseph': 1, 'Jotaro': 1, 'Josuke': 2, 'Giorno': 1, 'Jolyne': 1, 'Johnny': 1, 'Jodio': 1})
```

We can also use this container to replace the use of the `sorted()` function. It will work the same way; we can compare two `Counter` containers and if they're the same, we can say they're anagrams. Here's the pseudocode;

1. Load a dictionary file and create word list
2. Accept a name from the user
3. Set a limit equal to the length of the name
4. Make a string for anagram phrase
5. While the length of the phrase (anagram phrase) is less than the limit we set in step 3;
	1. Generate your word list that fit the name given
	2. Show words to the user
	3. Show remaining letters to user
	4. Show the current phrase to the user
	5. Ask the user to input word or start over
	6. If the user input can be made from remaining letters:
		1. Accept choice of new word or words from user
		2. Remove letters in choice from letters in name
		3. Return choice and remaining letters in name
	7. If choice is not a valid selection:
		1. Ask user for a new choice or let users start over
	8. Add choice to phrase and show to user
	9. Generate new list of words and repeat
6. When phrase length equals limit value:
	1. Display final phrase
	2. Ask user to start over or to exit.

### Dividing Up the Work

As we know from our numerous other projects, we want to divide our work to make it less complicated to read and debug. We'll have a **main** file that will collect the user input and handle the while loop, the `find_anagrams()` function to literally find our anagrams, and `process_choice()` to prompt the user to enter in a choice or start over. Here's a quick diagram that will help us think about how the flow of our program should work;

{{< image src="/images/phrase_anagram_workflow.jpeg" alt="phrase_anagram_workflow" position="center" style="border-radius: 8px;" >}} 

The text is very generous by giving us all of the code, but I encourage you to attempt to build this without looking below first. It will certainly be challenging, but if you give it and good try and see their solution after attempting your own, you might end up understanding their answer all on your own. 

```python
# phrase_anagrams.py
import load_dictionary
from collections import Counter

dictionary = load_dictionary.load('2of4brif.txt')
dictionary.append('a')
dictionary.append('i')
dictionary = sorted(dictionary)

user_name = input("Enter a name: ")


def find_anagrams(name, word_list):
    """Read name & dictionary file & display all anagrams in name"""
    nlm = Counter(name)
    anagrams = []
    for word in word_list:
        test = ''
        wlm = Counter(word.lower())
        for letter in word:
            if wlm[letter] <= nlm[letter]:
                test += letter
        if Counter(test) == wlm:
            anagrams.append(word)
    print(*anagrams, sep="\n")
    print()
    print(f"Remaining letters = {name}")
    print(f"Number of remaining letters = {len(name)}")
    print(f"Number of remaining real word anagrams = {len(anagrams)}")
```

Since this one is really similar to our single anagram finder, most of this code should be familiar. What's important to understand here is that nothing is being returned from the `find_anagrams()` function. Now let's make the `process_choice()` function. The text hints at using multiple files, but we can just use one file to make it easier. 

```python
def process_choice(name):
	"""Checks user choice for validity, then returns choice and leftover letters"""
	while True:
		choice = input("Make a choice else Enter to start over or # to end: ")
		if choice == "":
			main()
		elif choice == "#":
			sys.exit()
		else:
			candidate = ''.join(choice.lower().split())
		left_over_list = list(name)
		for letter in candidate:
			if letter in left_over_list:
				left_over_list.remove(letter)
		if len(name) - len(left_over_list) == len(candidate):
			break
		else:
			print("Won't work! Make another choice!")
	name = ''.join(left_over_list)
	return choice, name
```

Let's explain this one since it's doing a lot of heavy lifting in our project. It takes in a `name` variable, which is the same as our `user_name` variable in the previous function. The while loop starts with true as the default value, collecting the users input no matter what. We give our user three options: hit enter to start over, use # to quit the program, and type in a selection to move forward. Whatever the user picks is assigned to `candidate`, which is stripped of any whitespace (that's what the `join` statement is doing on the variables initialization). This makes it much easier to compare to the user's name. Then, a list is made up of the users name, and the characters used in the selection are removed. 

Now to move onto the `main` function. This will wrap the two previous functions, encase them in a while loop, and will actually start the process;

```python
def main():
	"""Build anagram phrase from user's name"""
	name = ''.join(user_name.lower().split())
	name = name.replace('-', '')
	limit = len(name)
	phrase = ''
	running = True
	
	while running:
		temp_phrase = phrase.replace(' ', '')
		if len(temp_phrase) < limit:
			print(f"Length of anagram phrase = {len(temp_phrase)}")
			
			find_anagrams(name, dictionary)
			print("Current anagram phrase =", end=" ")
			print(phrase)
			
			choice, name = process_choice(name)
			phrase += choice + ' '
			
		elif len(temp_phrase) == limit:
			print("\n***FINISHED!***\n")
			print("Anagram of name = ", end=" ")
			print(phrase)
			print()
			try_again = input('\n\nTry Again? (Press Enter else "n" to quit)\n')
			if try_again.lower() =='n':
				running = False
				sys.exit()
			else:
				main()

if __name__ == '__main__':
	main()
```
