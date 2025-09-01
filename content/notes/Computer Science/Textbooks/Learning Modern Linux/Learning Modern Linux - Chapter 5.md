---
aliases: 
draft: false
tags:
  - computerscience
  - textbook
  - linux
title: Learning Modern Linux - Chapter 5
date: 2025-06-28
updated: 2025-08-12T09:12
---

-------------------------------------------------------------------------------

# Filesystems

Some would call this a dry topic, but in Linux and any UNIX based system "everything is a file", so you should understand what's going on with files. As the analogy suggests, nearly everything within the kernel is a file (with minor deviations). The *filesystem* within the kernel defines how each file is laid out.

## Basics

Most distros give each user a single filesystem tree starting at `/` or `root`. Within each tree is either a directory or file. Easily list all files with `ls`, change directories with `cd`, and print your current working directory with `cwd`. The above are so important and at first, you'll be using them pretty much all the time. Lastly, file systems are implemented in the kernel, rather than user land.

Some more advanced definitions we should be aware of;

- A *drive* is either a physical hard disk drive (HDD)/solid-state drive (SSD) or an emulated drive.
- *Partitions* are split-up segments of a drive, and *volumes* are similar but formatted for specific systems
- *Inodes* store metadata about files (size, owner, location, date, permissions). Does **not** store the filename or the actual file content
- *Super blocks* are the section in the beginning of a filesystem that captures the metadata of the filesystem

To see what drives/partitions/volumes make up your system you can use `lsblk --exclude 7`. The `--exclude 7` excludes pseudo devices. After that, you can run `findmnt -D -t nosquashfs`, which will list out the filesystem of the device minus the read-only compressed `squashfs` types. Another step down, you can find specific information about a file using `stat filename`.

Files can also be linked to one another. There are two main types of links, *Hard Links* and *Symbolic Links*. Hard links are only references to inodes, while Symbolic are actually special files with it's contents being a direct link to another file. Creating a link is easy, and we can explore the differences between the two in the following example;


```bash
$ ln something somealias
$ ln something somesoftalias
$ ls -al *alias
.rw-r--r--@ 15 richie 10 Jun 10:03 somealias
lrwxrwxrwx@  - richie  5 Jul 11:23  somesoftalias -> something
$ stat somealias
  File: somealias
  Size: 15              Blocks: 8          IO Block: 4096   regular file
Device: 0,44    Inode: 415150      Links: 2
Access: (0644/-rw-r--r--) Uid: ( 1000/  richie)   Gid: ( 1000/  richie)
$ stat somesoftalias
 File: somesoftalias -> something
  Size: 9               Blocks: 8          IO Block: 4096   symbolic link
Device: 0,44    Inode: 488644      Links: 1
Access: (0777/lrwxrwxrwx)  Uid: ( 1000/  richie)   Gid: ( 1000/  richie)
```

## Virtual File System

Linux does something really neat to be able to abstract out all of the syscalls needed to run your system and provide access to all the parts that make it up; the *Virtual File System*. This system is the main method a user will interact with files on their Linux machine. At it's deepest layer, the VFS is responsible for deciding how to read in a file. Since a file is just a string of bytes, it's the VFS's job to dictate how that file gets accessed. 

There are actually a few filesystems that exist within VFS;

- **Local filesystems**: (`ext3`, `XFS`, `FAT`, `NTFS`) drivers needed to access block devices like HDDs and SSDs
- **In-memory filesystems**: (`tmpfs`) Files that exist in RAM
- **Pseudo filesystems**: (`procfs`) also in RAM but mainly for kernel interfacing/device abstraction
- **Networked filesystems**: (`NFS`) Similar to local, but obviously via a remote device. Covered in more detail in Chapter 7

There are a ton of syscalls (at least a 100) so learning all of them is not entirely necessary. There are 5 categories we break them down into depending on what resources they're affecting;

- **Inodes**: `chmod`, `chown`, `stat`
- **Files**: `open`, `close`, `seek`, `truncate`, `read`, `write`
- **Directories**: `chdir`, `getcwd`, `link`, `unlink`, `rename`, `symlink`
- **Filesystems**: `mount`, `flush`, `chroot`
- **Others**: `nmap`, `poll`, `sync`, `flock`

As always, if you come across a command you aren't familiar with, you can run `man <command>` to get a rundown of proper use cases.

### Logical Volume Manager

One downside of partitions is that they're difficult to increase and decrease size. Like most examples, this isn't an everyday issue for a casual user. This doesn't mean that this won't happen to you some day; say you invest in a new Linux machine, and create a basic partition for all of your files. If you didn't designate enough space, getting more would be a real hassle. This is avoided by using a *Logical Volume Manager*. 

Here's the breakdown, one or more physical volumes (think again of your HDDs or SSDs, even partitions!) create a *Volume Group*. Each volume group contains one or more *Logical Volumes*, which are the actual resize-able blocks created and managed via the VG. If you were to run Arch Linux, using a LVM is heavily recommended and something even I've done before. I'd give it an easy-medium difficulty rating, considering it's just a few CLI commands.

### Creating Filesystems

Creating a new filesystem is straightforward. It takes two parts; making the filesystem and mounting it. The hardest part of the first step is choosing a filesystem format. We'll take a look at those in more detail later, but for now, we can run `mkfs -t ext4 /dev/some_vg/some_lv`. Here, we used `mkfs` to make a filesystem, told it to use the `ext4` format, and told it to create it in a logical volume.

Next, we mount it, or attach it to a filesystem tree. `mount` takes in both the device you want to attach too and where in the filesystem tree to place it. However, mounts are only active until the device turns off; in order to make them permanent, you would have to edit the `fstab` file.

### Common Filesystem Layouts

How are the files actually stored long term? This is the actual *filesystem layout*, and there is one readily put in place called the **Filesystem Hierarchy Standard** or FHS. Obviously, you don't have to follow this at all and can place files wherever you like, but for content management sake it's always best practice to stick to the protocol;

- `bin, sbin`: System programs and commands (think of `cat`, or `ls`)
- `boot`: Kernel images and related components
- `dev`: Devices like drivers and terminals
- `etc`: System configuration files
- `home`: User home directories
- `lib`: Shared system libraries
- `mnt, media`: Mount points for devices like USB sticks or portable HDDs
- `opt`: Depending on distro, package manager files usually
- `proc, sys`: Kernel interfaces
- `tmp`: Temporary files
- `usr`: User programs that are usually read only
- `var`: User program files, like logs and backups

If you don't know any of the terms above, don't worry; that's sort of the purpose of the rest of this book.

## Pseudo Filesystems

We've gone over the filesystem from the view of our base machine; just our standard machines HDD or SDD. What if we want to plug in our external SD card? That's where pseudo filesystems come in. They act like filesystems so we can interact with the content on the device without actually formatting the device. There are actually three major ones Linux has, and we're going to go through each one.

### `procfs`


Inherited from UNIX, originally mean to contain information about running processes, is the first one we'll look at. You'll find two different types of information in here mainly; per-process info with `/proc/PID` and random info on mounts, networking, memory, up-time, and more. It is honestly kind of a mess, and should be walked through slowly with things like the `man` pages as a reference.

It is most often useful when low-level debugging or developing system tooling. Here's an example of getting info on the `status` command;

```bash
$ cat /proc/self/status | head -10
Name:   cat
Umask:  0022
State:  R (running)
Tgid:   51878
Ngid:   0
Pid:    51878
PPid:   40987
TracerPid:      0
Uid:    1000    1000    1000    1000
Gid:    1000    1000    1000    1000
```


### `sysfs`

A much more structured directory, meant to help the kernel retrieve specific information about devices using a standardized layout. The directories are the same for every system;

- `block/`: Symbolic links to discovered block devices
- `bus/`: A directory for sub directories of physical bus types supported by your kernel
- `class/`: Device classes
- `dev/`: Contains a separate `block/` for block devices and `char/` for character devices on your system
- `firmware/`: Management of firmware specific attributes
- `fs/`: Sub directories for filesystems
- `module/`: Sub directories for each module loaded in your kernel

### `devfs`

This filesystem is mainly for special device files (devices being a wide range of things from physical to software). Block devices are managed here (drives), Character devices like keyboard streams, and other random Special devices like `/dev/null`, `/dev/random`, or `/dev/tty`.

## Regular Files

When talking about regular files, there's no trick here. We are talking about the regular old files we see on a daily basis; documents, text files, images, config files, you name it. These files are again, managed by a *filesystem* type.

### Common Filesystems

While there is no real term for what is a common vs an uncommon filesystem, there is a base amount that are supported right out of the gate within Linux. You can find your machine's supported filesystems by running `cat /proc/filesystems`. Let's talk about some of the most widely used;

- `ext4`: main default in most distros. Backwards compatible with `ext3`, and changes are stored using logs in a process called *journaling*, where file recovery is fast
- `XFS`: Another journaling filesystem used mostly in on workstations in the 90's, but due to it's fast IO streams and large file support it can be found in Red Hat distros
- `ZFS`: Combines a standard filesystem with a volume manager feature
- `FAT`: Mostly used for interoperability between Windows and storage devices


## Chapter Review & Resources

-  `lsblk`: List block devices
-  `fdisk`: Manage partitions
-  `blkid`: Show block attributes
-  `hwinfo`: Show hardware info
-  `file -s`: Show filesystem and partition info
-  `stat`/`df -i`/`ls -i`: Show and list inode/file-related info
-  The Virtual File System abstracts the more complex syscalls needed for file management and access to produce a human-readable format
- See existing mounts with `mount <-t specific filesystem type>`
- [Article](https://tanelpoder.com/2013/02/21/peeking-into-linux-kernel-land-using-proc-filesystem-for-quickndirty-troubleshooting/) on debugging using `/proc`

---
Next: 
[Chapter 6]({{< ref "Learning Modern Linux - Chapter 6" >}})
