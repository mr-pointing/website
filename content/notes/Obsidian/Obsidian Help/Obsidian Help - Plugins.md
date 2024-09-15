---
aliases: 
draft: false
tags:
  - computerscience
  - obsidian
  - documentation
title: Obsidian Help - Plugins
date: 2024-09-10
updated: 2024-09-15T13:11
---

-------------------------------------------------------------------------------

# Core Plugins

Out of the box, Obsidian has a plethora of usable features. Most you might never touch. Others will be ingrained in your workflow you'll forget they're plugins. This list is not extensive- like everything else, more detailed information can be found in their [documentation](https://help.obsidian.md/Plugins/Core+plugins).

## Outgoing and Backlinks

We already saw how powerful linking can be using Obsidian. Let's define two specific types of links; **outgoing links** and **backlinks**.

**Backlinks** are a collection of notes that precede a given note. A note can have as many backlinks as there are references; there is no limit. You can view backlinks by default on your right-hand side bar.

**Outgoing links** are a collection of notes that proceed a given note. You can think about it like this:

{{< image src="/images/back_and_out_links.png" alt="back_and_out_links" position="center" style="border-radius: 8px;" >}} 

## Bookmarks

Bookmarks are notes, folders, search terms, or headings you want/need to refer too often. If you know you're going to be using a note often, you can bookmark it to keep it easily accessible.

Personally, I don't use bookmarks. I only have one note that I refer too often, so I keep it pinned in my right-hand side bar. If I had a few notes to keep track of, I could see myself using a bookmark feature, but it doesn't really fit into my workflow.


## Canvas

Canvas is Obsidian's built-in visualization feature. You can lay out entire notes, and link them yourself with lines to represent said connections. You can edit things like the size, location, and visual design of your canvas to your heart's content.

The "cards" are just the content that makes up a canvas. A card can be a note, an image, or even a PDF, just to name a few. You can add cards of just text, pieces of your notes, or even media like images or videos. 

Connections between cards can be established by dragging a line from one to another. This is where the the more advanced parts of canvas come in- grouping notes together and how they relate to one another. I don't use this feature often but it's uses are there.


## Command Palette

Almost every single command that can be done in Obsidian can be found with the command palette. Hit `Ctrl`+`P` and type whatever action you want. You can pin commands that are used to the top of the palette so you don't have to type or search for them.

When browsing the command palette, you'll see on the right-hand side that some commands have hotkeys. These hotkeys are configurable through the settings.


## Daily Notes

An action that automatically creates and date a note for today's date. Super useful if Obsidian is a daily driver application. Think about your projects- writing down what you want to get done today versus what you actually accomplished. 

Through the core plugin settings, you can change the *template* used to create the new note. We'll talk later about templates, but the template for your daily note will configure what it looks like. In the settings you can also get a look at how to format date and time.


## Quick Switcher

When really in the zone and you're laser focused, taking your hands off the keyboard becomes cumbersome. I use this tool all the time. Hit `Ctrl`+`O` and start typing for a note. Once you find it, hit enter. That's it. Simple, but effective.


## Slides

If you have slides activated, you can start any note as a presentation. You have to separate each slide by a horizontal rule, `---`. It's certainly not PowerPoint or Canva, but it works as a nice substitute for flash cards.


## Templates

*Templates*, like we explained earlier, are pre-formatted markdown files that can be used for quickly applying commonly used sentences, structures, or layouts. I personally use templates on all my notes so all of my notes have the same skeleton. To use templates, you just have to point at a folder within Obsidian that you'll store them in.

You can set up a hotkey that will let you place templates in wherever your cursor is; you can even set up instructions so that every new note created within a part of your vault has it's own default template. 

Templates have some default variables you can call on that will auto-populate when you call the template. By default these are:

- `{{title}}`: returns the title of the active note
- `{{date}}`: returns todays date in the default format `YYYY-MM-DD`
- `{{time}}`: returns the current time in the default format `HH:mm`
	- Both `date` and `time` can have their formatting change by adding a semicolon after the variable like so: `{{time:YYYY-MM-DD}}`

There is no right or wrong way to use templates. Some people will use templates everyday, will others will only use them every once and a while. 