---
aliases: 
draft: false
tags:
  - computerscience
  - git
  - textbook
title: Learning Git - Chapter 1
date: 2024-08-17
updated: 2024-08-18T19:32
---

-------------------------------------------------------------------------------

# Git and the Command Line

## What is Git?

Git is a *version control* system that keeps track of the changes done to a project or directory. When you edit a file, Git records what was added and removed. If files are added or removed, Git has it's eyes on it (if you're configuring it correctly).

Git was originally created by Linus Torvalds, the creator of Linux. Meant to be used at the command line, it is clearly more complex then a simply saving a file.

---
### Book Project 1-1

Let's start building out the book project metaphor.

If we are the author of our book, and we want to work on one chapter a day throughout the week, by the end of the first week if we finished we'll have three separate commits; one commit per chapter. Each commit will contain the additions made (each new chapter).

Git also allows for a co-author: if I wanted to work on one chapter, and have a friend work on another, we could combine our work into one commit. We could also bring in an editor, that would make another commit (the editing process-removing, rephrasing, etc).

---
## GUI vs. Command Line

