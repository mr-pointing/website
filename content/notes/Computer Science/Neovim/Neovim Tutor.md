---
aliases: 
draft: false
tags:
  - computerscience
  - nvim
  - documentation
  - text_editor
title: Neovim Tutor
date: 2025-03-29
updated: 2025-04-03T19:33
---

-------------------------------------------------------------------------------

After going through [Programming in Lua]({{< ref "Programming in Lua - Chapter 1" >}}), I started watching a video series on [learning Neovim](). It really got me wanting to try out Neovim, so I started with the tutor. I'll probably just throw in a few of the most important things I learn in each chapter of the tutor.

## Chapter 1

- Moving can be done with the arrows or `h`, `j`, `k`, and `l` to move left, down, up, and right respectively
- You can open any file in Neovim with `nvim FILENAME`.
- Exiting Neovim is done with `:q!` to discard changes, and `:wq` to keep changes
- Deleting characters outside of `insert` mode can be done with hitting `x`
- Entering `insert` mode can be done by hitting `i`
	- You can append to any line by hitting `A` 
- Hitting `Esc` brings you back to `normal` mode

## Chapter 2

- The `delete` operator can be used to quickly get rid of words
	- `dw` to delete from your cursor to the next word
	- `d$` to delete from your cursor to the end of a line
	- `dd` to delete an entire line
- You can use numbers before operators to repeat operations
- `w` moves word to word by the first letter
	- `e` moves word to word by the last letter
- Change command syntax is as follows, `operator [number] motion`
- `0` moves to the beginning of a line
- Undo changes with `u`
	- Undo all changes to a line with `U`
		- Go forward in time with `Ctrl+r`

## Chapter 3

- After deleting anything, you can put it anywhere with `p`, placing it after the cursor
- Replace any character with `r` and the character you want
- `c` is the change operator; it replaces a section with putting you into `insert` mode to make changes
	- `ce` or `c#e` will delete from the cursor to the end of the word or # amount of words


## Chapter 4

- If you want to display your current line location, you can with `Ctrl+g`
	- `gg` brings your cursor to the first line
	- `#G` brings your cursor to line number # 
	- `G` brings your cursor to the end of the file
- You can search for text using `/` and text to search forward in the file
	- You search backwards using `?`
	- When searching, press `n` for the next occurrence and `N` for the previous 
- Use `%` to bring your cursor to the opening or closing of a pair of brackets
- Use `:s/old/new` to substitute the first occurrence of `old` with `new`
	- You can specify what lines you want to effect with `:#,#s`
	- You can use `:s/old/new/g` to replace an entire lines `old` with `new`
	- Use `:%s/old/new` to replace all `old` with `new`


## Chapter 5

- You can use external commands using the `!` operator;
	- `:!ls` will run `ls`
	- Usually opens it up in a smaller window 
- We can create new files easily with `:w FILENAME`, and just as easily remove it with `:!rm FILENAME`
- Traditional highlighting can be accomplished using `v` or `Visual Selection`
	- After highlighting a section of text, you can use `d` to simply delete the selection
	- You can even save and move selected text into a separate file, writing `:w FILENAME`
		- You'll notice after writing the `:`, some more characters appeared after it, `'<, '>`. I don't know why this happens, but it does let you know nicely that you are in some modifier mode
- You can retrieve and place the contents of any file using `:r FILENAME`
	- A cool trick is reading the output of external commands; you can use `:r !ls` to read in the output of `ls`

## Chapter 6

- Open is a command you can use to insert a new line under or above an existing line
	- On a line, type `o` to insert a new line under the line your cursor exists on
	- Typing `O` will do the same but above the line your cursor is on
- You can append to any line
	- `a` brings you to the end of the word of your cursor
	- `A` brings you to the end of the line your cursor is on
- A new mode, `Replace` mode, can be entered not using `r`, but `R`. It works like `Insert` mode but replaces over characters instead of inserting them into the line
- Copy using `y` and paste with `p`
	- You can use `v` to select and `y` to copy it
	- You could also use `yank` as an operator, like using `yw` to copy a word
	- `P` places before your cursor instead of after
- The `:set` operator can be used to configure other commands
	- `:set ic` ignores casing when searching
	- `:set is` shows partial matches
	- `:set hls` highlights all matching phrases
		- Use `no` in front of any of these options to switch them off
