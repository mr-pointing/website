---
aliases:
draft: false
tags:
  - computerscience
  - css
  - textbook
title: HTML & CSS - Chapter 10
date: 2026-03-04
updated: 2026-03-06T11:51
---

-------------------------------------------------------------------------------

# Introducing CSS

The moment we've all been waiting for, the chapter on CSS. As we've seen, the HTML language is efficient but not very pretty. After the next few chapters, you'll have a good sense of how to implement design changes to make your pages more appealing. The hard part is not learning CSS; people rarely memorize it or it's nuances. Rather, the hard part is learning *good* design. Unfortunately, that cannot be taught as much as it must be acquired by self study. I can show you good and bad, but it's going to take practice to understand how certain attributes work and which are the best to use. Google searches are a must, as people have been using CSS for nearly 30 years, giving you a lot of options for resources.

## Understanding the Layout

Around each HTML element exists a box. Depending on what type of element it is, block level or inline, will determine what the box looks like. What CSS is doing underneath the hood is changing the attributes and design of the box and contents inside the box. We can change the boxes shape, change how it interacts with other boxes, how it formats the content inside of it, change the color of the border or background of that box. There's a ton we can do, depending on which box we're editing.

We have two parts to a stylesheet; a **selector** and a **declaration**. The *selector* chooses the elements you'll be changing, and the *declaration* is the changes being made. Within the declaration, there exists the *property*, or what attributes of the element you want to change, and the *value*, or what the actual change will be determined by. If it sounds confusing, take a look at a super basic stylesheet;

```css
p {
	font-family: Arial;
}

h1, h2, h3 {
	font-family: Arial;
	color: purple;
}
```

Generally, we want to keep our styles inside a stylesheet, to keep things nice and organized. That being said, we have to tell our HTML file to go get those styles if they aren't written directly into the file;

```html
<!DOCTYPE html>
<html>
	<head>
		<link href="css/styles.css" rel="stylesheet" />
	</head>
	<body>
		<h1>First CSS Page</h1>
		<p>I hope it looks good...</p>
	</body>
</html>
```

## Selectors

Probably the most confusing portion of CSS, let's do a quick deep dive into how selectors actually work. We have a couple of different ways of using selectors;

- **Universal Selectors:** Applies to all elements in a document
	- `* {}`
- **Type Selectors:** Matches element names
	- `h1, h2, h3 {}`
- **Class Selectors:** Matches elements whose `class` attribute matches the one selected
	- `.example {}`
	- `p.other_example {}`
- **ID Selectors:** Matches element whose `id` attribute matches the one selected
	- `#example {}`
- **Child Selectors:** Matches elements that is a direct child of another
	- `li>a {}`
		- Targets any `a` elements that are children of an `li` element but no other `a` elements on the page
- **Descendant Selector:** Matches an element that is a descendent of another specified element
	- `p a {}`
		- Targets any `a` elements that sit inside a `p` element regardless of how many other elements are between them

## The C in CSS

Our rules *cascade*, or take precedence over one another depending on your structure. Let's take the following as an example;

```html
<h1>Potatoes</h1>
<p id="intro">There are <i>dozens</i> of different <b>potato</b> varieties.</p>
<p>They are usually described as early, second early and maincrop potatoes.</p>
```

```css
* {
	font-family: Arial, Verdana, sans-serif;  
}
h1 {
	font-family: "Courier New", monospace;
}
i {
	color: green;
}
i {
	color: red;
}
b { 
	color: pink;
}
p b {
	color: blue !important; 
}
p b {
	color: violet;
}
p#intro {
	font-size: 100%;
}
p {
	font-size: 75%
}
```

Some things to help us understand why the above styles are working the way they do. CSS follows a *last rule* system, meaning the last or more recent line will take precedence over the lines before it. Not only that, but if one selector is more specific than others, that more specific rule will take precedence. For the above example, we would consider `h1` more specific than `*`, `p b` as more specific than just `p`, and `p#intro` more than `p`. Another trick used above is the `!important` tag, which will tell CSS that that specific element is more specific than others. 

## Inheritance

CSS also has the concept of inheritance inside of it. Meaning, if you pass styles into something like a `body` selector, most if not all elements inside of the `body` will be affected. Not all elements and attributes work like this, but most do. You can force inheritance by using the `inherit` attribute, like in the following example;

```css
body {
	font-family: Arial, Verdana, sans-serif;
	color: #665544;
	padding: 10px;
}
.page {
	border: 1px solid #665544;
	background-color: #efefef;
	padding: inherit;
}
```

The last thing I'll bring up is my favorite game to teach you about how CSS selectors work; [CSS Diner!](https://flukeout.github.io/). Really fun and relatively easy to get started with, I often use this as a quick refresher whenever I have a project I've been working on that I need to use CSS in.

# Summary

- CSS tells HTML how to change and manipulate the elements on a given page
- Stylesheets can be internal, but ***should*** but external
- Rules are made up of selectors and declarations
- Different types of selectors affect elements in different ways
- Declarations are made up of properties and values


---
Next: 
[Chapter 11]({{< ref "HTML & CSS - Chapter 11" >}}) 
