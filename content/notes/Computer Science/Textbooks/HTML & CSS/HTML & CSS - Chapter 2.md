---
aliases:
draft: false
tags:
  - computerscience
  - html
  - css
  - textbook
title: HTML & CSS - Chapter 2
date: 2026-01-05
updated: 2026-01-07T10:03
---

-------------------------------------------------------------------------------

# Text

We said that in the last chapter, all HTML is made up of text. Let's break that down a little further; the tags we use are called *markup*. We have two types we'll focus on in this chapter:

1. **Structural Markup**: tags that control or describe the layout of the content/text
2. **Semantic Markup**: tags that control the design of the sentences/text content provided

We'll go through a couple of different types of tags and their place in designing our web-pages.

## Structural Markup
### Headings

If you've sat through my courses on how to use Obsidian, a lot of this should be familiar. We have a way in HTML and any markup language to designate the importance of a heading based on 6 levels; `h1` through `h6` tags. The smaller the number, the larger the heading.  Best practice has us use `h1` tags for a main heading, `h2` tags for subheadings, and further tags for any more necessary cuts. Your browser has some say in how big each heading is exactly, so don't be afraid to experiment!

```html
<h1>Big heading!</h1>
<h2>Kinda big heading!</h2>
<h3>Sort big heading!</h3>
<h4>Not so big heading!</h4>
<h5>Tiny heading!</h5>
<h6>Super tiny heading!</h6>
```


### Paragraphs

The most basic tag you'll probably use the most of this year, is the basic text element tag denoted as `p`. Not much to expand upon here; to separate paragraphs, break them up in their own opening and closing tabs like the following example.

```html
<p>This is going to be a starting paragraph</p>
<p>This is an entire separate paragraph unrealated to the first</p>
<p>I love paragraphs!</p>
```


### Bold & Italic

Another staple tag, you can bold or italicize text easily using `b` and `i`, respectively. These don't really exist by themselves, they are used within other tags. You can use them by themselves, but again it goes against our best practices.

```html
<p><b>Test</b> <i>example!</i></p>
```


### Miscellaneous

These are somewhat useful, maybe a bit specific, but you should be aware they exist;

- You can add superscript with `sup`
- You can add subscript with `sub`
- You can add in manual whitespaces with `br` 
- You can add in a horizontal rule with `hr`

```html
<p>I was born on May 1<sup>st</sup>. <br> I had a severe lack of CO<sub>2</sub> in my lungs, requiring extra assisstance.</p>
<p>This side of the page is cool<hr>...while this side isn't.</p>
```


## Semantic Markup

You might think that we already looked at some semantic markup, specifically with regards to bold and italicizing. Unfortunately, this is a slight misunderstanding. One of the main reasons we use semantic markup is not to change the way the text looks, but change the way the site is interpreted. For a lot of people who use the internet this seems redundant, but there's a huge portion of the planet that interacts with the web in entirely different ways. For example, blind people get around the internet just fine, as long as the web pages are built with these disabilities in mind. When using a screen reader, it's important for people to get a sense of what's happening based on the tags you provide. 


### Strong & Emphasis

`strong` will indicate a sentence that should have a strong importance, pretty self explanatory.  `em` will provide emphasis on a part of a sentence, again the context for why will always change. However, most of the time the way it'll appear in your browser is bold and italicized, respectively. 

```html
<p><strong>Danger:</strong> This teacher is highly allergic to lame excuses!</p>

<p>I <em>think</em> that's a good idea</p>
<p>I think <em>that's</em> a good idea</p>
<p>I think that's a <em>good</em> idea</p>
```


### Quotations

There are a few different ways you can write out a quote in a web page. You could just place some quotation marks around it and call it a day, but for the sake of formatting there's another more common way of doing this. We have a tag called `blockquote`, that will format a quotation that looks nice on nearly all machines. Not only does it look nice, but it takes an attribute called `cite`, which let's you pass in a link to where you got that quotation from.

```html
<blockquote cite="https://genius.com/One-direction-night-changes-lyrics">
	<p>Does it ever drive you crazy just how fast the night changes?</p>
</blockquote>
<p>This famous lyric came from the global phenomenon, One Direction.</p>
```

### Abbreviations & Acronyms

Instead of having to write out a full acronym in your paragraphs, you can use the `abbr` tag. Pass in the full title under the `title` attribute so that when your mouse hovers over the word, the full phrase will be shown in a little box.

```html
<p><abbr title="Bishop Loughlin Memorial High School">BLMHS</abbr> is a great school to work at!</p>
```

### Miscellaneous

Again, some less used tags that may or may not be useful in your HTML adventures;

- To outline a citation, use the `cite` tag. This will generally render what's inside of it in italics
- To mark the first instance of a definition you'll use in a page, you can outline *just the word* in a `dfn` tag
- Addresses and contact information is generally placed in an `address` tag
- Underlines can be done with `ins`, and a strike-through can be done with `s`


## Summary

- HTML elements are mainly used to not only describe the structure of the content, but also provide additional semantic information


---
Next: 
[Chapter 3]({{< ref "HTML & CSS - Chapter 3" >}}) 
