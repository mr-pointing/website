---
aliases: 
draft: false
tags:
  - computerscience
  - textbook
  - algorithms
title: Grokking Algorithms - Chapter 11
date: 2025-03-05
updated: 2025-03-08T12:00
---

-------------------------------------------------------------------------------

# Dynamic Programming

The knapsack problem is coming back; this time with a vengeance. This time around, we have the same items, but we have a ***four*** pound limit in our bag. The Switch is $1500 and 1 pound, the P.C. is $3000 and 4 pounds, and the laptop is $2000 and 3 pounds. 

If we went with the most simple solution, we could just add up all possible combinations and pick the best. For 3 items, it's no big deal. There are only 8 sets of possible combinations; easy to walk through. However, increasing from there is *incredibly* slow ($2^n$), so past 10 items it begins to become massive amounts of processing power to produce an answer.

In this situation, we are concerned with the most optimal solution, which using a greedy algorithm for wouldn't provide. For that, we'll have to use *Dynamic Programming*. 

Dynamic Programming works by solving subproblems, building up to solve the larger problem at hand. It works similarly to Divide & Conquer. 

1. Create a grid with columns for the varying weights (*our constraint*) and rows with the items
2. Go row by row and fill in the grid with the best value currently available

To start, it'll look like this:

|        | 1   | 2   | 3   | 4   |
| ------ | --- | --- | --- | --- |
| Switch |     |     |     |     |
| P.C.   |     |     |     |     |
| Laptop |     |     |     |     |

Our first row is the easiest; we only have a single item, the Switch, which fits in our bag at only 1 pound. For all pounds with no other options, taking the Switch has the best value. We should update our table to reflect that;


|        | 1        | 2        | 3        | 4        |
| ------ | -------- | -------- | -------- | -------- |
| Switch | 1500 (s) | 1500 (s) | 1500 (s) | 1500 (s) |
| P.C.   |          |          |          |          |
| Laptop |          |          |          |          |
The letter dictates what items we currently are holding, creating that value. We have the same 1500 provided by the Switch, hence the entire row being "1500 (s)".

Next is obviously the second row. However, the P.C. takes 4 pounds, so the best value for pounds 1 through 3 stays the same. When we get to 4, our new best value is taking just the P.C., with a value of 3000.

|        | 1        | 2        | 3        | 4            |
| ------ | -------- | -------- | -------- | ------------ |
| Switch | 1500 (s) | 1500 (s) | 1500 (s) | ~~1500 (s)~~ |
| P.C.   | 1500 (s) | 1500 (s) | 1500 (s) | 3000 (p)     |
| Laptop |          |          |          |              |
Now for our final row, again, the laptop weighs 3 pounds, so for the first two cells there is no change. But for the third cell, the laptop will fill the whole 3 pounds for a better deal, so that's what gets replaced. And for the final, we can fit both the Laptop & Switch, which is a better deal than the most updated value.

|        | 1        | 2        | 3            | 4            |
| ------ | -------- | -------- | ------------ | ------------ |
| Switch | 1500 (s) | 1500 (s) | 1500 (s)     | ~~1500 (s)~~ |
| P.C.   | 1500 (s) | 1500 (s) | ~~1500 (s)~~ | ~~3000 (p)~~ |
| Laptop | 1500 (s) | 1500 (s) | 2000 (l)     | 3500(s, l)   |
Our last value is now our best value, so we should take the Laptop & Switch for $3500. Each cell is compared with the following pseudocode;

```python
cell[i][j] = max(the previous max(cell[i-1][j]), Current value + cell[i-1][j-item weight])
```

### Exercises

1. Another item appears; a new keyboard for $1000, and weighs 1 pound. Should we steal it?

No! It is not a better value than taking the best 1 pound item, the Switch.

## Small Details

Some important details to remember about Dynamic Programming;

- Changing the order of the rows doesn't matter
- Adding a smaller item is possible; add more columns
- You can't steal fraction of an item
- You can't handle items that depend on one another
- It is possible that the best solution doesn't satisfy the constraint (Think a 3.5 pound, $1000000 diamond, clearly you should steal that if it fits and leaves 0.5 space remaining)

## Longest Common Substring

Another problem with Dynamic Programming is especially helpful with. Generally, we consider it to be the most useful when trying *to optimize something given a constraint*. One common problem and application of Dynamic Programming as spellcheck.

Let's say we are trying to Google the word "fish" for some reason. I messed up and typed "hish" instead. How does my spell checker know that I was trying to spell "fish", and not something like "crash"?

Spell checkers use Dynamic Programming to set up a grid of all the values the words have in common. If we were to try and solve this using the method we used just before, how could we set this up? What would be our grid, and what would be our constraint?

Well, we can start the grid as comparing both words, since in this instance what we want and typed are the same type (words). Our grid can look something like this;

|     | H   | I   | S   | H   |
| --- | --- | --- | --- | --- |
| F   |     |     |     |     |
| I   |     |     |     |     |
| S   |     |     |     |     |
| H   |     |     |     |     |
Then, for every cell where we have a match in characters, we count not only that they are alike, but keep track of the *amount of consistent alike characters*. Our table is then populated;

|     | H   | I   | S   | H   |
| --- | --- | --- | --- | --- |
| F   | 0   | 0   | 0   | 0   |
| I   | 0   | 1   | 0   | 0   |
| S   | 0   | 0   | 2   | 0   |
| H   | 0   | 0   | 0   | 3   |
Compare this to another word like crash;

|     | H   | I   | S   | H   |
| --- | --- | --- | --- | --- |
| C   | 0   | 0   | 0   | 0   |
| R   | 0   | 0   | 0   | 0   |
| A   | 0   | 0   | 0   | 0   |
| S   | 0   | 0   | 1   | 0   |
| H   | 0   | 0   | 0   | 2   |
Clearly, "hish" is more like "fish" than "crash", so we should suggest "fish" instead of "hish." The formula to achieve this is fairly simple;

```python
if word_a[i] == word_b[j]:
	cell[i][j] = cell[i-1][j-1]
else:
	cell[i][j] = 0
```


---
Next: 
[Chapter 12]({{< ref "Grokking Algorithms - Chapter 12" >}})


