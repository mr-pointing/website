---
aliases: 
draft: false
tags:
  - computerscience
  - hugo
  - obsidian
  - website
title: Starting My Website
date: 2024-08-11
updated: 2024-08-14T15:00
---

-------------------------------------------------------------------------------

As a first official post, why not start at the beginning. I want to quickly go over how I started, my motivations, and the first issues I ran into. The footnotes will reference all of the articles and videos I watched that helped contribute to how it works today. 

## Components

- Obsidian
- [Git/GitHub](https://github.com/mr-pointing/website)
- [Hugo](https://gohugo.io/)
- Cloudflare

## How I Started

Regarding Obsdian, I began writing as if I were dictating to my students. Instead of overthinking the design of the site and never making content, I just started taking notes. I started with going through a [python tutorial]({{< ref "The Python Tutorial Notes - Chapter 1, 2, and 3" >}}), and kept branching out to what it is now. The flow and structure has changed numerous times already; I'm sure in a few weeks it will be a little different. 

Most tutorials I read online start at the beginning, and show how to start with a fresh blog. Assuming you understand Hugo (and if you don't you should read the articles in the footnotes), I'm going to start right after where the quick-start leaves you.

## Making a Blog From an Existing Vault

So I tried the [tutorial](https://gohugo.io/getting-started/quick-start/) on my laptop before bringing it over to my main machine, so I started on a good note.

I set up my Hugo site to live in a directory named `/mr_pointing`, and started with the theme [hello-friend-ng](https://themes.gohugo.io/themes/hugo-theme-hello-friend-ng/). I decided to add it as a submodule, which will come back to haunt me.

I dropped my first Obsidian file in, and...it looked terrible. A lot of my files contain code, math, images, etc. I was not prepared for it to look so different. And it was still just the first file!

After some Googling I came across [Obsidian to Hugo](https://github.com/devidw/obsidian-to-hugo). This would help immensely, by taking my current markdown files and replacing the Obsidian specific syntax with Hugo syntax. Awesome, but this made me realize I had two issues to deal with. 

The first issue was simple, I had no frontmatter, or properties, so I had to add some to all of my existing 60 or so files. I used Templater, an Obsidian plugin, to create template headers with properties set, with `tags`, `title`, `date`, etc. Hugo uses the property `draft` to tell if something should be published or not. This is how I decided to start building my workflow, but we'll get back to that later. 

My second issue arose when I started making the properties; I couldn't nail how to get the date settings right. I was already having problems with using Templater's file dot method to grab the modified time and not updating (`<$ tp.file.last_modified_date %>`), which was getting frustrating. That eventually led me to using Update on Edit, another Obsidian Plugin, to add in a better last modified property. I already had `date` that works with my Theme's posting format, so I'm happy.

I should have all my problems solved right? Wrong.

Running `hugo server -D` wouldn't even start the website. I had about 30-40 errors, that ranged in difficulty. I want to do a video that goes deeper in on that, so stay tuned for that. Going over all of the little instance cases are worth it, especially if your workflow looks similar to mine. Let's cut to the chase and point out the biggest issue - Obsidian to Hugo's formatting and how it's not perfect.

I don't think this is the fault of the tool, my files weren't set up well to start with. So most of the issues came from it picking up references to notes that didn't exist, and images it couldn't reach. Turns out, the theme I'm using gives you a way to call images in the docs (it took me way too long to find that...).

After fixing all of the issues, it finally worked. I now have my site running on my local machine! Time to start on the hosting side. But first, Git.

I made my first commit to my main [repository](https://github.com/mr-pointing/website).



## Footnotes

[Cloudflare Hugo Help Page](https://developers.cloudflare.com/pages/framework-guides/deploy-a-hugo-site/).

[Mischa van der Berg](https://mischavandenburg.com/zet/articles/how-this-blog-is-created/).

[Reddit Thread](https://santacloud.dev/posts/creating-my-blog---a-developers-tale-of-over-engineering-using-obsidian-hugo-and-github-pages/).



