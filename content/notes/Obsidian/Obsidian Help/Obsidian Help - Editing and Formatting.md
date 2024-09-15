---
aliases: 
draft: false
tags:
  - computerscience
  - obsidian
  - documentation
title: Obsidian Help - Editing and Formatting
date: 2024-09-09
updated: 2024-09-13T09:00
---

-------------------------------------------------------------------------------

# Editing and Formatting

Congratulations, after this year you'll technically know *two* languages! [Markdown](https://daringfireball.net/projects/markdown/), what we're writing in, isn't technically a programming language, but it is a useful format to understand and be able to read, just in case something isn't rendered or just browsing files. 

## Basic Formatting Syntax

A paragraph is just a block of text, separated by a newline. The paragraph for a literal example:

```
This is a paragraph. 

This is a different paragraph.
```

We talked about headings before, now let's get specific. Headings are paragraphs that start with a certain amount of hashtags. The amount of hashes correlate the the heading number, and the more hashes the smaller it is.


```
###### heading 6
##### heading 5
#### heading 4
### heading 3
## heading 2
# heading 1
```


At any point, you can make text **bold** with `Ctrl`+`B`, and *italic* with `Ctrl`+`I`, but we could also type those out:

- **Bold** can be made with two stars before and after: `**text**`
- *Italic* can be made with one star before and after: `*text*`
- ~~Strike through~~ can be done with two curly hyphens before and after: `~~text~~`
- <mark>Highlight</mark> can be done with two equal signs before and after

When referencing other notes in your vault, Obsidian will let you in two different formats. The first and easiest is Wikilink, with two square braces before and after the name: [Obsidian Help - Editing and Formatting]({{< ref "Obsidian Help - Editing and Formatting" >}}). The second is Markdown style, which is harder but can be done: [Obsidian Help - Editing and Formatting](Obsidian%20Help%20-%20Editing%20and%20Formatting.md)

External links are similar to internal links in Markdown; let's watch our local [ice spice!](https://www.tiktok.com/@shopcatsshow/video/7410532263668092190) get interviewed.



You can also change the appearance of the image by piping in a resolution: `|800x600`

Quoting is pretty easy to do as well, just add a greater than sign, `>`, before your text:

> Profound quote about something awesome I probably said once. 

\- Richard Pointing, 2024

Lists come in a few different flavors, ordered and unordered. Ordered use numbers followed by a period or close parenthesis, and unordered use a `-`, `*`, or `+` sign. You can nest your lists using `Tab`.


1. My cool list
2. Lots to list out
	1. Even here!

4) An even cooler lis
5) That's cooler than the first list

- This one has no order :(
	- Respect though
- Even though it's sequential

We could use a *task list* in order to make our lists more like to-do lists. Just add a square bracket *after* the unordered list tick.

- [ ] Make Obsidian Lesson
- [x] Don't suck as a teacher

Any of the following will create a *horizontal rule*, like so:

---
```
***
****
* * *
---
----
- - -
___
____
_ _ _
```

### Coding

This is an important section, even though it's brief. There are many instances where we'll want to grab a snippet of code we've used before. PyCharm isn't a very lite application, and can be annoying to open and rummage through your project files. This can be a nice middle ground to keep track.

You can use code *inline* with 1 backtick: `print("Hello World!")`
You can use code *blocks* with 3 backticks before and after:




```python
def myFunction(num1, num2):
	return num1 + num2
```


We can also define our code block with a specific language (we'll stick with Python for now)

## Tags

Put simply, *tags* are keywords or topics you commonly access. They begin with hashtags (except for property tags, which we'll see later).

Tags can be searched with the search bar or the *tags view* on the right hand side bar.

Tags are case sensitive. When using them, you should pay attention to the naming conventions you use. There are four standards used by most computer scientists;

1) camelCase
2) PascalCase
3) snake_case
4) kebab-case


## Callouts

*Callouts* are ways of presenting information that's necessary that might disrupt the natural flow of your note. When making a blockquote, just add a square bracket followed by the type of callout (there are a few):

1. !info
2. !note
3. !abstract, !summary, !tldr
4. !todo
5. !tip, !hint, !important
6. !success, !check, !done
7. !question, !help, !faq
8. !warning, !caution, !attention
9. !failure, !fail, !missing
10. !danger, !error
11. !bug
12. !example
13. !quote, !cite

> [!Custom Callout]
> What is the circumference of the Earth?

> [!success]
> - [x] make breakfast!

> [!bug]
> Aw nuts

## Properties

Properties can be a very powerful tool, or not used at all. If you have aspirations of creating your own website or compiling your notes content for whatever reason, I think properties make a great addition. However, if this is going to purely note taking, you might want to skip this section.

Properties can be added by placing three dashes together in the middle of the file. Once you have the table, you'll have the ability to add properties using a **key: value** relationship. 

The key can be anything you want to use. The values though have types we have to adhere too. It can be one of these 6 types;

1. Text
2. List
3. Number
4. Checkbox
5. Date
6. Date & Time

Here's a quick example of properties in source mode:

```
--- 
title: A New Hope # This is a text property 
year: 1977 
favorite: true 
cast: # This is a list property 
  - Mark Hamill
  - Harrison Ford
  - Carrie Fisher 
---
```


---------------------------------------------------------------
Next: 
[Plugins]({{< ref "Obsidian Help - Plugins" >}}) 
