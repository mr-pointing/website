---
aliases: 
draft: false
tags:
  - computerscience
  - html
  - css
title: Flexbox and Tables
date: 2025-01-09
updated: 2025-01-11T10:32
---

-------------------------------------------------------------------------------


When progressing through the Odin Project, I went directly into the Full Stack JavaScript path, which started with [SVGs]({{< ref "SVGs" >}}) and continues with Tables. I did see one topic I didn't remember from the beginner path; flexboxes. My HTML is rusty, so I decided to read that article before hopping into tables. I thought why not combine them, since it was a quick read.

Essentially, `flex` is a way of organizing content on a web page so that it can be uniform and behavior is expected/controlled. Actually, *any* element can be what we call a `flexbox`, which holds and organizes the content, often referred too as it's children. All you need to do is use the CSS style `display: flex;` and you'll have a `flexbox`. Below is a basic example;

```CSS
.flex-container {
  display: flex;
}

/* this selector selects all divs inside of .flex-container */
.flex-container div {
  background: gold;
  border: 4px solid purple;
  height: 100px;
  flex: 1
}
```

There isn't much about tables I don't understand, but I did find [this](https://css-tricks.com/complete-guide-table-element/) resource I found to be really helpful and clear on everything you should need to know about tables. Pretty much, only use tables when necessary.
