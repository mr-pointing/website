---
aliases: 
draft: false
tags:
  - computerscience
  - git
  - textbook
title: Learning Git - Chapter 3
date: 2024-08-30
updated: 2024-09-12T16:15
---

-------------------------------------------------------------------------------


# Making  a Commit

We left off with our first text file in our working directory, our `rainbowcolors.txt` file. It has one sentence in it, and we can check that by either opening it or running `cat rainbowcolors.txt` in the working directory. We can see that we haven't made any commits yet, and we only have one untracked file. You can run `git status` to gather all of this info.


## Why Do We Make Commits?

Commits, like we learned, are snapshots of our project at a certain point of time. We obviously need to keep track of our code for numerous reasons. We could list out edge cases all day, the point is we will eventually need them for some reason.

When should we is the better question. For now, I like the adage the book uses, "Commit early, commit often." You never know what code pieces will be important until it's too late. It will be worth committing small to large steps in your project, depending on your work.


## Two Steps to Make a Commit

We can break down a commit into two easy steps:

1) Add the files you want to commit
2) Commit them with a unique identifying message

### Adding

Git has a built in add command, `git add <filename>`. You can also use multiple files by just using a space as a delimiter, or add all of the files in your working directory with `git add -A`. I thought `git add .` was similar, but that only adds revisions made from within a single directory, not the entire working directory. 

Once added, they're not live yet. They're in the *staging area*, still awaiting further instructions. The general rule is to keep commits related to each other; if you're working on one chapter in a book, you can choose to just add that chapter to a commit. No need to include other chapters if they're not ready yet.

Once added, our `index` will be created. It's a binary file, so looking at it won't really do anything. Also, let's get one thing clear, the file hasn't actually been *moved* anywhere. They still exist in the working directory, they've more or so been copied into the staging area.

### Making a Commit

When we say a **commit**, we could be referring to two things. It is both a verb *and* and a noun. The verb is when we commit something, we are saving it. When used as a noun, it represents the version of a project we're working on. 

Commit can be made using `git commit -m "<message>"`, where `message` is some indication to represent the changes in that version of the project. 

> [!Example Book Project]
> Going back to our book project, if we were committing **just** chapter 2, we would probably have a commit message like "Updating Chapter 2"

Let's actually make a commit to our rainbow project. If you haven't already, go ahead and run the command:

```bash
git add rainbowcolors.txt
```

This will prep `rainbowcolors.txt` into the staging area, and get us ready for the commit.

Once done, we can commit with a simple message about the color we added. Run the command:

```bash
git commit -m "red"
```

The output of this command should show the first seven characters of our first commit hash. The rest of the output is less important. 

```bash
>>> git commit -m "red"
[main (root-commit) f54fa77] red
 1 file changed, 1 insertion(+)
 create mode 100644 rainbowcolors.txt
```

You can see above when I ran this, my commit hash begins with `f54fa77`. We can reference our updated diagram to see what our directory looks like now:

{{< image src="/images/git_directory_diagram_WORKING.png" alt="git_directory_diagram" position="center" style="border-radius: 8px;" >}} 


Our commit represented by the commit hash and the comment is represented in our commit history. 


## Viewing a List of Commits

Thankfully, all of our commits are tracked and kept so they can always be referenced. The command `git log` will return a list in reverse chronological order of all of the commits in your project.

There are four important parts to every commit:

1. The commit hash
2. The author's name and email address
3. Date and time the commit was made
4. Commit message

```bash
>>> git log
commit f54fa770db92bbe31125032abb853f7dd6af414b (HEAD -> main)
Author: mr-pointing <rpointing@blmhs.org>
Date:   Thu Sep 12 15:59:22 2024 -0400

    red
```

Above is the output of our git history. Once we start to actually build out the project, we'll have a lot more than just one commit. Often projects will have multiple, often from multiple different people. 


---------------------------------------------------------------
Next: 
[Chapter 4]({{< ref "Learning Git - Chapter 4" >}}) 