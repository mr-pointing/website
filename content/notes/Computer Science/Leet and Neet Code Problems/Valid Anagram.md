---
aliases: 
draft: false
tags:
  - computerscience
  - dictionaries
  - python
title: Valid Anagram
date: 2024-09-18
updated: 2024-09-21T12:25
---

-------------------------------------------------------------------------------

***Question:*** Given two strings `s` and `t`, return `true` if the two strings are anagrams of each other, otherwise return `false`.

An **anagram** is a string that contains the exact same characters as another string, but the order of the characters can be different.

***How to Solve:*** We essentially need to compare two strings and see if the amount of characters are the same for each word. There are probably a few ways to do that, but I went for the extremely direct approach.

We can create two dictionaries, one for each word. Then take in each letter into the dictionary: if the letter exists, add one to the count/value. If it doesn't exist, add it to the dictionary. Compare both dictionaries to evaluate true or false.


***Answer:***


```python
    def isAnagram(s: str, t: str) -> bool:
        char_list = {}
        for letter in s:
            if letter not in char_list:
                char_list[letter] = 1
            else:
                char_list[letter] += 1
        char_list2 = {}
        for letter in t:
            if letter not in char_list2:
                char_list2[letter] = 1
            else:
                char_list2[letter] += 1
        return char_list == char_list2
```