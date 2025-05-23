---
aliases: 
draft: false
tags:
  - computerscience
  - linux
  - youtube
  - project
title: Arch Linux on Virtual Machine
date: 2024-12-09
updated: 2024-12-09T17:34
---

-------------------------------------------------------------------------------

After running my laptop on Ubuntu for the past 4 months (and enjoying it) I figured it was time to give some other distros a chance. One of the YouTube channels I watch in order to expand my horizons is [Mischa van den Burg](https://www.youtube.com/@mischavandenburg) who specializes in cloud computing dev ops things. I've watched a ton of his videos and got inspired to learn more about dev ops mostly through his influence. 

I did a combination of things to prep for this;

- I watched about halfway through his [tutorial](https://www.youtube.com/watch?v=qboMuv9vSpQ&list=PL_JVnPgp2IRcFnHqZdmQwWdv8n49vGHqp&index=2) on installing Arch to get a feel for how much it would require (seems pretty simple for 3 episodes in)
- Had a convo with [ChatGPT](https://chatgpt.com/share/674b6a86-8540-8002-a7bc-8a6d8b3ef536) on exactly how to use his method on a virtual machine
- Followed along with the Arch Wiki pages ([Install Guide](https://wiki.archlinux.org/title/Installation_guide), [Installing on LVM](https://wiki.archlinux.org/title/Install_Arch_Linux_on_LVM), and [Encryption on LVM](https://wiki.archlinux.org/title/Dm-crypt/Encrypting_an_entire_system#LVM_on_LUKS))

Each video is an hour long, which seemed a bit overkill since you can watch a guy install arch [everyday](https://www.youtube.com/watch?v=nXdyb8y6PnE) and it takes him about 6 minutes. These videos are lengthy since he covers them in detail, and took the approach of covering a really useful system of managing system storage, LVM. 

I had never considered that with a built-in system, memory allocation would be something I had a variety of options for. Just based off the acronym I wouldn't have even considered LVM due to it sounding harder, yet not only is it not that difficult to understand, it seems more scalable than the other options they gave. Essentially, you can allocate a base size for storage, and you can go back and size up or size down depending on your system. Apparently this is not possible in other memory management systems. Sizing down also is more difficult than sizing up.

Well, after working on this for like over a week, I somehow broke my start lol. I saw breifly it's trying to find my UUID that I unfortunately misspelled. I think I'm going to take a short break from this, mostly because I'm so frustrated such a small error cost me so much time and effort. Not in the best headspace to make the most of this not so great experience, so I'm going to walk away for a bit.

I FIXED IT. When spamming delete upon machine restart, I pressed `e` on my Arch Linux boot and was able to edit the file. Now it works just fine :'). I did have to go in a bit more and change the actual UUID in the `visudo` file, as well as actually point out my `/boot` partition in the `fstab` directory. Then it restarted no problem. 
