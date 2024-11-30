---
aliases: 
draft: false
tags:
  - computerscience
  - git
  - textbook
title: Learning Git - Chapter 9
date: 2024-11-23
updated: 2024-11-28T13:39
---

-------------------------------------------------------------------------------

# Three Way Merges

Every merge we've done so far has been a fast-forward merge. In this chapter, we're going to take a look at performing our first three way merge, and also get some hands on experience with how editing our files out of order will affect our work flow. First, let's simplify our visualization and update it to reflect where we left off in the last chapter;

{{< image src="/images/three_way_simple.png" alt="three_way_simple" position="center" style="border-radius: 8px;" >}}


Again, three way merges are important and necessary to understand. To reiterate [Chapter 5]({{< ref "Learning Git - Chapter 5" >}}), three way merges are for branches whose paths have diverged at some point. There's a great example there about exactly how a three-way merge would work with a good example; be sure to review.

One thing that the book goes over in their example that the original example doesn't have is that three way merges actually create their own commits that have more than one parent commit. Some people don't like the way this will fill up the commit history, which leads to rebasing (a concept we'll learn about in chapter 11).

## Setting Up Our Three Way Merge 

Let's make another text file in our directory, and commit it;

```bash
>>> nano othercolors.txt  # Add 'Brown is not a color of the rainbow.'
>>> git add othercolors.txt
>>> git commit -m "brown"
[main d0ab541] brown
 1 file changed, 1 insertion(+)
 create mode 100644 othercolors.txt
>>> git log
commit d0ab54146cdd169ec9f121fa51b88bae47864235 (HEAD -> main)
Author: mr-pointing <rpointing@blmhs.org>
Date:   Sat Nov 23 16:48:29 2024 -0500

    brown

commit dbae3cde2f90035d9bfcc5c9d970aba10237c2ed (origin/main)
Author: mr-pointing <rpointing@blmhs.org>
Date:   Thu Nov 21 12:44:27 2024 -0500

    green
```