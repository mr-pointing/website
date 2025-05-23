---
aliases: 
draft: false
tags:
  - computerscience
  - algorithms
  - textbook
title: Grokking Algorithms - Chapter 2
date: 2025-02-03
updated: 2025-02-05T12:30
---

-------------------------------------------------------------------------------


# Selection Sort

Before going into choosing an array vs. a linked list, let's do a quick lesson on memory.

Think of your computers memory like a dresser full of small drawers. When you want to store a value, in a variable, that variable name is given an address, and whatever value is stored inside of it. Incredibly simple for single value variables- but what about multiple items? This is where picking an array or a linked list comes in.

To comprehend the difference between the two, let's use the example of a movie theater: you and two friends go to the movies and need 3 seats. If your fourth friend were to come in the middle of the movie and ask for a seat, we have two options;

1. Gather up all of our friends and move to a new location with enough seats for all four of us (*arrays*)
2. Have your friend sit anywhere they'd like, just take note of where they are sitting for later (*linked lists*)

Arrays inherently take up a specified amount of space, and to add more room, you would have to move your current location to a brand new one that can allocate enough space as you need. It is possible to assign more space than needed to account for this, but for extremely large sizes this can lead to unused memory space (and if you *still* need more after, you'll have to move anyways).

### Linked Lists

Linked lists are great because they allow you to store data in memory **anywhere you'd like**. You don't actually get to chose the memory locations, but your values don't necessarily need to be next to one another. This is achievable via *pointers*, or spaces of memory with information (an address) on where the next value is stored. 

### Arrays

Arrays are great if you need *random access*, or the ability to get information from any place in the array without having to visit every location in the array. You actually store arrays in larger portions of memory allocated specifically for that array, so you can access any part of it. Due to Linked Lists being anywhere in memory, you would have to go through every single one to find the last value and it's location.


|           | Arrays | Lists  |
| --------- | ------ | ------ |
| Reading   | $O(1)$ | $O(n)$ |
| Inserting | $O(n)$ | $O(1)$ |
Reading is faster for arrays, and inserting is faster for linked lists. This is important to remember for later.

### Exercises

1. Suppose you're keeping track of finances. Every day, you write down everything you spent money on. At the end of the month, you review and take a sum on how much you spent. Lots of inserts, and little reads. Array or Linked List would be better for this?
	- Linked list!


## Pros and Cons for Both

Depending on what you need to do, will dictate which structure you should use. For example; inserting into the middle of a list. Which would be better?

Lists make it easy to change what each item is pointing at, where in an array you would have to shift everything down (or in the worst case, move locations). In this case, linked lists win.

There is also the issue of deletions. Lists also have arrays beat here; all you have to do is change the pointer to a new location, rather than move locations. Small note, deletions will always work, where insertions might fail if there is no space.

So which of the two is used *more*? Even though we've pointed out all the advantages linked lists have over arrays, we do know that arrays are better at reads and have that random access attribute. Linked lists only have *sequential access*, which is the formal term for reading one entry at a time. 

Due to this, arrays are generally faster since they read in entire sections at a time, which does actually increase the read speeds. You can't do this with linked lists, since they are scattered around memory. Another issue which might have to visualized to understand more, is that for small lists, linked lists actually take up *more* space, since they also have to account for the pointers to each value.

{{< image src="/images/arrays_vs_lls.png" alt="arrays_vs_lls" position="center" style="border-radius: 8px;" >}} 

### Exercises

2. You're building an ordering app for a restaurant. Your app keeps track of orders. Servers keep adding orders to the list, and chefs take orders off the list & make them. Servers add orders to the back, chefs pull from the front. Should you use linked lists or an array?
	- Linked lists, because you're always inserting/deleting from the same spot, with no need for random access/inserts
3. How should Facebook store usernames if they use Binary search to find usernames, linked lists or arrays?
	- Arrays, since Binary search needs random access
4. What are the downsides of using an array to store the list of users, specifically for inserts?
	- If there is not much space on the machine storing users, it will have to eventually move, which it might not have space for
5. If Facebook use an array of linked lists for users, is it slower or faster than each for searches? 
	- I think faster for both, since the initial array means fast random access, and fast inserts for the linked lists

## Selection Sort Algorithm

For the next algorithm we are going to learn, *selection sort*, we can imagine we are going to sort a list of artists & sorting them by the minutes played to find your most played artist from greatest to least.

Since you're choosing one at a time to insert into a new list, you'll have to compare each minutes played against each iteration. To touch each one, it will take $n$ steps. We are going to have to do this $n$ times, until there are no more left in the original list. This gives us a running time of $n*n$, or $O(n^2)$.

```python
def find_smallest(arr):  
	smallest, s_index = arr[0], 0  
	for i in range(0, len(arr)):  
	    if smallest > arr[i]:  
	        smallest = arr[i]  
	        s_index = i  
	return s_index

# My initial idea
def selection_sort(arr):  
    new = []  
    copy = list(arr)  
    while len(copy) >= 1:  
        smallest = find_smallest(copy)  
        new.append(copy[smallest])  
        copy.pop(smallest)  
    return new

# Book answer
def book_selection_sort(arr):  
    new = []  
    copy = list(arr)  
    for i in range(len(copy)):  
        smallest = find_smallest(copy)  
        new.append(copy.pop(smallest))  
    return new
```



---
Next: 
[Chapter 3]({{< ref "Grokking Algorithms - Chapter 3" >}}) 
