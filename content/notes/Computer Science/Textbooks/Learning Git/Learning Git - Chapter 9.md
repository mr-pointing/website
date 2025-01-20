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



We have to define our upstream branch if it's not defined for us already; this will allow us to just `push` our commits, instead of having to tell git where to `push` it. Remember, upstream branches are only automatically set when cloning a remote repo; when initialized locally, it will *not* be set, and you'll need to specify it. The syntax for that is below:

```bash
git branch -u <shortname>/<branch_name>
```

We can also check to see if we have an upstream branch defined or not by using the `-vv` option when using `git branch`. Let's run that and define our upstream branch inside our local `rainbow` repo;

```bash
>>> git branch -vv
* main d0ab541
>>> git branch -u origin/main
branch 'main' set up to track 'origin/main'.
>>> git branch -vv
* main d0ab541 [origin/main: ahead 1] brown
```

We can see that after setting our upstream branch, the `-vv` option tells us we're ahead 1 commit, or that our upstream branch is behind by 1. Let's walk through pushing our newest commit;

```bash
>>> git push
Enumerating objects: 4, done.
Counting objects: 100% (4/4), done.
Delta compression using up to 4 threads
Compressing objects: 100% (2/2), done.
Writing objects: 100% (3/3), 313 bytes | 313.00 KiB/s, done.
Total 3 (delta 0), reused 0 (delta 0), pack-reused 0
To https://github.com/mr-pointing/rainbow-remote.git
   dbae3cd..d0ab541  main -> main
>>> git log
commit d0ab54146cdd169ec9f121fa51b88bae47864235 (HEAD -> main, origin/main)
Author: mr-pointing <rpointing@blmhs.org>
Date:   Sat Nov 23 16:48:29 2024 -0500

    brown

commit dbae3cde2f90035d9bfcc5c9d970aba10237c2ed
Author: mr-pointing <rpointing@blmhs.org>
Date:   Thu Nov 21 12:44:27 2024 -0500

    green
```

Now we have our local `rainbow` repo being reflected in our remote repo, but to really have a three-way merge happen, the development history of our paths must *diverge*, which means our friend's repo is going to veer off in a different direction.

When making changes between commits, Git doesn't automatically load the changes up for you; as a matter of fact, Git doesn't really do *anything* automatic for you. We're about to walk through our friend editing their version of the `rainbowcolors.txt` file in the`friend-rainbow` repo, but they're *not* going to pull in our changes from the original `rainbow` repo. We're also going to watch them make a mistake in their commit, and have to go back and edit it. To make this easier to visualize, we're going to use the Git staging area diagrams we used previously in chapter 2.

{{< image src="/images/friend_directory.png" alt="friend_directory" position="center" style="border-radius: 8px;" >}}

While in our `friend-rainbow` directory, edit the `rainbowcolors.txt` file to add "Bloo is the fifth color of the rainbow." The typo is intentional. If we run `git status`, you should see that our branch is up to date, but we have one change not staged for commit, out modification to `rainbowcolors.txt`. That text file is still in the working directory, and hasn't moved onto the staging area;

{{< image src="/images/three_way_merge_p1.png" alt="three_way_merge_p1" position="center" style="border-radius: 8px;" >}}


Then, we should add our `rainbowcolors.txt` file using `git add`, and check on the `status` to see that we now have that vB file in both our working directory and staging area;

{{< image src="/images/three_way_merge_p2.png" alt="three_way_merge_p2" position="center" style="border-radius: 8px;" >}}


Now, from here, let's say your friend noticed their mistake. They're going to go back and edit the `rainbowcolors.txt` file replace "Bloo" with "Blue". After you do this, run `git status`. You should see something peculiar; `rainbowcolors.txt` as both staged for commit and *not* staged for commit. Technically, they are two different files, which can be visualized here;

{{< image src="/images/three_way_merge_p3.png" alt="three_way_merge_p3" position="center" style="border-radius: 8px;" >}}

To put our non-typo version (vC) in the staging area, we're going to very simply add it using `git add`. This will place vC in the staging area, and get our Blue commit ready to be made. Go ahead and push the correct spelling of Blue.

Currently, our friend has not fetched the `brown` commit that's in both our local and remote repo. This means our friend's repo is out of sync with our remote repo, since that's our friend's connection to the changes. Let's try to push our changes;

```bash
>>> git commit -m "blue"
[main e3fb1ec] blue
 1 file changed, 1 insertion(+)
>>> git push
To https://github.com/mr-pointing/rainbow-remote.git
 ! [rejected]        main -> main (fetch first)
error: failed to push some refs to 'https://github.com/mr-pointing/rainbow-remote.git'
hint: Updates were rejected because the remote contains work that you do not
hint: have locally. This is usually caused by another repository pushing to
hint: the same ref. If you want to integrate the remote changes, use
hint: 'git pull' before pushing again.
hint: See the 'Note about fast-forwards' in 'git push --help' for details.
>>> git log
commit e3fb1ec6f3aeaccdcae2bd063a3fb74eb0993f25 (HEAD -> main)
Author: mr-pointing <rpointing@blmhs.org>
Date:   Tue Dec 10 11:20:51 2024 -0500

    blue

commit dbae3cde2f90035d9bfcc5c9d970aba10237c2ed (origin/main, origin/HEAD)
Author: mr-pointing <rpointing@blmhs.org>
Date:   Thu Nov 21 12:44:27 2024 -0500

    green
```


As we can see, we have an error we cannot resolve with a simple fast forward merge. Git is also telling us that we should `pull` before using `push` again. Before we cover `pull` in more detail, let's perform the three way merge.

## Three-Way Merge in Practice

To get this merge going, we know from the above and the last chapter we require two things to happen; the changes needed to integrate grabbed or fetched, followed up by integrating them into the local branch.

This chapter also goes over a really interesting tool used by many programmers all over the world, **Vim**. I am not going to even think about reviewing Vim with the classroom, mostly because I'm no where near proficient enough with it myself. That being said, I'll pass on the information in the text here, although a quick visit to YouTube will show you the community for Vim is very much alive and thriving.

The reason Vim is being introduced is because we're going to initial a merge commit while performing the three-way merge, and we're *not* going to specify the commit message. Because of this, Git is going to use Vim in order to get one from us before accepting the commit. 

The actual command is simple; we're going to just accept whatever default commit message Git will provide to us, so the sequence is as follows;

1. Hit `Esc`
2. Type, `:wq`
3. Hit `Enter`

This will write or save the text, and quit out of Vim. Now that we know what to do, let's do it;

```bash
>>> git fetch
remote: Enumerating objects: 4, done.
remote: Counting objects: 100% (4/4), done.
remote: Compressing objects: 100% (2/2), done.
remote: Total 3 (delta 0), reused 3 (delta 0), pack-reused 0 (from 0)
Unpacking objects: 100% (3/3), 293 bytes | 146.00 KiB/s, done.
From https://github.com/mr-pointing/rainbow-remote
   dbae3cd..d0ab541  main       -> origin/main
>>> git merge origin/main
*Save using text editor*
Merge made by the 'ort' strategy.
 othercolors.txt | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 othercolors.txt
>>> git log
commit 5dc826f03e5c2238ce7fccd967c169ae258907a6 (HEAD -> main)
Merge: e3fb1ec d0ab541
Author: mr-pointing <rpointing@blmhs.org>
Date:   Wed Jan 1 19:20:52 2025 -0500

    Merge remote-tracking branch 'origin/main'

commit e3fb1ec6f3aeaccdcae2bd063a3fb74eb0993f25
Author: mr-pointing <rpointing@blmhs.org>
Date:   Tue Dec 10 11:20:51 2024 -0500

    blue

commit d0ab54146cdd169ec9f121fa51b88bae47864235 (origin/main, origin/HEAD)
Author: mr-pointing <rpointing@blmhs.org>
Date:   Sat Nov 23 16:48:29 2024 -0500

    brown
```

Lots to notice above; we can see the new commit in our log with Git's default message and `ort` method of merging, which is our three-way merge. We can see in the following drawing that our new visualization looks a bit messy;

{{< image src="/images/blue_brown_update.png" alt="blue_brown_update" position="center" style="border-radius: 8px;" >}}

Our new merge commit, `M1`, has two parent commits, the `brown` and `blue` commit. In the text back from `git log`, we can see the two parent commits, `3fb1ec` and `d0ab541`. We could also retrieve the same information with `git cat-file -p *commit number*`, just replace the commit number with your merge's commit number:

```bash
>>> git cat-file -p 5dc826f
tree 6737155935d3aa1b20105eb73906a2e8f15dc871
parent e3fb1ec6f3aeaccdcae2bd063a3fb74eb0993f25
parent d0ab54146cdd169ec9f121fa51b88bae47864235
author mr-pointing <rpointing@blmhs.org> 1735777252 -0500
committer mr-pointing <rpointing@blmhs.org> 1735777252 -0500

Merge remote-tracking branch 'origin/main'
```

Now, let's perform our `push` and see if we're caught up;

```bash
>>> git push
Enumerating objects: 9, done.
Counting objects: 100% (8/8), done.
Delta compression using up to 4 threads
Compressing objects: 100% (4/4), done.
Writing objects: 100% (5/5), 576 bytes | 576.00 KiB/s, done.
Total 5 (delta 1), reused 0 (delta 0), pack-reused 0
remote: Resolving deltas: 100% (1/1), completed with 1 local object.
To https://github.com/mr-pointing/rainbow-remote.git
   d0ab541..5dc826f  main -> main
>>> git log
commit 5dc826f03e5c2238ce7fccd967c169ae258907a6 (HEAD -> main, origin/main, origin/HEAD)
Merge: e3fb1ec d0ab541
Author: mr-pointing <rpointing@blmhs.org>
Date:   Wed Jan 1 19:20:52 2025 -0500

    Merge remote-tracking branch 'origin/main'

commit e3fb1ec6f3aeaccdcae2bd063a3fb74eb0993f25
Author: mr-pointing <rpointing@blmhs.org>
Date:   Tue Dec 10 11:20:51 2024 -0500

    blue
```

Again, we can confirm we're up to date using `git log`, and as we can see we're all caught up and have merged our commits. 

Just to recap, in both our `friend-rainbow` directory and remote repo, our `rainbowcolors.txt` looks like this:

```
Red is the first color of the rainbow.
Orange is the second color of the rainbow.
Yellow is the third color of the rainbow.
Green is the fourth color of the rainbow.
Blue is the fifth color of the rainbow.
```

and we have our other file `othercolors.txt` that just says:

```
Brown is not a color of the rainbow.
```


## Pulling Changes

If we were to look back at our local `rainbow` repo, remember that we would ***not*** see the fifth line in `rainbowcolors.txt`, because we haven't fetched the new remote changes. Like before, we would need to fetch the new commits, then merge them with our local repo. 

With a command called `pull`, we'll be able to achieve both the previous goals at once. The only thing we would need to specify is the upstream branch if it is not set; otherwise, we can just use `git pull` to get started.


```bash
>>> git pull
remote: Enumerating objects: 12, done.
remote: Counting objects: 100% (11/11), done.
remote: Compressing objects: 100% (5/5), done.
remote: Total 8 (delta 2), reused 8 (delta 2), pack-reused 0 (from 0)
Unpacking objects: 100% (8/8), 815 bytes | 407.00 KiB/s, done.
From https://github.com/mr-pointing/rainbow-remote
   d0ab541..4b4a3da  main       -> origin/main
Updating d0ab541..4b4a3da
Fast-forward
 rainbowcolors.txt | 1 +
 1 file changed, 1 insertion(+)
>>> git log
commit 5dc826f03e5c2238ce7fccd967c169ae258907a6 (HEAD -> main, origin/main, origin/HEAD)
Merge: e3fb1ec d0ab541
Author: mr-pointing <rpointing@blmhs.org>
Date:   Wed Jan 1 19:20:52 2025 -0500

    Merge remote-tracking branch 'origin/main'

commit e3fb1ec6f3aeaccdcae2bd063a3fb74eb0993f25
Author: mr-pointing <rpointing@blmhs.org>
Date:   Tue Dec 10 11:20:51 2024 -0500

    blue
```

There is one pro-tip that's important to understand about choosing between doing `git fetch` and `merge` or just `git pull`, and that's on the method of combination you're using; merging or rebasing. The common practice is that if your local repo and remote repo's development history has *diverged*, then you should `fetch` and choose to `merge` or `rebase`. If there hasn't been a divergence, you can just use `git pull`.

The final, updated visualization can be seen below;

{{< image src="/images/final_three_way.png" alt="final_three_way" position="center" style="border-radius: 8px;" >}}


---
Next: 
[Chapter 10]({{< ref "Learning Git - Chapter 10" >}}) 
