---
aliases: 
draft: false
tags:
  - computerscience
  - git
  - textbook
title: Learning Git - Chapter 5
date: 2024-09-15
updated: 2024-09-30T21:07
---

-------------------------------------------------------------------------------

# Merging

We last looked at how branches can help a team work on a project together, without losing or any conflicting progress. Now for the logical next step- combining the work together into one branch. We call this **merging**, or the combining of work from different branches.

The *source branch* is the merging branch, or where the work is coming from. The *target branch* is the branch you're merging into. The only branch altered in a merge is the target branch.


> [!Example Book Project]
> Just like before, I'm working with my editor on my new book. Now that we understand merging as a concept, let's shift our workflow around a bit; I want to start a new branch for every chapter. Let's say I've completed three chapters so far and I'm working on `main`. To begin working on chapter four, I would make a new branch called `chapter_four` and work there until I got editor approval. Once it's finished, I can merge the `chapter_four` branch into `main`.


## Types of Merges

The type of merge that happens depends on the state of the target branch and source branch and if their *development history* has diverged. What does this mean? Let's consider our last diagram from the text's chapter four; yellow's development history is the list of previous parent commits.

As it currently stands, the development history of `main` is orange and red, while `feature` has yellow, orange, and red.

If we can get to one branch through the commit history of another branch they have **not** diverged, and we would perform a ***fast-forward merge***.

**Example of a Fast-Forward Merge:**


{{< image src="/images/fast_forward_merge.png" alt="fast_forward_merge" position="center" style="border-radius: 8px;" >}} 


On the other side of the spectrum, if your development histories **have diverged**, we'd have to perform a ***three-way merge***.

**Example of a Three-Way Merge:**

{{< image src="/images/three_way_merge_example.png" alt="three_way_merge_example" position="center" style="border-radius: 8px;" >}} 


Three-way merges are unfortunately complicated. During the merge, we might encounter what we call a *merge conflict*, which can happen if both merges edits in the same parts/lines of a file, or if one branch deleted a file while another didn't. We can explore this in more detail in the later chapters (9 and 10 apparently) so let's just focus on getting our Rainbow project going.

## Doing a Fast-Forward Merge

Let's make sure we're in our `rainbow` directory, so we can merge our `feature` branch into our `main` branch. We know from our diagram in the last chapter, that our `yellow` commit is where `HEAD` is pointing and we're in a new branch, `feature`. 

Now to commit a merge, it happens in two steps:

1. Switch onto the target branch
2. Use `git merge <branch_name>` with the name of the source branch as the `branch_name`.

There are two lessons that we should try to identify while doing this merge; Git will help you prevent loss of work in any non-committed files, and when you change a branch the working directories contents may change.

In regards to the first point, let's look at our book example to see how Git protects you;

> [!Example Book Project]
> Let's say we're about to start `chapter_nine.txt`. This time, I'm going to make two branches, `chapter_nine_a` and `chapter_nine_b`. If I switch to `chapter_nine_a` and make some commits, then switch the `chapter_nine_b`, make edits **without** any commits, Git will stop me from switching to any other branches before making my next commit.

We can try this out with our `rainbow` repository. While on the `feature` branch, we can add "Green is the fourth color of the rainbow." to `rainbowcolors.txt`. Now if you try to use `git switch main`, Git will give you an error saying there are uncommitted changes and abort the attempt.

To keep moving, go back to your `rainbowcolors.txt` file and undo the green sentence and save the file. If we switch our branch back to main, notice that we have a totally different working directory; our third color sentence does *not* appear in our `rainbowcolors.txt`. 

We can use `git log --all` to see a list of commits in reverse chronological order for all branches within your local repository. We should be pointing `HEAD` at `main` now. Let's finally make this merge happen;

```bash
>>> git merge feature
>>> git log
commit 43a7cffeceeaa1be4b55e94f4769ff5dc154cde4 (HEAD -> main, feature)
Author: mr-pointing <rpointing@blmhs.org>
Date:   Sat Sep 14 16:57:14 2024 -0400

    yellow

commit ae65b50098378ac6bf0cbe9ab92a9884b98db61b
Author: mr-pointing <rpointing@blmhs.org>
Date:   Fri Sep 13 15:59:13 2024 -0400

    orange

commit f54fa770db92bbe31125032abb853f7dd6af414b
Author: mr-pointing <rpointing@blmhs.org>
Date:   Thu Sep 12 15:59:22 2024 -0400

    red
```