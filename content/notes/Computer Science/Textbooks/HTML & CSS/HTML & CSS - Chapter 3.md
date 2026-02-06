---
aliases:
draft: false
tags:
  - computerscience
  - html
  - textbook
title: HTML & CSS - Chapter 3
date: 2026-01-07
updated: 2026-01-27T10:37
---

-------------------------------------------------------------------------------

# Lists

Used nearly everyday in numerous settings, lists help organize and structure data in a neat and sequential way. There are two main types;

1. **Ordered Lists:** Where each item in the list is ordered in a specific way based on numbers; think of a recipe, or any other set of instructions.
- **Unordered Lists:** Lists that begin with a bullet point where the order of the content doesn't matter.

There's a third, not so often used type we'll quickly look at towards the end.

## Ordered Lists

Every ordered list begins with a `ol` tag, and each line in the list is encapsulated in a `li` tag.

```html
<ol>
	<li>Take out two slices of bread</li>
	<li>Use a knife to spread jelly on one side</li>
	<li>Use a knife to spread peanut butter on the other slice of bread</li>
	<li>Put both slices together and enjoy</li>
</ol>
```


## Unordered Lists

Similarly to ordered lists, unordered lists exist in an `ul` tag, and each line uses a `li` tag.

```html
<ul>
	<li>2 slices of bread</li>
	<li>Jar of peanut butter</li>
	<li>Jar of jelly</li>
	<li>1 butter knife</li>
	<li>1 plate</li>
</ul>
```

## Nested Lists

You can stack any type of lists together, as long as they're opening and closing tags are set up properly.

```html
<ol>
	<li>Gather your ingredients</li>
	<ul>
		<li>2 slices of bread</li>
		<li>Jar of peanut butter</li>
		<li>Jar of jelly</li>
		<li>1 butter knife</li>
		<li>1 plate</li>
	</ul>
	<li>Take out two slices of bread</li>
	<li>Use a knife to spread jelly on one side</li>
	<li>Use a knife to spread peanut butter on the other slice of bread</li>
	<li>Put both slices together and enjoy</li>
</ol>
```

## Definition Lists

A rarely used but somewhat useful tag is the `dl` tag, which creates a definition list. A `dt` tag contains the term being defined, and the `dd` tag contains the definition.

```html
<dl>
	<dt>Expiscate</dt>
	<dd>To find out by skill or laborious investigation</dd>
	<dt>Prudence</dt>
	<dd>Cautiousness; having good judgement</dd>
</dl>
```

# Summary

- Lists can be ordered or unordered;
	- Ordered lists use numbers
	- Unordered lists use bullet points
- Use definition lists to define words
- You can nest lists for more interesting layouts.


---
Next: 
[Chapter 4]({{< ref "HTML & CSS - Chapter 4" >}}) 
