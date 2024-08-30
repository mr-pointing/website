---
aliases: 
draft: false
tags:
  - computerscience
  - hugo
  - website
  - obsidian
title: Explaining my Obsidian to Hugo Workflow
date: 2024-08-27
updated: 2024-08-27T10:24
---

-------------------------------------------------------------------------------

## Where We Left Off

I was just able to get my [website](https://mrpointing.com) viewable for the first time in Hugo's draft view. I worked through the formatting errors that my Hugo theme wasn't compatible with, and everything is looking good. 

Implementing Git was also incredibly simple. If you don't know anything about Git, you can start by reading my analysis of a beginner [Git textbook]({{< ref "Learning Git - Chapter 1" >}}). Since Hugo requires you using a separate directory for content, just initialize a new repo in your directory, connect it to a GitHub repo, and you're off to the races. 

What's going to determine what shows up on your site is what's committed to your GitHub repo, so it's a good idea to make sure your content looks good before you make your commit. Considering you have (and if you haven't, you should) read my quick dive into the structure of [hugo]({{< ref "Getting Started with Hugo" >}}), you know that before committing anything to our repo, we clear out the `public` directory, call `hugo` to build our site, then use basic Git commands to push to your main branch.


## Fixing My Problems

I did have one major issue though; now that I had spent a few hours fixing and finding out all of the unique issues within my markdown files, did I want to do this procedure EVERYTIME I wanted to update my site? No thank you. Now that I'm using GitHub, if I were to use Obsidian to Hugo it would end up writing over all of the syntax I just finished editing. 

The main problems were that:
1) By default, Hugo doesn't support LaTeX inline math like Obsidian does, so using dollar signs to denote math doesn't work
2) Images are usually Excalidraw files, which are also markdown files, so Obsidian to Hugo links them like normal markdown instead of images.

I use both often enough to have this be a concern for me, So I ended up structuring my workflow like so:

{{< image src="/images/mr_pointing_workflow.png" alt="mr_pointing_workflow" position="center" style="border-radius: 8px;" >}}  

Like I mentioned in my last post, using `draft` is not only essential to using Hugo, but overall using it as an Obsidian property relieved the headache that was starting to develop. `draft` became a small check-box on the top of all of my Obsidian notes; if I know I'm going to edit it and want to post it later I'll check it to be `True`, or leave it unchecked as `False` if I don't want to transfer it over.

Since Obsidian to Hugo allows for filters, I added a filter to only grab markdown files in my vault where `draft: True` (I also added a basic `print` statement to give myself a convenient list of all the files it picked up so I don't miss any). Now I don't have to keep a running list of all the files I need to update before pushing to production, I can just let the drafts pile up, collect them at the end of the week, test, then deploy.

