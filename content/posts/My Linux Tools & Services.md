---
aliases:
draft: false
tags:
  - linux
  - me
title: My Linux Tools & Services
date: 2026-02-27
updated: 2026-03-06T10:03
---

---

After using Linux for over a year now, I can confidently say I almost know what I'm doing. There have been many ups and downs, after going through dozens of message boards and text books. I still love this process, even if it gives me crippling anxiety when things aren't going as planned.

I'm going to go over some, if not all of the Linux specific tools I've been using along the way. I'll break them down into _major_ (used everyday, if not once a week) to _minor_ (somewhat in use or exploring their potential in my workflow). At some point I'll put my dot files on GitHub.

# Major Tools

## Tmux

Introduced by a [textbook]({{< ref "Learning Modern Linux - Chapter 1" >}}) I was going through, [tmux](https://github.com/tmux/tmux/wiki) is a terminal multiplexer, allowing for tab-like behavior in the terminal. My main terminal is [kitty](https://sw.kovidgoyal.net/kitty/) which is already full of features, but once I saw how much easier my life would get by having split terminal tabs I was hooked. I used to have three or four terminal instances open at once, that I can now condense to one window and move among my tabs with ease. Not only that, but all of my sessions are saved, so if I accidentally closed my terminal window I can open another and quickly get back to where I was. I don't need to sing it's praises; it's popular for a good reason.

## Neovim

Another incredibly popular tool, [Neovim](https://neovim.io/) is a text-editing software built using Vim-motions, a method of maneuvering and editing your files with a focus on not using the mouse. Even after setting up [LazyVim](https://www.lazyvim.org/), which allows for extremely feature-rich plugins, I feel like I've barely scratched the surface of what's possible with Neovim. There are a few shortcuts and vim-motions I've adopted into my workflow, but there are still so many I've not used that, and a couple I still don't fully understand. I've been trying to just focus on navigation which has helped a lot.

## RMPC

My main music platform, using [MPD](https://www.musicpd.org/) as a music daemon, [RMPC](https://github.com/mierak/rmpc) is terminal based music player. It looks great, somewhat easily configurable, and does what I need it to do. To get it work on my keyboard buttons for play and pause took a bit of effort, and eventually lead me to installing [mpd-mpris](https://github.com/natsukagami/mpd-mpris) to get it functioning (Framework 13!). I also installed [Cava](https://github.com/karlstav/cava) as my visualizer.

# Minor Tools

## Yazi

A terminal file explorer, [Yazi](https://yazi-rs.github.io/docs/quick-start/) is a recently recommended tool I've been trying to integrate more of. While I mostly use Neovim's Tree Explorer, or the built-in File Explorer, Yazi not only looks nice but again focuses on using the keyboard mostly, which fits into my Vim-esque endeavors.

## btop

Another terminal application (really getting into terminal work huh?) I got recently introduced to, [btop](https://github.com/aristocratos/btop) is like an upgrade to [htop](https://htop.dev/) and other task-manager like software. There's so much going on that I needed to learn a lot more about Linux in general to understand all that is going on here. I still have a decent amount I need to learn about it, but I've been trying to use it whenever I can.

## clamscan

Using ClamAV, an antivirus software, I run `clamscan` on any directories I want to check for any known viruses/malware. Whenever sailing on the seven seas, it's best to ensure all of your booty is plentiful without any unexpected visitors. Running `clamscan -r path/to/files` works best for me.

