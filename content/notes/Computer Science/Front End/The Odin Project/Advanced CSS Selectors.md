---
aliases: 
draft: false
tags:
  - computerscience
  - html
  - css
title: Advanced CSS Selectors
date: 2025-02-19
updated: 2025-02-19T18:02
---

-------------------------------------------------------------------------------

In some occasions, using classes, ID's, or types are not enough. This is about those times. There are a bunch, but we're just going to look at a few.

## Child and Sibling Combinators

Given the following:

```html
<main class="parent">
  <div class="child group1">
    <div class="grand-child group1"></div>
  </div>
  <div class="child group2">
    <div class="grand-child group2"></div>
  </div>
  <div class="child group3">
    <div class="grand-child group3"></div>
  </div>
</main>
```
<main class="parent">
  <div class="child group1">
    <div class="grand-child group1"></div>
  </div>
  <div class="child group2">
    <div class="grand-child group2"></div>
  </div>
  <div class="child group3">
    <div class="grand-child group3"></div>
  </div>
</main>

If we wanted to access all of the `div` elements inside of `main`, we can do so in a few different ways. One, would include use simply stating the element after your `main` declaration in your style sheet:

```css
main div {
	%% Some css %%
}
```

This would very simply select all of the `div` elements, regardless of their heritage or relation. You can be more specific, using the `>` operator, or the *child combinator*. Now we can access our child elements and grandchild elements independently:

```css
main > div {
	%% This will change child div elements only %%
}

main > div > div {
	%% This will change grandchild div elements only %%
}
```

You could also change adjacent elements, or elements that directly follow one. You would use the `+` sign, or the *adjacent combinator*. Had you wanted to select all siblings, you could just use `~`, or the *general sibling combinator*.


## Pseudo-classes

There are a ton of these, and they're essentially unique ways of interacting with HTML elements you otherwise wouldn't have access too in standard CSS. 

### Dynamic and User Action Pseudo-classes

- `:focus` will change the element when the user has it selected 
- `:hover` will change the element when the user's mouse is over it
- `:active` will change the element when the user clicks on it
- `:link` will change all unvisited links
	- `a:link`
- `:visited` will change all visited links
- `:root` is the head of the HTML page, and is useful for storing global CSS styles
	- `box-sizing: border-box;`


### Pseudo-elements

Another way to interact with our HMTL elements, and actually affect parts of of our HTML that aren't elements at all. Weird, so let's see some examples;

- `::marker` usefully will affect the indicator of your list bullets for `<li>` elements
- `::first-letter` and `::first-line` affect the first letter and line of a given element
- `::selection` changes the highlighting of text when the user highlights it
- `::before` and `::after` place extra elements in front or after
	- `p::before { }`

## Attribute Selectors

To review, attributes are the opening parameters passed to an element upon creation (`href`, `src`, etc). We can do this in three ways:

1. `[attribute]`: affect all instances where `attribute` is used
2. `selector[attribute]`: affect only instances where `attribute` is used with associated `selector`
3. `[attribute="value"]`: to target only attributes that have a specific name


The last one can get incredibly specific, as we can use wildcard operators to grab a few different item names at once:

1. `[attribute^="value"]` will match strings only from the start
2. `[attribute$="value"]` will match strings only from the end
3. `[attribute*="value"]` will match anywhere in the given string

[CSS Diner](https://flukeout.github.io/) is a great way to test your skills with CSS and see if you retained the info you read through.