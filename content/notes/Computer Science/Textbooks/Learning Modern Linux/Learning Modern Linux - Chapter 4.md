---
aliases: 
draft: false
tags:
  - computerscience
  - linux
  - textbook
title: Learning Modern Linux - Chapter 4
date: 2025-06-16
updated: 2025-08-05T10:02
---

---

# Access Control

Like most things in the world, access is a means of collateral control. There are certain parts of your system you _wouldn't_ want anyone to touch (think of your network settings or startup settings). Let's discuss the means of enforcing access control, how files are ran, and some advanced Linux features for controlling your environment.

## Basics

Linux has the ability to have multiple users running on one machine. Each user has a given ID and certain _permissions_ that dictate what that user is capable of. Users own _resources_, or just files, and launch **processes**, which use files through a user.

This is a simplified version of it, and this is all we need for right now. We should also bring up _sandboxing_, or the managing of a secured space in which processes can be run without outside influence. Think of virtual machines or containers. If that doesn't ring a bell, we'll talk more in detail about this later.

The first expansion of our simplified example is how an access even happens. There are many ways and configurations, but there are two we should discuss directly; **Discretionary Access Control** and **Mandatory Access Control**. DAC controls allow users to pass on permissions that are qualified for, while MAC has security levels that are set up by an administrator and are _only_ set by an administrator. Regardless, Linux does follow an "all-or-nothing" attitude; you are a superuser or you're not. (You'll often see you have to use `sudo` to pass admin privileges to certain commands).

## Users

There are two types of users in Linux; _system users_ and _regular users_. Regular users are the types of accounts are exactly what they sound like, the accounts any regular person would create and use to interact with the kernel through the shell. The system users are actually used by programs either for the operating system or something like networking, to facilitate background processes. Some are even used in the front end for things like database management.

The breakup between them are more for organization. The way they're managed is through a **UID**, or user ID. Within ID's are groups that are determined by the system. A `systemd`-powered distro (we'll talk about that later) follow this layout;

- UID 0 = `root`
  - `root` is a superuser that can accomplish any task on the system. **_NOT_** a good idea to do major (even minor) things as `root`
- UID 1 -> 999 = System users
- UID 65534 = `nobody`
  - Used in networking
- UID 1000 -> 65533 and 65536 -> 4294967294 = Regular users

You can always look up your own UID with `id -u` in the shell.

### Managing Users Locally

The most traditional way of doing it, users data exist in their designated files only. All user management data exists within four files;

1. `/etc/passwd`: The user database
   - Usernames, UIDs, group membership, home directory, login shell
2. `/etc/group`: The group database
3. `/etc/shadow`: The user passwords
4. `/etc/gshadow`: The group passwords

Use `cat /etc/passwd` to see all your systems users;

```bash
$ cat /etc/passwd
...
richie:x:1000:1000:Richie:/home/richie:/bin/bash
nobody:x:65534:65534:Kernel Overflow User:/:/usr/sbin/nologin
systemd-network:x:192:192:systemd Network Management:/:/usr/bin/nologin
```

The syntax of the output is the following:

```bash
<username>:<users password>:<UID>:<GID>:<GECOS field>:<home directory>:<login shell>
```

A few notes about the syntax; the way you could easily tell what is a system and regular user is their login shell. In the above example, I grabbed a few from the very long list of accounts. The two accounts not only have UIDs in the ranges we discussed previously, but also end with `nologin`, indicating their status.

The `GECOS` field usually contains quick contact information about the process or a description of it's purpose. You'll also notice the passwords for all have an `x`. That's because their encoded and stored in `/etc/shadow`. Usually only the `root` user can actually read the `shadow` file.

If you want to add a user, it's really easy;

```bash
$ sudo adduser rp_test
```

The text has options that follow after this command, but while using Fedora I wasn't given the option. To create a system account you can pass in `-r`, but you can obviously find the entire list of options using `-h` or `man adduser`.

To see all groups, run;

```bash
$ cat /etc/group
```

### Centralized User Management

A very quick point, but there is another type of user management. If you had to manage multiple user accounts across multiple machines, doing it all locally is a lot of work. You can accomplish this type of management with the following options;

- **Directory Based**: Running an LDAP (lightweight directory access protocol) server either yourself or through a service
- **Network Based**: We'll walk through this using _Kerberos_ later
- **Config Management Systems**: Systems like Ansible, Puppet, or Saltstack

## Permissions

Permissions are broken down into two types; _File Permissions_ and _Process Permissions_. One at a time! File permissions get broken down even further into three types of scope for permissions;

1. **User**: File owner
2. **Group**: One or more members specifically designated
3. **Other**: Everyone else

It gets broken down _again_ when we define the types of access;

1. **Read or `r`**: Allows user to view contents of a file or contents of a directory
2. **Write or `w`**: Allows a user to modify and delete a file or create, rename, or delete files within a directory
3. **Execute or `x`**: Allows a user to execute a file as long as they also have read permissions, or allows a user to access information on files within a directory, allowing commands like `cd` or `ls` on it

```bash
$ ls -al
drwxr-xr-x@  - richie  9 Jun 18:16  .
drwx------@  - richie 26 Jun 14:01  ..
drwxr-xr-x@  - richie 16 Jun 12:39  bash
drwxr-xr-x@  - richie 23 Jun 12:02  cap_pokes
drwxr-xr-x@  - richie 10 Jun 12:48  lua
drwxr-xr-x@  - richie 25 May 20:06  models
drwxr-xr-x@  - richie 20 May 20:34  mr-pointing
drwxr-xr-x@  - richie 15 May 20:48  python
.rw-r--r--@ 41 richie 20 May 12:54  skeys.txt
```

The first character is the _file type_. In my system, a regular file is a `.`, a directory is `d`, symbolic link is `l`, and there are some others we might come across that I'll point out if important enough. The next section are the permissions repeated three times for each group. the existence of the letter means that group has that permission. For example, in the file `skeys.txt`, the User group has read and write permissions, but no executable permissions. Not only that, but the Group and Other groups also can read the file.

You can also use a numerical representation, sometimes called decimal, to set up permissions. For example; `400` is read only by owner, while `755` is full access for owner with read and execute for everyone else. We can change permissions using `chmod`. Let's say I wanted to make my `skeys.txt` file executable;

```bash
$ chmod +x skeys.txt
```

This will give executable permissions for all groups, unless specified otherwise. You can also use `chown` to change ownership of a file, or `chgrp` to change the group.

Time to talk about process permissions. The makeup of a processes permissions on a given file is similar and simple;

1. **Real ID**: UID of the user who launched the process
2. **Effective UID**: Used to determine permissions the process has when accessing shared resources
3. **Saved set-user-ID**: Used in `suid` cases where a process gains privileges by switching it's effective UID between the real UID and saved set-user-ID (explored later in _Ports_)
4. **Filesystem UID**: Linux specific IDS used for determining permissions for file access. Not normally touched by programs, even the kernel only keeps track of the effective UID and when is changed and replaces it with the filesystem UID. They can be the same but not in all cases.

Here's a good example of what's happening here; let's say you have a UID of 1000 and you run the command `passwd`. Since `passwd` has `suid` enabled, your effective UID is changed from 1000 to 0 or `root`.

### Advanced Permission Management

While some of this is rather dense for most users, it's still important if you were to ever venture into a professional position in a UNIX workspace. To continue on with more concepts, the Linux kernel's perception of running processes comes in two forms; privileged and unprivileged. Any privileged process has an effective UID of 0 or the `root` user, and everything else is unprivileged.

This _was_ the case, but actually changed in the Linux kernel version 2.2, and now `root` privileges are assigned via units given on a per-thread level, called _capabilities_. You get to add these capabilities to files at your own discretion. These allow a much more "fine-grained" approach to permissions.

One interesting technique is to run _Secure computing mode_, or `seccomp`. This is a Linux kernel feature allowing you to restrict the syscalls an process has access too. Not only is this ability able to be tinkered with manually, but most containers support `seccomp`.

## Good Practices

To wrap things up, let's look at some best practices you should be aware of;

1. Least Privileges
   - A person/process should only have necessary permissions to accomplish designated tasks (if an app doesn't need to write, it should just read)
   - Avoid running as root (mentioned above!)
2. Avoid `setuid`
   - Use capabilities instead! (`getcap` and `setcap`)
1. Auditing is a good idea
   - We'll get more into this in Chapter 8

## Chapter Resources

- [Setting up Capabilities](https://blog.container-solutions.com/linux-capabilities-in-practice)
- [seccomp Overview](https://lwn.net/Articles/656307/)
- [Intro to Access Control Lists](https://www.redhat.com/en/blog/linux-access-control-lists)


---
Next: 
[Chapter 5]({{< ref "Learning Modern Linux - Chapter 5" >}}) 
