---
aliases: 
draft: false
tags:
  - computerscience
  - git
  - textbook
title: Learning Git - Chapter 1
date: 2024-08-17
updated: 2024-08-24T12:56
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

You can interact with Git in two main ways: GUI or the command line.

PyCharm has a great user interface for their Git feature. You can do pretty much everything with your mouse. They don't bring this up but the visual example helps.

The command line is through the shell, and there's a range of commands you can use. This book will cover that aspect more than the GUI. 

In Linux, the default terminal command is `Ctrl` `Alt` `T`, and in Windows you can just type `cmd` into the search bar and hit enter.

8/24/2024

This book will mostly use the command line, since the GUI versions will likely change over time and there are numerous different providers.

The command prompt is made up of a few key elements:

- The user
- The device/host
- Location/current path
- The dollar sign/cursor set up

Cursor dictates where you'll be typing, and in most terminals it's on the same line as the prompt. When understanding examples provided by this book, anytime we are looking at the shell, the commands in **bold** are meant to symbolize commands meant to be run by the user.

However, when formatting code in Obsidian it doesn't pick up bold inside of inline code blocks. So they symbol for bold will be `**something**`.

A good first command to run when starting a Git project? `git version`. This will check the version of Git installed. The book recommend using anything greater than `2.28`. My current version is `2.43`.


## Command Options and Arguments

*Options* are just the extra parameters passed when executing a git command. These are usually denoted by a `-` or `--` before some letter. 

*Arguments* are pieces of data that feed information to the command. These are denoted with brackets, `<>`. The simple example we'll see is committing:

```bash
git commit -m "<message>"
```

This syntax tells us that to commit our git branch, we need to pass an option `-m` for message, and the `<message>` tells us where to write the commit message. Simple, but effective.

**A nice tip,** you'll find that your terminal window can get cluttered, very quickly. Especially once you start downloading packages. To clear your terminal at any point, you can just run `clear` by itself to clean your screen up. Your history isn't erased or anything, just purely a visual wipe. 


## The File System Window and Directories

Even though it would be nice and fancy to work only in your terminal, there's no real reason to do so when you're such a novice. We should start by looking at both our terminal AND our file explorer. The file explorer is another simple to use tool that visualizes your drives contents.

As you explore your file system, the *path*, as we should already know, will change depending on where you are. Just like that path changes, the path dictated by the terminal prompt can also be maneuvered. To see where you are, you can use `pwd`. To see the files that exist in your current directory (the result of `pwd`), you can use `ls`. 

A quick word on files within your directory; not all of them are visible by default. Complicated files that contain the structure of your system shouldn't be tampered with by your average everyday user. In order to see your hidden files, at least with terminal, you can add the option to ls, `ls -a`.

Now that we see where we currently exist, let's start to move around. We can change our directory using the command `cd`, "change directory". We can provide a path structure via hard code (the entire path directory by directory) or if you want to move within a directory in your current folder, you can just type that:

```bash
>>> $ cd desktop
>>> /desktop$ pwd
users/richie/desktop
```


We can also start making new directories within whatever directory we are currently in using `mkdir`. For the sake of this book's project, we can use the following command to get started:

```bash
>>> $ cd desktop
>>> /desktop$ mkdir rainbow
>>> /desktop$ ls
rainbow
```

The folder "rainbow" should now exist in the desktop. For some reason, like let's say you're using the school computers and you can't save or edit the desktop, we can always change our path to some other location where we *can* make those edits. Please let me know if you need help getting there!

If you have made the directory they said to make, you should navigate there now.


## Setting Up Git Configurations

What are Git Configurations? Essentially, global variables you'll need for any number of reasons. At any point on your machine, if you want to check and see if you have any global configuration settings, you can call `git config --global --list`.

For our project, we can start with two that we are going to want to keep track of. Our name, and our email. We can see these both up with the following syntax:

```bash
git config --global user.name "<name>"
git config --global user.email "<email>"
```

Run both of these commands from within your `rainbow` project directory. At the end, try running the command we used before to list out all of our global variables. Instead of getting an error, you should see the name and email you set.


## Using a Text Editor

This part is completely up to you, but you should be conscious of the tools available to you. If you're reading this as a Loughlin student, you have free access to JetBrain's products in the school. You should familiarize yourself with PyCharm while you can use it. Otherwise, Visual Studio will work just fine. My preference of Notepad++ is also available for free pretty much anywhere.

PyCharm is nice because it has an *integrated terminal*, which is just a fancy way of saying it comes with a terminal screen into the project you're working on. You can use that or the regular terminal if that's your preference. 


---------------------------------------------------------------
Next: 
[Chapter 2]({{< ref "Learning Git - Chapter 2" >}}) 
