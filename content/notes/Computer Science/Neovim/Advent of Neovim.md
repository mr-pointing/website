---
aliases: 
draft: false
tags:
  - computerscience
  - nvim
  - text_editor
title: Advent of Neovim
date: 2025-04-10
updated: 2025-04-24T10:05
---

-------------------------------------------------------------------------------


I found myself using the [Neovim Tutor]({{< ref "Neovim Tutor" >}}) note quite often, so I wanted to also document the other tips and tricks I pick up along the way of watching TJ's videos. For now, I'll keep all the videos here separated by headings.

## Lazy.nvim Explained

- To open up a new tab, write `:new`
- Not sure how to switch yet, but any new commands will open in the second area
	- Use `:q` to go back to just one
- Use `:e .` to open a file manager
- Use `:echo nvim_list_runtime_paths()` to list run time paths (lol)

## Configuring More Neovim Options

- Set `vim.opt.shiftwidth` to a number to set spaces used after carriage return
- Use the `/after/ftplugin/` directory to store `.lua` files for each language you want local options for. 
	- For Lua, we probably want to make a `lua.lua` file and set `vim.opt_local.shiftwidth = 2`
- To set numbers on the left hand side and the relative position, use;
	- `vim.opt.number = true`
	- `vim.opt.relativenumber = true`
- A neat trick he does in the local files is use the following to make things nicer to read/write;

```lua
local set = vim.opt_local

set.shiftwidth = 2
set.number = true
```

## Treesitter Basics

- `vim.opt.clipboard = "unnamedplus"` allows for pasting into Neovim

## LSP in Neovim

- =g to format a file
- `K` for a hover over a function
- `Ctrl+]` to find the root of a function/variable/path/etc.
- `grn` to rename all instances of a name
	- `:help lsp` for more info on these

## Telescope Introduction

- You can use `Ctrl+/` to bring up the movement guide while in a telescope window
	- `Ctrl+n` to move forward, `Ctrl-p` to move backwards