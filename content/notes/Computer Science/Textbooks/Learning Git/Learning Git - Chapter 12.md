---
aliases: 
draft: false
tags:
  - computerscience
  - git
  - textbook
title: Learning Git - Chapter 12
date: 2025-01-12
updated: 2025-01-12T15:42
---

-------------------------------------------------------------------------------

We're on our final chapter, and almost through with the rainbow project. Before we move onto our last lesson, let's review where we're at;

{{< image src="/images/repo_status_12.png" alt="repo_status_12" position="center" style="border-radius: 8px;" >}}


An important distinction we need to make up front first is that in the past, we have introduced and used `pull`. While that is involved in what we're about to learn, we're going to go more specifically into *pull requests*, or a request to collaborate on work via a hosting service. You can integrate them using merging or rebasing, but mostly you'll be using merging, so you'll often hear the term "merge a pull request."

Some more terminology for you; when you create the pull request it's known as "open", and after merged you "close" it. The text breaks it down into 9 steps;

1. Create a new branch in a local repo
2. Make new commits on your new branch
3. Push new branch to remote repo
4. Open new pull request into hosting service (GitHub)
5. Pull request reviewed (if not approved, here is where adjustments are made)
6. Pull request approval!
7. Pull request is merged
8. If feature branch, delete it
9. Pull changes to sync local repo with remote repo, then delete local and remote branch


## Why Use Pull Requests?

Pull requests can be thought of a lot like a bounty board of ideas. If you go onto any popular GitHub repo, you'll find hundreds of pull requests. Some are simple changes someone thought would look nice. Other are genuine quality of life changes the original developer might never had envisioned for the users of their product. The most crucial aspect of these examples are they are community driven; *pull requests incentivize and allow for collaborative content*.


## Preparing a Pull Request

Following the 9 steps, we begin by creating a new branch with some commits, and `push` it;

```bash
>>> git switch -c topic
Switched to a new branch 'topic'
>>> nano othercolors.txt
>>> git add othercolors.txt
>>> git commit -m "pink"
[topic 2112a22] pink
 1 file changed, 1 insertion(+)
>>> git log
commit 2112a227cd765c744b6f60bd3694f3061ae45513 (HEAD -> topic)
Author: mr-pointing <rpointing@blmhs.org>
Date:   Sun Jan 12 15:01:34 2025 -0500

    pink

commit 14075809eb71cfb5e4ed3351b51736dadd6c9b65 (origin/main, main)
Author: mr-pointing <rpointing@blmhs.org>
Date:   Sat Jan 11 15:34:36 2025 -0500

    rainbow
```

We should have our new branch `topic` created with `HEAD` pointing at it, one commit ahead of `main` and our remote repo.

{{< image src="/images/pull_request_pt1.png" alt="pull_request_pt1" position="center" style="border-radius: 8px;" >}}


`topic` is a new branch, which means it doesn't have an upstream branch defined for it yet. If we try to push it, we'll get an error. We'll have to remember to push and use `--set-upstream` to define our branch;

```bash
>>> git branch -vv
  main  1407580 [origin/main] rainbow
* topic 2112a22 pink
>>> git push --set-upstream origin topic
Enumerating objects: 5, done.
Counting objects: 100% (5/5), done.
Delta compression using up to 4 threads
Compressing objects: 100% (3/3), done.
Writing objects: 100% (3/3), 304 bytes | 304.00 KiB/s, done.
Total 3 (delta 1), reused 0 (delta 0), pack-reused 0
remote: Resolving deltas: 100% (1/1), completed with 1 local object.
remote:
remote: Create a pull request for 'topic' on GitHub by visiting:
remote:      https://github.com/mr-pointing/rainbow-remote/pull/new/topic
remote:
To https://github.com/mr-pointing/rainbow-remote.git
 * [new branch]      topic -> topic
branch 'topic' set up to track 'origin/topic'.
>>> git branch -vv
  main  1407580 [origin/main] rainbow
* topic 2112a22 [origin/topic] pink
>>> git log
commit 2112a227cd765c744b6f60bd3694f3061ae45513 (HEAD -> topic, origin/topic)
Author: mr-pointing <rpointing@blmhs.org>
Date:   Sun Jan 12 15:01:34 2025 -0500

    pink

commit 14075809eb71cfb5e4ed3351b51736dadd6c9b65 (origin/main, main)
Author: mr-pointing <rpointing@blmhs.org>
Date:   Sat Jan 11 15:34:36 2025 -0500

    rainbow
```

Now that we have our source branch (`topic`) made, we can create the pull request to merge it into the target branch (`main`). Using these names is important; you will have to fill out the source and target branch using GitHub's UI. 

Funnily enough, as soon as I looked at my remote repo on GitHub it noticed a new branch had changes, and was prompting me to click on it to create a pull request. For the sake of the doing it like the text, I'll do it from scratch.

On GitHub, you have to chose a `base` and a `compare`. I believe it's the same pair respectively to source and target, but I could be wrong (it worked for me). It will give you the ability to add a title and description ("Adding the color Pink" works great for a title).

A lot of different paths can be taken here; your team can leave comments on your work, that might lead you back to edit more. You might realize you don't need to implement this feature at all and close it prematurely. Depending on the situation, most of it will happen through the UI. Once the pull request is made, you can approve it and merge it, all through the nice blue buttons on screen.

We now have a new commit in our remote repo, the merge of `rainbow'` and `pink`. Almost done; we have to delete to remote branches, sync and clean up.

## Deleting Remote Branches

Common practice says to delete branches like the `topic` branch after it has been merged. This will help keep requests contained, and the overall history of the project cleaner. GitHub is the best, and the button in place after the `merge request` button is the `delete branch` button. They make this as seamless and painless as possible. How nice.

## Sync Local Repositories and Clean Up

Remember how we used `git fetch -p` in [Chapter 8]({{< ref "Learning Git - Chapter 8" >}}) to get changes and delete any remote branches that have been deleted in the remote repo? We can do the same with `git pull -p`.

```bash
>>> git switch main
Switched to branch 'main'
Your branch is up to date with 'origin/main'.
>>> git pull -p
From https://github.com/mr-pointing/rainbow-remote
 - [deleted]         (none)     -> origin/topic
remote: Enumerating objects: 1, done.
remote: Counting objects: 100% (1/1), done.
remote: Total 1 (delta 0), reused 0 (delta 0), pack-reused 0 (from 0)
Unpacking objects: 100% (1/1), 910 bytes | 455.00 KiB/s, done.
   1407580..7d582ce  main       -> origin/main
Updating 1407580..7d582ce
Fast-forward
 othercolors.txt | 1 +
 1 file changed, 1 insertion(+)
>>> git branch -d topic
Deleted branch topic (was 2112a22).
>>> git log
Merge: 1407580 2112a22
Author: Richard Pointing <162348169+mr-pointing@users.noreply.github.com>
Date:   Sun Jan 12 15:29:50 2025 -0500

    Merge pull request #1 from mr-pointing/topic

    Adding the color Pink

commit 2112a227cd765c744b6f60bd3694f3061ae45513
Author: mr-pointing <rpointing@blmhs.org>
Date:   Sun Jan 12 15:01:34 2025 -0500

    pink
```

We can switch over to our friend-rainbow repo, `pull` everything, and bring this project to a close.

```bash
>>> git pull
remote: Enumerating objects: 6, done.
remote: Counting objects: 100% (6/6), done.
remote: Compressing objects: 100% (3/3), done.
remote: Total 4 (delta 1), reused 3 (delta 1), pack-reused 0 (from 0)
Unpacking objects: 100% (4/4), 1.15 KiB | 295.00 KiB/s, done.
From https://github.com/mr-pointing/rainbow-remote
   1407580..7d582ce  main       -> origin/main
Updating 1407580..7d582ce
Fast-forward
 othercolors.txt | 1 +
 1 file changed, 1 insertion(+)
>>> git log
commit 7d582cecb4336fb6b1670a61cb7e9b7d4b71b271 (HEAD -> main, origin/main, origin/HEAD)
Merge: 1407580 2112a22
Author: Richard Pointing <162348169+mr-pointing@users.noreply.github.com>
Date:   Sun Jan 12 15:29:50 2025 -0500

    Merge pull request #1 from mr-pointing/topic

    Adding the color Pink

commit 2112a227cd765c744b6f60bd3694f3061ae45513
Author: mr-pointing <rpointing@blmhs.org>
Date:   Sun Jan 12 15:01:34 2025 -0500

    pink
```
