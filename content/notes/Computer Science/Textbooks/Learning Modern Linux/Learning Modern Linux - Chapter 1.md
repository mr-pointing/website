---
aliases: 
draft: false
tags:
  - computerscience
  - textbook
  - linux
title: Learning Modern Linux - Chapter 1
date: 2025-05-27
updated: 2025-05-27T13:48
---

-------------------------------------------------------------------------------

# Introduction to Linux

Linux is one of the most used operating systems in the world. It's used for a wide variety of applications, and has roots that go back years. TO understand where we are at and how we got here, let's define **modern** Linux.

## What is a Modern Environment?

Put simply, these "environments" are spaces in which Linux is commonly used. These range from *mobile devices*, (Android is developed with Linux!), *cloud computing*, to *Internet of Things* (think of smart appliances or cars). We even see Linux get involved when we are *diversifying processors*. All of these spaces are heavily influenced by Linux.

## How Did We Get Here?

Linux began development by Linus Torvalds in the 1990's (August 25, 1991 to be exact) as a hobby project. The first commercial release was Red Hat Linux. In the 2000-2010's we saw a **distro war** occur, where we saw a shift in development platforms from major companies. Post 2010, most if not all commercial systems are running a Linux distro, mostly through the help of *containers*.

## Why Use Operating Systems?

There are many, many, *many* things going on behind the scenes that your computer doesn't let you see. Memory management, connecting/disconnecting to networks, just to name a few, are tasks that are handled primarily by your OS. While not *entirely necessary*, (you could just do all of that yourself!) it makes life easy to have complex tasks abstracted away.

We can give these tasks a name; *system calls*, or *syscalls*. These calls provide the user with an *Application Programming Interface* (*API*) that can help them accomplish tasks without having to worry about actually typing out and running any syscalls. One we can look at is `getuid(2)`. This is a bonafide syscall; not super important what it does in the call exactly, but `getuid()` returns the real user ID of the calling process. We can execute this syscall via the command line using the bash command `id`;

```bash
$ id --user
1000
```

## Linux Distributions

A brief definition of what we we're referring too when we say Linux, we are discussing the *Linux kernel*, or more often referred to as just the kernel, is the underlying system calls we were just discussing in the previous section. The Linux kernel has specific system calls and drivers that work in such a way that differentiate it from the rest of the OS's currently available. 

Going a step further, a *distribution* of Linux is a collection of the Linux kernel alongside other managers like the file system, the package manager, and even the shell where you type out your commands. What many people used to do is create their own (called *rolling*) distribution which is again, the Linux kernel and other applications of their choice. Now, you are spoiled for choice with many long-term distros having a huge support base. From simple (Ubuntu, Mint) to build-it-yourself (Arch) the distro world is your oyster. The most popular distros can easily be viewed via [Distro Watch](https://distrowatch.com). 

## Resource Visibility

You might have heard that everything within Linux is a file. This is true, but we can use a better term; *resources* exist in the Linux kernel and have a *global view*. We consider anything to help or aid the use of the machine as a resource (Memory, files, the CPU, etc.). We can get two of the most basic global resources; the Linux version and information on the CPU in use;

```bash
$ cat /proc/version
Linux version 6.14.6-300.fc42.x86_64 (mockbuild@d52ebe864e9b44d9a612faa06f490c58) (gcc (GCC) 15.1.1 20250425 (Red Hat 15.1.1-1), GNU ld version 2.44-3.fc42) #1 SMP PREEMPT_DYNAMIC Fri May  9 20:11:19 UTC 2025

$ cat /proc/cpuinfo | grep "model name"
model name	: AMD Ryzen AI 7 350 w/ Radeon 860M
... 15 more times ...
```

Some resources aren't important enough to be global. Take files for instance. If a user creates a private file on a device, it would be problematic if every other user had access to that file. This is where *permissions* come in, but we'll get to that later. Other resources could consider the actual processes running on your device. To see the status of the currently running process (`$$`) you could run;

```bash
$ cat /proc/$$/status | head -n6
Name:	bash
Umask:	0022
State:	S (sleeping)
Tgid:	97760
Ngid:	0
Pid:	97760
```

The `PID` field or *process ID* is set for each process in Linux. The slightly confusing point here is that **more than one process running can share a PID**. The big difference is that while they share a `PID`, they are likely being used in different contexts, or *namespaces*. Like most things introduced in this chapter, we will go into more detail later. For now, we should understand that there are global views on resources as well as a local view. Things are not global by default, and there is another term *isolation* we should be aware of that relates to how much of one resource a given process is able to use. 


---
Next: 
[Chapter 2]({{< ref "Learning Modern Linux - Chapter 2" >}}) 
