---
aliases:
  - shell
  - bash
draft: false
tags:
  - computerscience
  - youtube
  - shell
title: Become a Shell Wizard in ~12 Minutes
date: 2024-07-13
---
Modified: July 19 2024 

[Link](https://www.y/woutube.comatch?v=IYZDIhfAUM0&list=PLU-P2PlzpIf3EpWfxk-Mu_ZVJVS5Wb-_e&index=22) to video.

-------------------------------------------------------------------------------
## **The Basics of Shell** 

Shell, terminal, console, command line, all are essentially the same thing.

### **Commands**

- `ls`: lists out all items in the current (target) directory
	- You can pass some flags to change the output
	- `-latrh` will produce long list format, all files, sorted by time, in reverse, with human readable file sizes
	- You can also use a path as an argument, as well as a combination of both flags and path
- `cd`: change directory
- `pwd`: shows path to current work directory
- `echo`: lets you print some text
- `cat`: lets you print the content of a file
- `touch`: creates a file if it doesn't exist; changes the timestamp if it does
- `cp`: lets you copy a file or directory to a target destination
- `move`: like copy, but moves it instead
- `rm`: removes a file or directory
	- Need to use `-r` to delete a directory
	- You can add `f` to forcefully delete it
- `ln`: creates a symlink in a file to another location
	- Similar to a reference object in programming
- `less`: lets you view text content in a scrollable format
	- Often more useful than `cat`, since you can search easily
- `more`: less than less, but more on the screen and can only go forward
- `man`: shows the manual for the command you need
	- Similar to using `--help` after a command
	- One documentation I'd love to go through is note taking manual pages for all these commands.
- `grep`: lets you pattern match against text content
	- You can install `ripgrep` which is like `grep`, but faster
- `find`: finds a file or directory 
	- Syntax can be weird, so might be better to install `fd`, a faster easier `find`
- `sed`: a stream editor, allowing you to make changes to an incoming stream of text
	- Usually useful to find and replace text
- `awk`: allows for programming logic
	- Useful for one-liners, grabbing specific things from a file
- `sort`: sorts text content
- `head`: lets you see the first few lines of a file
- `tail`: lets you see the last few lines of a file

The pipe operator, `|`, allows you to chain commands into one another. The standard output from your first command will be fed into your second command, so on so forth.

 - `xargs`: takes the contents of whatever you pipe into it and splits it into different chunks
	 - For each chunk, it will pass it as an argument into whatever command specified

Subshell, or `$(command)`, injects the output of whatever command/pipeline you defined, placing it wherever you defined the subshell.

You can use the `>` command, or redirection operator, sends the standard output of the source file into whatever file you choose. Two greater than signs will append, not overwrite, or creates it if it doesn't exist.

 - `fzf`: a fuzzy finder. Run it by itself and you can easily search for items.
 - `compgen`: combine with `-c` to see all commands


## **Fun Commands**

Let's say we take the following command: `compgen -c | fzf | xargs man`. This will produce all available commands in a fuzzy finder, then anyone we choose will produce it's manual.  

We can take this a step further. If we use `alias`, a method of generating our own commands, and call it something like `fman`, we can write the following statement to produce a new command:

```
alias fman = 'compgen -c | fzf | xargs man'
```

Running `fman` from now on will execute the pipeline we described earlier. To make it easier, we can always make sure it's there by adding the above code to your `bash.bashrc` file, by adding the line at the end of the file.

In order to find the largest file in a directory, we can use:

```
du -ah . | sort -hr | head -n 10
```

Here, we are using `du` to get file sizes, with the `-ah` for aggregate view with human readable text. That is fed into a `sort` in reverse order, and finally, `head` to view with just 10 lines at a time.


Some helpful hotkeys:
- `ctrl+c`: kill active process
- `ctrl+k`: exit shell
- `ctrl+l`: clear screen
- `ctrl+z`: put process in background
- `ctrl+a`: go to the front of the line
- `ctrl+e`: go to the end of the line
- `ctrl+b`: go back one character
- `ctrl+f`: go forward one character
- `alt+f`: go forward one word
- `alt+b`: go back one word
- `!!`: run previous command (also known as bang bang)
- `!<cmd>`: run previous matching command
- `ctr+x ctrl+e`: open line in $EDITOR

## **Big Tips for Success**
1. Use the `man` pages (or `tldr`)
2. Use the pipelines and subshells for a good time
3. Use alias and scripts to save your work
4. Use `fzf`
