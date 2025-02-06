---
aliases: 
draft: false
tags:
  - computerscience
  - html
  - css
title: Text Styles
date: 2025-01-30
updated: 2025-02-03T16:53
---

-------------------------------------------------------------------------------

## Getting New Fonts

If you decided that you wanted to use a custom font for your website, unless the person viewing your site also has that font downloaded, it will default to the standard HTML font. To avoid this, it's common practice to use a system font stack;

```css
body {
	font-family: system-ui, "Segoe UI", Roboto, Helvetica, Arial, sans-serif, "Apple Color Emoji", "Segoe UI Emoji", "Segoe UI Symbol";
}
```

This will allow your site to have numerous back-up styles, in the off chance your user doesn't have access to that font.

To avoid having this issue entirely, you can use a Web-hosted font or add one to your site's resources. For web-hosted, Google offers a very popular and widely used library, and here are two examples of how they can appear.

Via a `link` tag directly in your HTML:

```html
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Roboto&display=swap" rel="stylesheet">
```

or as a part of your CSS Stylesheet:

```css
@import url('https://fonts.googleapis.com/css2?family=Roboto&display=swap');
```

If you want to add a font directly to your site's resources, you usually have to place the font's files into your sites directory, so they can access it using the following syntax in your stylesheet:

```css
@font-face {
	font-family: my_new_font;
	src: url(/path/to/font_file.tff)
}
```


## Text Styling


### `font-style` vs. `em`

When you want to italicize text, there are two main ways to do so depending on your goal for the italics. If you want to italicize an entire body of text for stylistic purposes, than you should edit your stylesheet and use the CSS tag `font-style` like so:

```css
body {
	font-style: italic;
}
```

If you only want to italicize *text in the middle of a paragraph*, like we just did, you should use an `em` tag directly in the HTML (`em` stands for emphasis!):

```html
<p>This is mostly going to be <em>non-italicized</em>... well, mostly.</p>
```

### Letter Spacing

Does exactly what you think it does; adds or removes spacing between the characters in your text. Again, usually your going to use `em` for your size type, and is generally used for things like titles and headers for easier reading (try not to make your characters too close or it becomes illegible!).

```css
.wide_word {
	font-size: 32px;
	letter-spacing: 1em;
}

.thin_word {
	font-size: 38px;
	letter-spacing: -0.5em;
}
```


### Line Height

The amount of space each line in wrapped up text? That's controlled by `line-height`, which is also used to increase readability on your pages. Think of double spacing:

```css
p {
	line-height: 1.5;
}
```


## Resources for Text Styling

- [MDN article](https://developer.mozilla.org/en-US/docs/Learn_web_development/Core/Text_styling/Web_fonts) on web fonts
- [Web Font](https://web.dev/articles/font-best-practices) best practices
- [Typography](https://web.dev/learn/design/typography) and scaling text
- Fonts to choose from:
	- [Font Library](https://fontlibrary.org/)
	- [Google fonts](https://fonts.google.com/) 
	- [Font Bunny](https://fonts.bunny.net/)


