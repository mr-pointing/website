---
aliases: 
draft: false
tags:
  - computerscience
  - textbook
  - linux
title: Learning Modern Linux - Chapter 6
date: 2025-07-21
updated: 2025-08-06T10:39
---

-------------------------------------------------------------------------------

# Chapter 6: Applications, Package Management, and Containers

Like most things in computer science, the term *application* is used in a variety of different settings, and have other names that are often thought to be interchangeable (*program*, *binary*, *executable*). They are all technically different, so that's where we'll start.

We're also going to look into how Linux systems **boot**, and `systemd`. These applications also need to be accessed, and for an enjoyable seamless experience they should be easily installable. We'll look at *package managers* and how they give users the ability to install applications across different distros and platforms.

We'll finish with *containers*, how they work, and how to actually manage Linux applications. Pretty important chapter. 

We're also going to need this file. Call it `greeter.sh`;

```bash
#!/usr/bin/env bash

set -o errexit # Exits immediately if command fails
set -o errtrace # Error traps are inherited
set -o pipefail # Pipelines exit status will be the exit status of first command that fails (easier to detect errors)

name = "${1}"

if [ -s "$name" ]
then
    printf "You are awesome!\n"
else
    printf "Hello %s, you are awesome!" ${name}
fi
```

^870b64

## Basics

Apps are essential to Linux fundamental understanding, so we need to be specific with our terminology;

- **Program**: Binary file or shell script that Linux is able to run via execution. Sometimes called an *executable*. Different executable files are called differently based on their language or purpose (shell script, Python script, etc.)
- **Process**: An entity that runs from some program, loaded in main memory through the CPU or I/O. Discussed further in a previous chapter
- **Daemon**: Short for *daemon process*, sometimes called a *service*, runs in the background and accomplishes functions for other processes (printer daemon helps you print)
- **Application**: Program including any dependencies. Usually reserved for fully functioning programs with front-ends. Often will be used alongside the "lifetime" of the program, installation to deletion
- **Package**: File containing programs and a configuration intended for distribution to users
- **Package Manager**: Program that does the installation, upgrading, and removing of applications into your Linux environment
- **Supply Chain**: Producers and distributors of Linux applications
- **Booting**: Linux's startup sequence (hardware init., loading kernel, launching daemons, etc.)

## The Linux Startup Process

In order to actually get something done, we're going to need our hardware and software to get along and interact. When booting, this is exactly what's happening. It happens in 5 steps;

1. Within modern systems we start with the UEFI grabbing the boot config stored in NVRAM and defining the boot loader. In older systems, a POST test (power on self test) is made, and the BIOS sets up hardware in order to send info to the boot loader
2. The boot loader accomplishes it's one job; bootstrap the kernel. All "bootstrapping" means is starting the program in a basic form, and continuously building on top of it until it's fully functional. There are different types of boot loaders
3. Moving onto the kernel, compressed in `/boot`, needs to be extracted and loaded into main memory. The filesystem (subsystems and drivers included) are loaded and the kernel hands off the next steps to the init system. Technically, the boot process is now over
4. Within user space now, the init system launches daemons and is the root process (PID of 1)
5. The rest of user space is configured (terminal, shell, GUI, etc.)

## `systemd`

Starting off as just another init system, `systemd` ended up being involved in many different aspects of your system, from startup to logging and network functions. `systemd` allows you to define the daemons that get launched, among other things to allow for a more customized startup experience.

Many of the popular distros use `systemd`, including the distro I am currently using, Fedora. The switch to `systemd` is largely because of this open functionality across distros, among the previously mentioned features.

### Units

Units are how you control `systemd`, and tell it what to run. These units are broken down by the function it performs or the resources it uses in functioning. The most important types are

- `service units`: How to manage said service/application
- `target units`: Dependencies
- `mount units`: Mount points
- `timer units`: Timers for `cron` jobs

There are others featured in the text, but aren't super important for right now. In order for `systemd` to acknowledge a unit, a unit has to be serialized via a file; it usually looks in one of three main locations;

1. `/lib/systemd/system`: Package units
2. `/etc/systemd/system`: System admin config units
3. `/run/systemd/system`: Runtime modifications

### Management with `systemctl`

Like any other system, we need direct control over all of the processes ran by `systemd`. We can control these via `systemctl`. There are tons of commands, some you might never use. To get a feel for how to use `systemctl`, here are a few basic examples;

- `systemctl enable XXXX.service`: Enables a service
- `systemctl daemon-reload`: Reloads all unit files & re-creates dependency tree
- `systemctl start XXXX.service`: Starts a service
- `systemctl stop XXXX.service`: Stops a service

There are also commands for `restart`, `reload`, `kill`, and `status`. They work pretty much as expected. There are a few more you should be aware of if you come across them;

- `bootctl`: Lets you check boot loader status and available boot loaders (more info with `man bootctl`)
- `timedatectl`: Lets you set up time and date info
- `coredumpctl`: Enables processing of saved core dumps (useful when troubleshooting)

### Monitoring with `journalctl`

We will go over this in more detail in the next chapter. For now, all you need to know is `journalctl` is a binary file that all messages sent from `systemd` components are sent to. Think of it as the `systemd` log file.

### Example: Scheduling Greeter

Remember that greeter script we wrote before? You know, [this]({{< ref "#^870b64" >}}) one? Well, it's time to put it into action. It starts with creating a file called `greeter.service` and defining a `systemd` unit file with a type `servcice`;

```bash
[Unit]
Description=My Greeting Service

[Service]
Type=oneshot
ExecStart=/home/Code/bash/greeter.sh
```

Next, we need a `timer` unit to launch the greeter service, which is done in a new file called `greeter.timer`;

```bash
[Unit]
Description=Runs Greeting service at the top of the hour

[Timer]
OnCalendar=hourly
```

In order for this to work correctly, both of our unit files should be placed inside `/run/systemd/system`, and depending on your system you might have to manually start it using `systemctl start greeter.timer`. To check and make sure everything works, run `sudo systemctl status greeter.timer`. And since this has been mostly set up so we can see how `journalctl` works, we can check our logs with the following command; `journalctl -f -u greeter.service`, where `-f` will follow not just show, and `-u` allows for the option to pick the exact service.

## Linux Application Supply Chains

Put simply, these are the organizations and individuals creating and pushing out new or supported products. For software, this gets broken down into three areas;

1. **Software Maintainers**: Individual developers, open source projects, companies, essentially the people behind the brains of the software
2. **Repository**: The complete package of the application to be sold. This includes not only the actual app but also the metadata and library of dependencies needed for the app or service to function
3. **Tooling/Package Manager**: Standardized collection of applications, with the intent to distribute

Regardless of your distro of choice, your method of retrieving and using applications is generally the same, and will involve all parts of the supply chain.

## Package Managers

There are three main categories we should understand when it comes to package management;

1. **Traditional Package Managers**: Broken down further into high level or low level (high level can install update and remove packages)
2. **Container-based**: Come from a server and cloud computing (more later)
3. **Modern Package Managers**: Goal of ease-of-use (specifically with installing)

Usually, there are two main distro families, and their package manager of choice for each; Red Hat (Fedora, CentOS, and more) or Debian-based systems (Ubuntu, Debian, and of course, more). We should also make the obvious yet necessary distinction between the packages and the package managers, since they are completely different.

The package you retrieve should also make sense for the system you're running it on. It wouldn't make much sense to install a GUI application on a server you'll never interact or use a GUI with. 

### RPM Package Manager

Coming from the Red Hat company, these are used across many different distros. RPM itself is a low level package manager, which a few high level package managers use like, `yum`, `DNF`, and `Zypper`. These files will end with `.rpm`, making it clear were they come from. These files contain binaries or source files.

Using any package manager is relatively the same, but any differences can of course be found using their help pages (pretty much call the command with `help` or `-h` after and this will work). If we wanted to install the programming language Go using `yum`, we could find it using the command `yum search golang`, and install with `yum install golang`. After, we can verify our install with `yum info golang`. 

### Debian deb

Debian based packages, or `.deb` files, are very similar to RPM. Ubuntu is a super popular distro, and there are multiple high and low level managers that take advantage of `.deb` files, like `apt`. The text walks through using `apt`, which is incredibly similar to `yum`. 

### Language Specific

Many languages have their own package managers. Java has `maven` and `nuts`, Python has `pip` and PyPM, C and C++ have a bunch. You get the point.

## Containers

A *container* is a process group of Linux namespaces, cgroups, other optional filesystems to provide a closed environment. These can be small local testing areas, or even interconnected distributed systems ([Kubernetes](https://kubernetes.io/)). Due to the mainstream popularity of Docker in 2014, Containers have popped up everywhere and for good reasons. Being able to replicate an environment with minute detail easily without having to redo it constantly is a need many developers wish they had years ago.

To keep things tip top, standards had to be introduced, which became the Open Container Initiative or *OCI*. Three specifications had to be clear to be OCI compliant;

1. **Runtime Specification**: What needs to be done to maintain runtime (power cycle)
2. **Image Format Specification**: How the container image is constructed
3. **Distribution Specification**: How the container image is shipped and works

### Linux Namespaces

I mentioned this before, but what is a Linux namespace exactly? It is basically a system of allowing restriction on the view of resources. Since Linux is all about viewing all resources globally, restricting this can be incredibly helpful. 

Straight from the man page, "A namespace wraps a global system resource in an abstraction that makes it appear to the processes within the namespace that they have their own isolated instance of the global resource." Lot going on there, but it's not so complicated. The text reviews some of the available syscalls you can run for creating and gathering info on namespaces. You can view all namespaces on your system with `sudo lsns`.


### Linux cgroups

Where namespaces help out with resource visibility, *cgroups* help organize the process groups, and their resource usage. They show how much RAM is being used or how much CPU time is being taken. Linux maintains two versions in the kernel; v1 and v2, with v1 being supported but will eventually be overtaken by v2 which should be the prime focus.

The creation of v1 was widely inconsistent. The documentation isn't great, and things were made as they were needed without much thought of longevity. v2's intention was to rewrite all of the wrongs of v1 and keep things consistent. The controllers are specific and match with the namesake, and have clear documentation.

### Copy-on-Write Filesystems

Otherwise known as CoW Filesystems, these are systems where instead of making direct copies of files, copies are only made up of pointers to the metadata of the original file. Only upon modification, or "Writing" to the file, does portions of it get saved and a new prime version of that pointer are created. This concept saves a ton of space and is much faster. 

### Docker

Like we discussed a little earlier, Docker made running and maintaining containers even easier than ever. While you still need to worry about namespaces, cgroups, and CoW filesystems, Docker makes it incredibly easy to get up and running with very simple commands. Abstracting away most of the complexity, you need to mostly worry about two things in Docker; the *image* and *running container*.

The container image is just a compressed archive file that contains a bunch of metadata on how to set up the environment. Then, the running container is what you command, to either start, stop, kill, or remove. You interact with this docker daemon via CLI (`docker run`, `docker ps`, etc.)

Since I have a textbook on both Docker and Kubernetes, I'm going to skip their short walkthrough of setting up the greeter app as a container. It's worth the read, but there are a few things that are glossed over I'd like more detail on, so I'll just wait until I get to those other books. The text also offers some alternatives to Docker that are worth looking through.


## Modern Package Managers

Short section, but I use these enough that I thought I'd devote a sentence or too to them. There are *newer* package managers than the one's we've discussed. They take use of containers and are used all the time; things like **Snap**, **Flatpak**, and **Homebrew** are some that I use all the time whenever an application I'm looking for isn't directly on or available via traditional package managers.

## Chapter Summary

- We went over the Linux Startup Process, and how `systemd` controls and gives us control over our system
- We looked at how Linux applications are maintained via the Supply Chain and Package Managers
- We observed a few package managers, classic and modern
- Took a brief look at how Containers work and why we need them (make replicating environments easy)
## Chapter Resources

- [Link](https://systemd.io/) to more info on `systemd`
- [Analyzing the Linux boot process](https://opensource.com/article/18/1/analyzing-linux-boot-process)
- [Stages of Linux booting process - explanation, step by step tutorial](https://www.crybit.com/linux-boot-process/)
- [Linux Package Management | Linode Docs](https://www.linode.com/docs/guides/tools-reference/linux-package-management/)

---
Next: 
[Chapter 7]({{< ref "Learning Modern Linux - Chapter 7" >}}) 
