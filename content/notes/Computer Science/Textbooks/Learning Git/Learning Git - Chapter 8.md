---
aliases: 
draft: false
tags:
  - computerscience
  - git
  - textbook
title: Learning Git - Chapter 8
date: 2024-11-09
updated: 2024-11-28T13:40
---

-------------------------------------------------------------------------------

# Cloning and Fetching

As it stands, we have just pushed our local repo onto our remote repo, and updated it with all currently created branches. For this chapter, we're going to start working through what it would be like if you'd like to start working on your project with a friend or coworker through an essential core concept of Git called *cloning*, or copying a remote repository.


## Cloning a Remote Repository

Like we know for the beginning of this text, Git is a major player in collaborative coding. The below example returns to our Book Project for another example of how we would use it.

>[!Example Book Project]
> The co-author working on my book with me, if he wants to keep up to date, would need to clone my repo in order to get all of the most current commits.
> 
> This would require getting their GitHub account set up, and me giving them privileges to make commits and pushes. 

Since using another machine for a textbook follow along is a little extra, we can happily just use another directory and clone into our remote repo. Make a new directory simply called `friend-rainbow`. We can use the following git command to get this going;

```bash
git clone <URL> <directory_name>
```

This will put whichever remote repo's URL you provided into the specified directory. Here's exactly what happens when call that `clone` command;

1. Creates a project directory into the specified directory (in this case, `friend-rainbow`)
2. Initializes a local repo in `friend-repo`
3. Downloads all data on remote repo
4. Adds a connection to the remote repo with the name `origin` in the new local repo

We can use a few git commands to inspect the changes and state of our `friend-rainbow` directory.

```bash
>>> cd friend-rainbow # in case you're not already there, navigate into your new local repo
>>> git remote -v
origin	https://github.com/mr-pointing/rainbow-remote.git (fetch)
origin	https://github.com/mr-pointing/rainbow-remote.git (push)
>>> git branch --all
* main
  remotes/origin/HEAD -> origin/main
  remotes/origin/feature
  remotes/origin/main
>>> git log
commit 43a7cffeceeaa1be4b55e94f4769ff5dc154cde4 (HEAD -> main, origin/main, origin/feature, origin/HEAD)
Author: mr-pointing <rpointing@blmhs.org>
Date:   Sat Sep 14 16:57:14 2024 -0400

    yellow

commit ae65b50098378ac6bf0cbe9ab92a9884b98db61b
Author: mr-pointing <rpointing@blmhs.org>
Date:   Fri Sep 13 15:59:13 2024 -0400

    orange
```


First up, we use the `remote -v` command to list out our remote repo. Then, we use `git branch --all` to retrieve all branches; notice how there is no local feature branch? Small but important detail. `feature` and `main` exist as remote branches, while we only have one local branch, `main`. There is also a remote `HEAD` pointing to the remote `main`branch. We'll go over the questions that arise from cloning in the next few sections, but first, let's get a better visualization of where we're at in our project.

{{< image src="/images/friend_rainbow_viz.png" alt="friend_rainbow_viz" position="center" style="border-radius: 8px;" >}}


### What is `origin/HEAD`?

Like we saw above, we have this `remote/origin/HEAD` branch pointing at `origin/main`. This is here so Git can know when to stop cloning, or when it's given you the designated `HEAD` branch defined in the remote repository. For the rest of the visualizations thought, the author leaves it out, so I'll do the same.


### Why no `feature` branch?

When we clone a repository, we are only going to locally receive the branch being pointed at by that `origin/HEAD` pointer we just learned about. So, in order to actually get onto the feature branch, we'll have to switch onto it, and it'll create a local branch for us based on the `feature` branch on the remote repo.

```bash
>>> git switch feature
branch 'feature' set up to track 'origin/feature'.
Switched to a new branch 'feature'
>>> git branch --all
* feature
  main
  remotes/origin/HEAD -> origin/main
  remotes/origin/feature
  remotes/origin/main
```

Now, our local `HEAD` is pointing at our new local branch, `feature`.

## Deleting Branches

The same reasons why we'd delete anything apply to git; we don't want things we aren't using or referencing, and it helps keep a project organized. Obviously, make sure you don't need any of the work on a branch before you commit it, by merging the work onto a branch you're using. 

Funnily enough, when you delete a branch you don't actually delete any of the commits made on that branch. They're actually still there, but really hard to reach since there is no branch in which to retrieve them from. 

Maybe your friend working in the `friend-rainbow` branch doesn't want to work on the `feature` branch anymore. It's deletion comes in three parts; the remote branch, the remote-tracking branch, and the local branch. 

We can delete a remote branch and remote-tracking branch at once with the following command:

```bash
git push <shortname> -d <branch_name>
```

Deleting a local branch is also a relatively simple command:

```bash
git branch -d <branch_name>
```

The following code is going to walk through us acting as our friend in our `friend-rainbow` repo. Important to notice that we have to be on a different branch in order to delete `feature`, you cannot delete a branch you're currently on.

```bash
>>> git branch --all
* feature
  main
  remotes/origin/HEAD -> origin/main
  remotes/origin/feature
  remotes/origin/main
>>> git push origin -d feature
Username for 'https://github.com': mr-pointing
Password for 'https://mr-pointing@github.com':
To https://github.com/mr-pointing/rainbow-remote.git
 - [deleted]         feature
>>> git branch --all
* feature
  main
  remotes/origin/HEAD -> origin/main
  remotes/origin/main
>>> git switch main
Switched to branch 'main'
Your branch is up to date with 'origin/main'.
>>> git branch -d feature
Deleted branch feature (was 43a7cff).
>>> git branch --all
* main
  remotes/origin/HEAD -> origin/main
  remotes/origin/main
```

In our, or the first `rainbow` directory, we'll still have access to our feature branch. Not only that, but we'll still have our `origin/feature` branch, which we'll delete later.


## Git Collaborations and Branches

When working on a project, it's good common practice to give you and your team some conventions and rules to follow about making commits, pushes, commit messages, and so on. 

We covered this a few chapters ago, but remember to discuss these with the people you're working with. Now that we know how to make branches, it's usually a good idea to work on individual branches before making any merges or commits to the main branch, which then can be reviewed by the team/team leader before integration.

### Walking Through Collaboration 

To get a hands on approach of good collaboration practices, let's start acting like our friend and make a new commit to our `rainbowcolors.txt` file. Following the rainbow theme, add in "Green is the fourth color of the rainbow." to line 4. Then, run the following commands;

```bash
>>> git add rainbowcolors.txt
>>> git commit -m "green"
[main dbae3cd] green
 1 file changed, 1 insertion(+)
>>> git log
commit dbae3cde2f90035d9bfcc5c9d970aba10237c2ed (HEAD -> main)
Author: mr-pointing <rpointing@blmhs.org>
Date:   Thu Nov 21 12:44:27 2024 -0500

    green

commit 43a7cffeceeaa1be4b55e94f4769ff5dc154cde4 (origin/main, origin/HEAD)
Author: mr-pointing <rpointing@blmhs.org>
Date:   Sat Sep 14 16:57:14 2024 -0400

    yellow
```

Our new visualization looks like this;

{{< image src="/images/friend_rainbow_green_update.png" alt="friend_rainbow_green_update" position="center" style="border-radius: 8px;" >}}


An important reflection in this update is that although `HEAD` has moved, the `origin/main` pointer in `friend-rainbow` is still pointing at yellow, since we didn't push anything to our remote repo.

Since we're pushing work from a local branch into a remote branch. If there happens to be a default upstream branch, we can use `git push` and call it a day. If there isn't however, we'll have to specify one. If you want to see if there is, you can use `git branch -vv`, or the "very verbose" option for branch information. When running that from your `friend-rainbow` directory, you should get the following output;

```bash
>>> git branch -vv
* main dbae3cd [origin/main: ahead 1] green
>>> git status
On branch main
Your branch is ahead of 'origin/main' by 1 commit.
  (use "git push" to publish your local commits)

nothing to commit, working tree clean 
```

This output should make sense; we're still on main, we got rid of `feature`, and we the upstream branch (or the remote branch `origin/main`) never got our `green` commit, so it should be one step behind us. The `ahead 1` is actually referring to us, which you can see more explicitly in the second command used above, `git status`. Since the branch we want to push to is our default upstream branch, we can nicely just use `git push` to upload our commit to the remote repo;

```bash
>>> git push
Enumerating objects: 5, done.
Counting objects: 100% (5/5), done.
Delta compression using up to 4 threads
Compressing objects: 100% (2/2), done.
Writing objects: 100% (3/3), 292 bytes | 292.00 KiB/s, done.
Total 3 (delta 1), reused 0 (delta 0), pack-reused 0
remote: Resolving deltas: 100% (1/1), completed with 1 local object.
To https://github.com/mr-pointing/rainbow-remote.git
   43a7cff..dbae3cd  main -> main
>>> git status
On branch main
Your branch is up to date with 'origin/main'.

nothing to commit, working tree clean
>>> git log
commit dbae3cde2f90035d9bfcc5c9d970aba10237c2ed (HEAD -> main, origin/main, origin/HEAD)
Author: mr-pointing <rpointing@blmhs.org>
Date:   Thu Nov 21 12:44:27 2024 -0500

    green

commit 43a7cffeceeaa1be4b55e94f4769ff5dc154cde4
Author: mr-pointing <rpointing@blmhs.org>
Date:   Sat Sep 14 16:57:14 2024 -0400

    yellow
```

Again, we can use commands like `status` and `log` to help track our progress. If your output looks vastly different to mine, maybe retrace your steps before moving forward. Our new visualization can be seen below.

{{< image src="/images/friend_green_push.png" alt="friend_green_push" position="center" style="border-radius: 8px;" >}}


## Incorporating Changes from the Remote Repository

Unfortunately for us, since our friend is working from a different local repo, when he pushes to the remote repo we are both using, my local repo does **not** automatically update. I say unfortunately, because it means a little more work for us, but really it's a blessing. Say for example, our friend uploaded something that broke our code (for our project's sake, say they incorrectly named Green as the last color of the rainbow), it be broken *everywhere*. That is obviously, really bad.

We are going to have to go get the updates made to our remote repo ourselves. This does put more responsibility on our shoulders, but that's sort of our thing as software developers. 

One way we can refer to getting the updated repo information is a *fetch*. We are fetching a repo when we want to just download all of the changes, without any integration. To actually integrate the data we downloaded, we're going to have to perform a *merge*. The merging process takes whatever changes were fetched from the remote repo. Later on we'll learn how to combine these, but for now let's take this one step at time.

#### Fetch

To fetch a branch is, like most git commands, straight-forward. Without specifying a branch name, it will grab `origin` or the defined upstream branch. The syntax is;

```bash
git fetch <shortname>
```

The fetched data isn't saved only onto the remote branches, without any merging into our local branches.

```bash
>>> git log --all
commit 43a7cffeceeaa1be4b55e94f4769ff5dc154cde4 (HEAD -> feature, origin/main, origin/feature, main)
Author: mr-pointing <rpointing@blmhs.org>
Date:   Sat Sep 14 16:57:14 2024 -0400

    yellow

commit ae65b50098378ac6bf0cbe9ab92a9884b98db61b
Author: mr-pointing <rpointing@blmhs.org>
Date:   Fri Sep 13 15:59:13 2024 -0400

    orange
>>> git fetch
remote: Enumerating objects: 5, done.
remote: Counting objects: 100% (5/5), done.
remote: Compressing objects: 100% (1/1), done.
remote: Total 3 (delta 1), reused 3 (delta 1), pack-reused 0 (from 0)
Unpacking objects: 100% (3/3), 272 bytes | 45.00 KiB/s, done.
From https://github.com/mr-pointing/rainbow-remote
   43a7cff..dbae3cd  main       -> origin/main
>>> git log --all
commit dbae3cde2f90035d9bfcc5c9d970aba10237c2ed (origin/main)
Author: mr-pointing <rpointing@blmhs.org>
Date:   Thu Nov 21 12:44:27 2024 -0500

    green

commit 43a7cffeceeaa1be4b55e94f4769ff5dc154cde4 (HEAD -> feature, origin/feature, main)
Author: mr-pointing <rpointing@blmhs.org>
Date:   Sat Sep 14 16:57:14 2024 -0400

    yellow
```

#### Merge

Just like we did in chapter 5, we're going to do another fast-forward merge. We have to be on the branch we want to merge into, so we should switch back onto main to make that happen. 

```bash
>>> git switch main
Switched to branch 'main'
>>> git merge origin/main
Updating 43a7cff..dbae3cd
Fast-forward
 rainbowcolors.txt | 1 +
 1 file changed, 1 insertion(+)
>>> git log
commit dbae3cde2f90035d9bfcc5c9d970aba10237c2ed (HEAD -> main, origin/main)
Author: mr-pointing <rpointing@blmhs.org>
Date:   Thu Nov 21 12:44:27 2024 -0500

    green

commit 43a7cffeceeaa1be4b55e94f4769ff5dc154cde4 (origin/feature, feature)
Author: mr-pointing <rpointing@blmhs.org>
Date:   Sat Sep 14 16:57:14 2024 -0400

    yellow
```

To continue our clean up, we should get rid of feature in our local `rainbow` repo. The only difference is now we don't have a remote repo for our `feature` branch anymore, so we're going to have to use a different command than last time. This command is actually a use of the fetch command, `git fetch -p`. The `-p` stands for prune, which will get rid of any remote branches in our local repo that no longer exist in our remote repo. Then, we can just use a `-d` command for `branch` to get rid of the local feature.

```bash
>>> git branch --all
  feature
* main
  remotes/origin/feature
  remotes/origin/main
>>> git fetch -p
From https://github.com/mr-pointing/rainbow-remote
 - [deleted]         (none)     -> origin/feature
>>> git branch --all
  feature
* main
  remotes/origin/main
>>> git branch -d feature
Deleted branch feature (was 43a7cff).
>>> git branch --all
* main
  remotes/origin/main
```


---
Next: 
[Chapter 9]({{< ref "Learning Git - Chapter 9" >}}) 
