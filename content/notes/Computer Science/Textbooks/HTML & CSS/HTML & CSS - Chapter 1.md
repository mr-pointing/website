---
aliases:
draft: false
tags:
  - computerscience
  - html
  - css
  - textbook
title: HTML & CSS - Chapter 1
date: 2025-10-13
updated: 2025-10-13T21:07
---

-------------------------------------------------------------------------------


# Structure

What do we make websites for? Mostly for online resources of physical things we need and look for in our daily lives. A main component of everything we use and consume is *structured*. The structure of our web page takes on many forms, but for now let's focus on the most basic type; the building blocks that construct almost every web page. 

When thinking about how we should structure our pages, we can always take a look at real life examples in print media for what you're looking for. In it's most basic form, something like a newspaper, we have a title, heading or two, and sub-paragraphs with images or quotes. That's a great place for us to start.

Here's a really basic example of some HTML;

```html
<html>
  <head>
    <title>Your first web page</title>
  </head>
  <body>
    <h1>Main heading</h1>
    <p>Intro text to talk about some stuff</p>
    <h2>A sub heading</h2>
    <p>Some text for the first sub heading</p>
    <h2>Maybe another sub heading</h2>
    <p>You just never know how many you need</p>
  </body>
</html>
```

Notice the color difference in the text? That's called *syntax highlighting*; `<html>` and the rest are reserved HTML *elements*, with opening and closing *tags*. Think of tags like containers. Some tags contain multiple tags inside of them, while some contain just text. Some have just basic information. Sometimes, a tag will have something we call an *attribute*, which gives an element some more information for any number of reasons. The basic rule is that even though some tags may act differently, every opening needs a closing. 

Three good tags to always start any page is a **head, body, & title**. The `<head>` element acts like the header of a document. It mostly contains metadata about a page, or information not usually seen. Inside there is the `<title>` element, which gives the web page it's name. Then the `<body>` element takes in the rest of the content that gets displayed. When building web pages, we should always think about it as designing how we display and format text boxes.

Copy and paste the above code into a new text file into a Notepad++ document. Then, save the file as a `.html` file. Then, you can open it in any web browser you want. Super nifty.