---
aliases: 
draft: false
tags:
  - computerscience
  - git
  - textbook
title: Learning Git - Chapter 10
date: 2025-01-06
updated: 2025-01-08T11:24
---

-------------------------------------------------------------------------------

# Merge Conflicts

In our last chapter, we were able to pull off our first three way merge without any issues. This time, we're about to experience some merge conflicts, and what to do when we encounter them. You can view the end of [Chapter 9]({{< ref "Learning Git - Chapter 9" >}}) to see the visualization of where we're at; we've got the `M1` commit as the latest in all three repos.

One important distinction we need to make about this experiment we're going to do versus the last chapter is the type of changes we're going to make. In the last chapter, we had changes between *different* files. Our `friend-rainbow` edited the `othercolors.txt` file, while our `rainbow` repo only edited the `rainbowcolors.txt` file. This time around, we're going to make changes to the same file.

> [! Example Book Project]
> We're back to our book example. This time, we still have an editor that's helping us out, and they're creating an `editor` branch for each chapter. Let's say we're working on `chapter_ten.txt`; I made a branch off of `main` called `chapter_ten`, and my editor makes a `chapter_ten_editor` branch.
> 
> Due to a miscommunication, my editor pushes their changes made in their branch to `main` before I push mine. When I attempt to merge my `chapter_ten` branch into `main`, I will have to do two things; perform a three way merge *and* resolve merge conflicts; deciding what the final product should look like.
> 
> Another merge conflict could arise like this: say in a major error, my editor doesn't realize I have *deleted* the `chapter_ten.txt` file, because my book doesn't really need to be that long. Unfortunately, my editor pushed their branch with the `chapter_ten.txt` file existing, while my push doesn't; Git needs to be told to keep or delete the `chapter_ten.txt` file.


## How to Resolve Merge Conflicts

Merge conflicts are actually pretty easy to spot; Git uses a system of left angle brackets, right angle brackets, and equal signs followed by branch information to show where existing merge conflicts are. Below is a basic example:

```
<<<<<<<HEAD
{Content of target branch}
======
{Content of source branch}
>>>>>>>refs/remote/origin/main
```

Two steps can help us resolve any merge conflict;

1. Delete the content you don't want, along with the content markers mentioned above
2. Add the edited files to the staging area and commit your changes


## Setting up a Merge Conflict Scenario

Let's actually set up a merge conflict and work through it; first, complete the following in your `rainbow` repo (*NOT the `friend-rainbow` one*):

```bash
>>> nano rainbowcolors.txt (Add 'Indigo is the sixth color of the rainbow')
>>> git add rainbowcolors.txt
>>> git commit -m "indigo"
[main d3bd816] indigo
 1 file changed, 1 insertion(+)
>>> git push
Enumerating objects: 5, done.
Counting objects: 100% (5/5), done.
Delta compression using up to 4 threads
Compressing objects: 100% (3/3), done.
Writing objects: 100% (3/3), 325 bytes | 325.00 KiB/s, done.
Total 3 (delta 1), reused 0 (delta 0), pack-reused 0
remote: Resolving deltas: 100% (1/1), completed with 1 local object.
To https://github.com/mr-pointing/rainbow-remote.git
   4b4a3da..d3bd816  main -> main
```

Then, in your `friend-rainbow` repo, you're going to make similar but different changes;

```bash
>>> nano rainbowcolors.txt (Add 'Violet is the seventh color of the rainbow')
>>> git add rainbowcolors.txt
>>> git commit -m "violet"
[main d4fef18] violet
 1 file changed, 1 insertion(+)
>>> git log
commit d4fef18301e955797fa9f41b02c13cd9b19bf15e (HEAD -> main)
Author: mr-pointing <rpointing@blmhs.org>
Date:   Tue Jan 7 13:57:00 2025 -0500

    violet

commit 4b4a3da9cd2e6c0a1f45214f38e251ab96c64269 (origin/main, origin/HEAD)
Author: mr-pointing <rpointing@blmhs.org>
Date:   Thu Jan 2 13:43:10 2025 -0500

    blue correct
```

So in the above example, before we move on, you'll notice my previous commit before violet is actually called `blue correct`. I made a silly typo and did the three way merge before I realized, so I had to make an additional commit after `M1` with the proper spelling of blue. 

Otherwise, let's review where we are at using our visualization (for the sake of correct visualizations, I'm going to act like I didn't make any spelling errors and additional commits);

{{< image src="/images/merge_conflict_pt1.png" alt="merge_conflict_pt1" position="center" style="border-radius: 8px;" >}}


Before we encounter any issues, we could actually check and see if our paths have diverged using `status` and `log --all`;

```bash
>>> git fetch
remote: Enumerating objects: 5, done.
remote: Counting objects: 100% (5/5), done.
remote: Compressing objects: 100% (2/2), done.
remote: Total 3 (delta 1), reused 3 (delta 1), pack-reused 0 (from 0)
Unpacking objects: 100% (3/3), 305 bytes | 305.00 KiB/s, done.
From https://github.com/mr-pointing/rainbow-remote
   4b4a3da..d3bd816  main       -> origin/main
>>> git status
On branch main
Your branch and 'origin/main' have diverged,
and have 1 and 1 different commits each, respectively.
  (use "git pull" if you want to integrate the remote branch with yours)

nothing to commit, working tree clean
>>> git log --all
commit d4fef18301e955797fa9f41b02c13cd9b19bf15e (HEAD -> main)
Author: mr-pointing <rpointing@blmhs.org>
Date:   Tue Jan 7 13:57:00 2025 -0500

    violet

commit d3bd816d7e74294dae2845afc37d7a7f371b6c0c (origin/main, origin/HEAD)
Author: mr-pointing <rpointing@blmhs.org>
Date:   Tue Jan 7 13:43:22 2025 -0500

    indigo
```

## Merge Conflict Resolution Process


### Step 1

Let's actually perform the merge:

```bash
>>> git merge
Auto-merging rainbowcolors.txt
CONFLICT (content): Merge conflict in rainbowcolors.txt
Automatic merge failed; fix conflicts and then commit the result.
```

Our `rainbowcolors.txt` file now looks like this:

```
Red is the first color of the rainbow.
Orange is the second color of the rainbow.
Yellow is the third color of the rainbow.
Green is the fourth color of the rainbow.
Blue is the fifth color of the rainbow.
<<<<<<< HEAD
Violet is the seventh color of the rainbow.
=======
Indigo is the sixth color of the rainbow.
>>>>>>> refs/remotes/origin/main
```

What we're going to need to do is put the corrections that we want to save between `HEAD` and the seven equal signs. Your edits should look like this;

```
Red is the first color of the rainbow.
Orange is the second color of the rainbow.
Yellow is the third color of the rainbow.
Green is the fourth color of the rainbow.
Blue is the fifth color of the rainbow.
<<<<<<< HEAD
Indigo is the sixth color of the rainbow.
Violet is the seventh color of the rainbow.
=======
>>>>>>> refs/remotes/origin/main
```

The only thing left for us to do to this file is to actually remove the conflict markers. Your final final should look like this;

```
Red is the first color of the rainbow.
Orange is the second color of the rainbow.
Yellow is the third color of the rainbow.
Green is the fourth color of the rainbow.
Blue is the fifth color of the rainbow.
Indigo is the sixth color of the rainbow.
Violet is the seventh color of the rainbow.
```

### Step 2

Now that our changes are made, let's add our file back into the staging area and make our commit;

```bash
>>> git add rainbowcolors.txt
>>> git status
On branch main
Your branch and 'origin/main' have diverged,
and have 1 and 1 different commits each, respectively.
  (use "git pull" if you want to integrate the remote branch with yours)

All conflicts fixed but you are still merging.
  (use "git commit" to conclude merge)

Changes to be committed:
	modified:   rainbowcolors.txt
>>> git commit -m "merge commit 2"
[main 003c379] merge commit 2
>>> git log
commit 003c379ad2e0d4da4f2a1cc3ea6b8bf220efd2b1 (HEAD -> main)
Merge: d4fef18 d3bd816
Author: mr-pointing <rpointing@blmhs.org>
Date:   Wed Jan 8 11:05:29 2025 -0500

    merge commit 2

commit d4fef18301e955797fa9f41b02c13cd9b19bf15e
Author: mr-pointing <rpointing@blmhs.org>
Date:   Tue Jan 7 13:57:00 2025 -0500

    violet

commit d3bd816d7e74294dae2845afc37d7a7f371b6c0c (origin/main, origin/HEAD)
Author: mr-pointing <rpointing@blmhs.org>
Date:   Tue Jan 7 13:43:22 2025 -0500

    indigo
```

Our new visualization shows the relationship of our new `M2` commit:

{{< image src="/images/merge_conflict_pt2.png" alt="merge_conflict_pt2" position="center" style="border-radius: 8px;" >}}

Before we move on to getting the rest of the repos synced, the previous example was a very generous example; quite often, projects could have multiple files and lines of merge conflicts. Dealing with these can take away valuable development time, so always make sure to work on the most up-to-date branch (usually the `main` branch) and be sure to fetch/pull often to ensure you're not falling behind. 

In order to actually sync up, our `friend-rainbow` repo will need to `push` their changes, and then we can simply `pull` from our `rainbow` repo to grab the new commits;

```bash
(In friend-rainbow)
>>> git push
Enumerating objects: 10, done.
Counting objects: 100% (10/10), done.
Delta compression using up to 4 threads
Compressing objects: 100% (6/6), done.
Writing objects: 100% (6/6), 637 bytes | 637.00 KiB/s, done.
Total 6 (delta 2), reused 0 (delta 0), pack-reused 0
remote: Resolving deltas: 100% (2/2), completed with 1 local object.
To https://github.com/mr-pointing/rainbow-remote.git
   d3bd816..003c379  main -> main
>>> git log
commit 003c379ad2e0d4da4f2a1cc3ea6b8bf220efd2b1 (HEAD -> main, origin/main, origin/HEAD)
Merge: d4fef18 d3bd816
Author: mr-pointing <rpointing@blmhs.org>
Date:   Wed Jan 8 11:05:29 2025 -0500

    merge commit 2

commit d4fef18301e955797fa9f41b02c13cd9b19bf15e
Author: mr-pointing <rpointing@blmhs.org>
Date:   Tue Jan 7 13:57:00 2025 -0500

    violet

(Now in rainbow)
>>> git pull
remote: Enumerating objects: 10, done.
remote: Counting objects: 100% (10/10), done.
remote: Compressing objects: 100% (4/4), done.
remote: Total 6 (delta 2), reused 6 (delta 2), pack-reused 0 (from 0)
Unpacking objects: 100% (6/6), 617 bytes | 308.00 KiB/s, done.
From https://github.com/mr-pointing/rainbow-remote
   d3bd816..003c379  main       -> origin/main
Updating d3bd816..003c379
Fast-forward
 rainbowcolors.txt | 3 +++
 1 file changed, 3 insertions(+)
>>> git log
commit 003c379ad2e0d4da4f2a1cc3ea6b8bf220efd2b1 (HEAD -> main, origin/main)
Merge: d4fef18 d3bd816
Author: mr-pointing <rpointing@blmhs.org>
Date:   Wed Jan 8 11:05:29 2025 -0500

    merge commit 2

commit d4fef18301e955797fa9f41b02c13cd9b19bf15e
Author: mr-pointing <rpointing@blmhs.org>
Date:   Tue Jan 7 13:57:00 2025 -0500

    violet
```

After this, all of our repos are caught up and on the same commit. Next chapter, we're going to take a look at another method of integrating changes; rebasing.


---
Next: 
[Chapter 11]({{< ref "Learning Git - Chapter 11" >}}) 
