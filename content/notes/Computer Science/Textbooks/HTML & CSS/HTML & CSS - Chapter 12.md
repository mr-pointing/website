---
aliases:
draft: false
tags:
  - computerscience
  - css
  - textbook
title: HTML & CSS - Chapter 12
date: 2026-03-13
updated: 2026-03-18T12:02
---

-------------------------------------------------------------------------------
# Text

Easily what makes up 90% or more of every web page ever, text is integral to the design of a page. Not just text, but using text with the proper font, size, and spacing is everything. In this chapter, we'll take a look at some text terminology, how to edit and format our text, as well as address some best practice uses of text manipulation.

## Terminology

Before we get into editing, we need to understand some terms that will help us make better decisions. First up, we need to understand that different fonts use a different *typeface*, or the details of the font. We consider a **serif** font to have extra details at the ends of the main strokes of your letter; **sans-serif** as main strokes without extra flair, and **monospace**, where the each character of the font is the same width.

Serif fonts are traditionally easier to read when reading text from a book or article, AKA in real life. However, with the advancement of technology and screens taking up a larger portion of our reading time, sans-serif is considered the better option for reading on screens. Our last option, monospace, is best used when writing things like code.

Font's can also have a weight, style, and stretch. The weight of your font determines how thick the characters are, while the style affects how italicized the font is, and finally stretch determines how close or far apart the characters are.

## Choosing a Typeface

We already established the different use cases for each type of font, but there's still more to it than that. First of all, you can't even *use* a font unless it's either installed on the computing device, or borrowed (we'll get into that in a second). There are some generally accepted fonts that are on most devices, like in the table below;

| Serif           | Sans-Serif | Monospace   | Cursive          | Fantasy         |
| --------------- | ---------- | ----------- | ---------------- | --------------- |
| Georgia         | Arial      | Courier     | Comic Sans Ms    | Impact          |
| Times           | Verdana    | Courier New | Monotype Corsiva | Haettenshweiler |
| Times New Roman | Helvetica  |             |                  |                 |
Sometimes, certain browsers support only certain fonts while leaving out others. If you are using a font, and a user tries to view it but doesn't have that font installed, they'll likely see it in the default font of Times New Roman. This is why wed developers will commonly use what is called a *font-stack*, or a list of fonts so if one isn't supported, the next in line will be called on. Here's an example of a font-stack for a serif font;

```css
p {
	font-family: Georgia, Times, serif;
}
```

As you can see, we use the `font-family` property to tell CSS to change the text for any `p` element on our page. One other note we should be aware of is if the font name is more than one word, you should use quotation marks to enclose it. Try to keep your selection of typefaces to 3 and under.

Another attribute you can change is `font-size`, which will do exactly what you think; change the size of the font. But how do we use it? Well, there are a few ways. One method we can pass are pixels, which will offer precise control over exactly how big your text will be. Another method is a little more complex, is percentage. By default, your browser will display text at 16px, or 16 pixels. By passing a percentage will change that default number by said percent; 75% is 12px, and 200% is 32px.

There is a third, also used measurement of text called Ems. Using `em` allows you to change the size of an element relative to the size of text in the parent element. Here's a small table on exactly how the conversions work;

| Pixels       | Percentages  | EMS           |     |
| ------------ | ------------ | ------------- | --- |
| `h1`: 32px   | `h1`: 200%   | `h1`: 2em     |     |
| `h2`: 24px   | `h2`: 150%   | `h2`: 1.5em   |     |
| `h3`: 18px   | `h3`: 133%   | `h3`: 1.125em |     |
| `body`: 16px | `body`: 100% | `body`: 100%  |     |
|              |              | `p`: 1em      |     |

If it's not on your device, you'll have to tell CSS where it can go get it. We do that by specifying a `@font-face` selector, and provide a link to the file. You by default should have two things when trying to create a new `@font-face`; a `font-family` for the name of the font, and a `src` to provide a path to the font file. Most fonts can be found are only free for personal use, meaning if you wanted to sell or make a commercial website you'd have to pay to use their font. One of my favorite websites to find free fonts is to use [DaFont](https://www.dafont.com/), or you can use [Google Fonts](https://fonts.google.com/), which work a little differently and have you just use a link n your CSS file or `head` tag to bring it in.

```css
@font-face {
	font-family: 'ChunkFiveRegular';
	src: url('fonts/chunkfive.eot');
}
h1, h2 {
	font-family: ChunkFiveRegular, Georgia, serif;
}
```

## Transformations

Let's go over a few different ways we can make some changes to the appearance to our text. We already know that certain tags can give us what we need, like the `b` or `i` tag for bold and italicize, respectively. However, sometimes we want to overwrite the rules of existing elements. What if we wanted to give all of a certain `class` or `id` a bold or italicize without having to change our HTML? We can accomplish this with `font-weight` and `font-style`. We can pass in `font-weight: bold;` for bold text, and `font-style: italic;` or `oblique;` for italicized text.

Sometimes, we want all of our content to be uniform, or similar in some regard. What if we wanted all of our casing to be the same; all upper-case, lower-cased, or capitalized on each first character of each word? That becomes trivial with the use of the `text-transform` property. You can pass in `uppercase`, `lowercase`, or `capitalize` to achieve the three styles we just discussed. 

One that's used a lot, especially when working with links, is `text-decoration`. You can use `text-decoration: underline;` to produce an underline effect on your text, but that's not all. You can also pass in an `overline` which goes over your text, a `line-through` which adds a line through the text, and a `blink`, which flickers the words off and on but is never used due to it being extremely annoying.

## Text Spacing

Spacing on a page is so crucial, so important, that I have a good feeling a lot of issues you run into when designing your portfolios will be a spacing issue. Before we take a deep dive on how the spacing of our elements work (next chapter!), let's see how we can change our text's spacing. First up is the `line-height` property, which affects the height of each line of text, otherwise known as the *leading*. Increasing it from your default value will increase the space among the lines, while going down will produce the opposite affect. This can overall increase the readability of your page, but use caution; too much spacing and it goes back to being hard to read. The best option if default isn't your jam is 1.4 em or 1.5 em.

We also might want to change the spacing between our characters, known as *kerning*. This is best increased in titles, specifically when using all capital letters. If you change the kerning in regular text, it can actually increase the difficulty of reading said text. We can set `letter-spacing: 0.2em;` as an example, which will lightly kern the letters in an assigned element. You can also change the space between words using `word-spacing`, but the use for this is so light you likely won't have to make any changes to it.

One thing you will definitely want to change is the alignment of your text. We should have noticed that up until this point, the default behavior of our text is to remain left-justified, and go up until the box of your element then wrap under to the next line. We can start to adjust this by changing the `text-align` and `vertical-align` properties. `text-align` will change the justification; you can pass `left`, `right`, `center`, or `justify` to fill the entire box save for the last sentence. 

`vertical-align` is kind of weird; it doesn't really change whether or not your text is vertically aligned in the middle of your element, more so used with inline elements to help text placement. You can pass in `baseline`, `sub`, `super`, `top`, `text-top`, `middle`, `bottom`, or `text-bottom`. This one will take some getting used to, so use the example below to play around with it.

```css
/* text alignment */
h1 {
	text-align: left;
}
p {
	text-align: justify;
}
.credits {
	text-align: right;
}

/* vertical alignment */
#six-months {
	vertical-align: text-top;
}
#one-year {
	vertical-align: baseline;
}
#two-years {
	vertical-align: text-bottom;
}
```

We're at the end, so let's rapid fire some of the last few concepts that aren't as important but you might find useful in your endeavors. You can indent the first line of text within a given element using the `text-indent` with a pixel amount. You can add a drop shadow behind your text with `text-shadow`. It takes 4 parameters; first number tells the text shadow how far to the left it should go, the second number dictates how far to the right, the third number is optional that decides how blurred the drop shadow should be, and the final parameter is the color of the drop shadow text.

```css
p.example {
	background-color: #cccccc;
	color: #ffffff;
	text-shadow: 2px 2px 7px #111111;
}
```


## Pseudo Elements

There are cool effects built into CSS you can use without having to think up anything fancy, and call them you apply what we call a `pseudo-element`. These are placed after the element, as you will see in the example below. If you are interested in only changing the first letter or sentence of a given element, you use `:first-letter` or `:first-line`, respectively. You can also style how your page handles links with `:link` and `:visited`. To add in hover effects, use `:hover`. If you want to make something change when used like a button, use `:active`. And lastly, if you want something to change when given *focus*, or when your browser interacts with it for typing or input, use `:focus`. Obviously, the example will only have CSS. Try to build out the HTML yourself if we didn't together during class.


```css
p.intro:first-letter {
	font-size: 200%;
}
p.intro:first-line {
	font-weight: bold;
}
a:link {
	color: deeppink;
	text-decoration: none;
}
a:visited {
	color: black;
}
a:hover {
	color: deeppink;
	text-decoration: underline;
}
a:active {
	color: darkcyan;
}
input {
	padding: 6px 12px 6px 12px;
	border: 1px solid #665544;
	color: #ffffff;
}
input.submit:hover {
	background-color:#665544;
}
input.submit:active {
	background-color: chocolate;
}
input.text {
	color: #cccccc;
}
input.text:focus {
	color: #665544;
}
```

# Chapter Summary

- We can edit the font, size, weight, style, and spacing of our text.
- Not all fonts are downloaded on your or your viewer's devices; you must properly install or link them.
- Text size, weight, and spacing should be done with care. They can increase or decrease the readability of your text dramatically. 
- Pseudo elements can make your text and even other elements look more interesting without much work.


---
Next: 
[Chapter 13]({{< ref "HTML & CSS - Chapter 13" >}}) 
