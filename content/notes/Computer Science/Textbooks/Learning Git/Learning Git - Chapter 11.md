---
aliases: 
draft: false
tags:
  - computerscience
  - git
  - textbook
title: Learning Git - Chapter 11
date: 2025-01-08
updated: 2025-01-12T14:25
---

-------------------------------------------------------------------------------

# Rebasing

We're over ten chapters into this text; let's get a quick recap of the status of our repos:

{{< image src="/images/repo_status_11.png" alt="repo_status_11" position="center" style="border-radius: 8px;" >}}


One thing to notice about the repos up until this point is that up to the `green` commit, our project's history was linear. Some people prefer to keep their history this way, and want to avoid branching pathways, like we had to do for the three-way merges we had to make. 

One way to avoid creating branching paths is with *rebasing*, which takes changes and creates *new* commits. This can be confusing to understand, so let's look at our example book project.

> [!Example Book Project]
> We're actually going to use the scenario from [Chapter 9]({{< ref "Learning Git - Chapter 9" >}}). I am working with a coauthor on a project now, and We are on commit `B`. We both decide we are going to work on separate branches off of commit `B`; I decide to name my branch `chapter_11` and my coauthor uses `chapter_12`.
> 
> Unfortunately, my coauthor again chooses to commit and push to our remote repo before me, creating commit `C` and updating our remote repo to point at that commit. When I make my first commit, it will be commit `D`.
> 
> I could do a `fetch` and three way merge to integrate my chapter into the remote repo, but that's going to create a merge commit and my team/department doesn't want branching paths.
> 
> Instead, I could `pull` the most recent changes, with the intent to rebase the `chapter_11` branch on top of the `main` branch. This would, in my local repo, create a new commit, `D'`, as well as bring in `C` from our remote repo. My local repo would have `main` pointing at `C`, and `chapter_11` pointing at `D'`. Then, all I need to do is fast-forward merge my local repo and we're all caught up.


## Setting Up the Rebase

Here's how we can set this up; again, we'll need diverging paths. We'll get this by committing something in our `rainbow` repo and `push` it to the remote repo; then, our "friend" makes some commits into the `friend-rainbow` without fetching the commits we pushed. After the commits are made, then we can fetch and begin the rebase. 

```bash
>>> nano othercolors.txt
# Add "Gray is not a color of the rainbow."
>>> git add othercolors.txt
>>> git commit -m "gray"
[main 5c7072f] gray
 1 file changed, 1 insertion(+)
>>> git push
Enumerating objects: 5, done.
Counting objects: 100% (5/5), done.
Delta compression using up to 4 threads
Compressing objects: 100% (3/3), done.
Writing objects: 100% (3/3), 318 bytes | 318.00 KiB/s, done.
Total 3 (delta 0), reused 0 (delta 0), pack-reused 0
To https://github.com/mr-pointing/rainbow-remote.git
   003c379..5c7072f  main -> main
>>> git log
commit 5c7072f0dd7de9c4b08aba768ef923d3592b6ddb (HEAD -> main, origin/main)
Author: mr-pointing <rpointing@blmhs.org>
Date:   Sat Jan 11 15:09:34 2025 -0500

    gray

commit 003c379ad2e0d4da4f2a1cc3ea6b8bf220efd2b1
Merge: d4fef18 d3bd816
Author: mr-pointing <rpointing@blmhs.org>
Date:   Wed Jan 8 11:05:29 2025 -0500

    merge commit 2
```

### Unstaging and Staging Files

I'm not going to go too deep into this, mostly because I think for students, I might want to introduce this concept when introducing the staging area. Students are bound to make mistakes, or rush and accidently add something they don't want. I can already see the looks on their faces when I tell them that I won't be teaching them how to undo it until the *end* of the unit, so I think earlier the better.

We know the staging area acts as a rough draft for our commits. Logically then, if we can add something to it, we can remove something from it. This can be achieved rather simply with the `git restore --staged <filename>` command. There is a follow along for you to practice staging and unstaging a file, but I want to focus primarily on the rebasing in this chapter.

In the `friend-rainbow` repo;

```bash
>>> nano othercolors.txt
# Add "Black is not a color in the rainbow"
>>> git status
On branch main
Your branch is up to date with 'origin/main'.

Changes not staged for commit:
  (use "git add <file>..." to update what will be committed)
  (use "git restore <file>..." to discard changes in working directory)
	modified:   othercolors.txt

no changes added to commit (use "git add" and/or "git commit -a")
>>> git add othercolors.txt
>>> git status
On branch main
Your branch is up to date with 'origin/main'.

Changes to be committed:
  (use "git restore --staged <file>..." to unstage)
	modified:   othercolors.txt
>>> git commit -m "black"
[main 2be843e] black
 1 file changed, 1 insertion(+)
>>> git status
On branch main
Your branch is ahead of 'origin/main' by 1 commit.
  (use "git push" to publish your local commits)

nothing to commit, working tree clean
>>> git log
commit 2be843e812a656c5ba97ef28fba50f74867e6f89 (HEAD -> main)
Author: mr-pointing <rpointing@blmhs.org>
Date:   Sat Jan 11 15:25:42 2025 -0500

    black

commit 003c379ad2e0d4da4f2a1cc3ea6b8bf220efd2b1 (origin/main, origin/HEAD)
Merge: d4fef18 d3bd816
Author: mr-pointing <rpointing@blmhs.org>
Date:   Wed Jan 8 11:05:29 2025 -0500

    merge commit 2
>>> nano rainbowcolors.txt
# Add "These are the colors of the rainbow."
>>> git add rainbowcolors.txt
>>> git commit -m "rainbow"
[main a40f4f1] rainbow
 1 file changed, 1 insertion(+), 1 deletion(-)
>>> git log
commit a40f4f1bee9e6d6434b0e3f8a8c2a483e9ea7bac (HEAD -> main)
Author: mr-pointing <rpointing@blmhs.org>
Date:   Sat Jan 11 15:34:36 2025 -0500

    rainbow

commit 2be843e812a656c5ba97ef28fba50f74867e6f89
Author: mr-pointing <rpointing@blmhs.org>
Date:   Sat Jan 11 15:25:42 2025 -0500

    black

commit 003c379ad2e0d4da4f2a1cc3ea6b8bf220efd2b1 (origin/main, origin/HEAD)
Merge: d4fef18 d3bd816
Author: mr-pointing <rpointing@blmhs.org>
Date:   Wed Jan 8 11:05:29 2025 -0500

    merge commit 2
```

A lot going on here. Again, not too much happening, mostly editing text files, adding them to the staging area, and making commits when ready. We've committed twice now, once for our `othercolors.txt` file and once for our `rainbowcolors.txt` file.

Now, again, to start our rebase we acting as our friend have to `fetch` the most recent changes in the remote repo;

```bash
>>> git fetch
remote: Enumerating objects: 5, done.
remote: Counting objects: 100% (5/5), done.
remote: Compressing objects: 100% (3/3), done.
remote: Total 3 (delta 0), reused 3 (delta 0), pack-reused 0 (from 0)
Unpacking objects: 100% (3/3), 298 bytes | 99.00 KiB/s, done.
From https://github.com/mr-pointing/rainbow-remote
   003c379..5c7072f  main       -> origin/main
>>> git log --all
commit a40f4f1bee9e6d6434b0e3f8a8c2a483e9ea7bac (HEAD -> main)
Author: mr-pointing <rpointing@blmhs.org>
Date:   Sat Jan 11 15:34:36 2025 -0500

    rainbow

commit 2be843e812a656c5ba97ef28fba50f74867e6f89
Author: mr-pointing <rpointing@blmhs.org>
Date:   Sat Jan 11 15:25:42 2025 -0500

    black

commit 5c7072f0dd7de9c4b08aba768ef923d3592b6ddb (origin/main, origin/HEAD)
Author: mr-pointing <rpointing@blmhs.org>
Date:   Sat Jan 11 15:09:34 2025 -0500

    gray
```

Now, the most important repo I want to visualize is the `friend-rainbow` repo;

{{< image src="/images/rebase_pt2.png" alt="rebase_pt2" position="center" style="border-radius: 8px;" >}}


Performing the rebase is simple; use `git rebase`, and barring any merge conflicts you'll be good to go. Behind the scenes, there are five steps happening I'll go into a little more detail below.

1. **Find the Common Ancestor**
	1. Git has to find the common ancestor between the branch you are on (`main`) and the branch you are trying to rebase onto (`origin/main`). In this case, that would be `M2`.
2. **Store Information About the Branches Involved in the Rebase**
	1. Git saves all of the changes made in each commit of the branch you're currently on in some temporary, unimportant area, along with information on the branch to rebase onto and where the branch originally was. For us, changes made in the `black` and `rainbow` commit will be saved along with information on `gray` and `main`.
3. **Reset HEAD**
	1. Git places head to the commit you are rebasing too, `gray`.
4. **Apply and Commit the Changes**
	1. Git makes all of the changes from each commit, and makes *new* commits. Think of these like `black'` and `black`; similar but different.
5. **Switch onto the Rebased Branch**
	1. Git checks out `HEAD` at it's most latest commit.

If we have no issues, our repo would look like this;

{{< image src="/images/rebase_pt3.png" alt="rebase_pt3" position="center" style="border-radius: 8px;" >}}


We are, for the sake of getting experience, going to run into issues.

## Rebasing and Merge Conflicts

An important concept to understand about merge conflicts when discussing rebasing compared to three way merging is the rate in which you fix your merge conflicts. During a three way merge, Git will present you with all of the conflicts at once, and after your changes are made and added you make the commit to complete the merge. You are editing only *once*. 

For rebasing, depending on where your merge conflicts are, you'll have to resolve them *per* commit. Remember, since in a rebase you are making new commits of each previously merging commit, you'll have to deal with each conflict one at a time. This means you could be editing, adding, and committing multiple times during a rebase. You even need a special addition to our command, `git rebase --continue`, to tell Git to continue with the rebase after each commits merge conflicts are resolved.

If you wanted to stop the rebase in the middle for whatever reason, you can use `git rebase --abort` to stop and return to the state of the repo before the merge. 

Let's try this out;

```bash
>>> git rebase origin/main
Auto-merging othercolors.txt
CONFLICT (content): Merge conflict in othercolors.txt
error: could not apply 2be843e... black
hint: Resolve all conflicts manually, mark them as resolved with
hint: "git add/rm <conflicted_files>", then run "git rebase --continue".
hint: You can instead skip this commit: run "git rebase --skip".
hint: To abort and get back to the state before "git rebase", run "git rebase --abort".
Could not apply 2be843e... black
>>> git status
interactive rebase in progress; onto 5c7072f
Last command done (1 command done):
   pick 2be843e black
Next command to do (1 remaining command):
   pick a40f4f1 rainbow
  (use "git rebase --edit-todo" to view and edit)
You are currently rebasing branch 'main' on '5c7072f'.
  (fix conflicts and then run "git rebase --continue")
  (use "git rebase --skip" to skip this patch)
  (use "git rebase --abort" to check out the original branch)

Unmerged paths:
  (use "git restore --staged <file>..." to unstage)
  (use "git add <file>..." to mark resolution)
	both modified:   othercolors.txt
```

As you can see, Git is always pretty descriptive of what needs to be done. As long as you're following along and paying attention, Git will pretty much tell you what to do. We see that we were able to merge our black commit (`last done`) and we now have to edit the `othercolors.txt` file and continue;

```bash
>>> nano othercolors.txt
>>> git add othercolors.txt
>>> git status
interactive rebase in progress; onto 5c7072f
Last command done (1 command done):
   pick 2be843e black
Next command to do (1 remaining command):
   pick a40f4f1 rainbow
  (use "git rebase --edit-todo" to view and edit)
You are currently rebasing branch 'main' on '5c7072f'.
  (all conflicts fixed: run "git rebase --continue")

Changes to be committed:
  (use "git restore --staged <file>..." to unstage)
	modified:   othercolors.txt
>>> git rebase --continue
[detached HEAD 75d347c] black
 1 file changed, 1 insertion(+)
Successfully rebased and updated refs/heads/main.
>>> git log
commit 14075809eb71cfb5e4ed3351b51736dadd6c9b65 (HEAD -> main)
Author: mr-pointing <rpointing@blmhs.org>
Date:   Sat Jan 11 15:34:36 2025 -0500

    rainbow

commit 75d347cf2daa17f02db899ba060aae55c1fa6a22
Author: mr-pointing <rpointing@blmhs.org>
Date:   Sat Jan 11 15:25:42 2025 -0500

    black

commit 5c7072f0dd7de9c4b08aba768ef923d3592b6ddb (origin/main, origin/HEAD)
Author: mr-pointing <rpointing@blmhs.org>
Date:   Sat Jan 11 15:09:34 2025 -0500

    gray
```

If you notice, after the rebasing we now have entirely new `black` and `rainbow` commits. This is because again, rebasing rewrites history. This leads us to the golden rule of rebasing; ***you should not rebase a branch that other people's work is based on***. 

Finally, we can sync all the work to the other repos;

```bash
>>> git push
Enumerating objects: 9, done.
Counting objects: 100% (9/9), done.
Delta compression using up to 4 threads
Compressing objects: 100% (6/6), done.
Writing objects: 100% (6/6), 643 bytes | 643.00 KiB/s, done.
Total 6 (delta 1), reused 0 (delta 0), pack-reused 0
remote: Resolving deltas: 100% (1/1), completed with 1 local object.
To https://github.com/mr-pointing/rainbow-remote.git
   5c7072f..1407580  main -> main
>>> git log
commit 14075809eb71cfb5e4ed3351b51736dadd6c9b65 (HEAD -> main, origin/main, origin/HEAD)
Author: mr-pointing <rpointing@blmhs.org>
Date:   Sat Jan 11 15:34:36 2025 -0500

    rainbow

commit 75d347cf2daa17f02db899ba060aae55c1fa6a22
Author: mr-pointing <rpointing@blmhs.org>
Date:   Sat Jan 11 15:25:42 2025 -0500

    black

# In regular rainbow repo now
>>> git pull
remote: Enumerating objects: 9, done.
remote: Counting objects: 100% (9/9), done.
remote: Compressing objects: 100% (5/5), done.
remote: Total 6 (delta 1), reused 6 (delta 1), pack-reused 0 (from 0)
Unpacking objects: 100% (6/6), 623 bytes | 89.00 KiB/s, done.
From https://github.com/mr-pointing/rainbow-remote
   5c7072f..1407580  main       -> origin/main
Updating 5c7072f..1407580
Fast-forward
 othercolors.txt   | 1 +
 rainbowcolors.txt | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)
>>> git log
commit 14075809eb71cfb5e4ed3351b51736dadd6c9b65 (HEAD -> main, origin/main)
Author: mr-pointing <rpointing@blmhs.org>
Date:   Sat Jan 11 15:34:36 2025 -0500

    rainbow

commit 75d347cf2daa17f02db899ba060aae55c1fa6a22
Author: mr-pointing <rpointing@blmhs.org>
Date:   Sat Jan 11 15:25:42 2025 -0500

    black
```

---
Next: 
[Chapter 12]({{< ref "Learning Git - Chapter 12" >}}) 

