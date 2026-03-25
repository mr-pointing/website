---
aliases:
draft: false
tags:
  - computerscience
  - css
  - textbook
title: HTML & CSS - Chapter 11
date: 2026-03-11
updated: 2026-03-13T08:49
---

-------------------------------------------------------------------------------

# Color

One of the easiest ways to start making your pages look nice, color can quickly bring together content to look neat and organized. More specifically, choosing a good color scheme is what keeps people on your site rather than a cursory glance. We'll not only look at how to integrate colors, but what good integration of colors looks like.

By default, the `color` property changes the color of the text within a given element. We've already seen this used before, but to specify, we have three main ways of giving CSS a color; RGB values, a HEX code, or a color name. 

```css
/* color name */
h1 {
	color: purple;
}
/* hex code */
h2 {
	color: #ee3e80;
}
/* rgb value */
p {
	color: rgb(255, 125, 7);
}
```

Pretty self explanatory. One new thing this example goes over is comment codes; unlike HTML, where we write comments between `<!-- -->`, we write CSS comments between `/* */`. Comments in CSS are sometimes even more important than HTML, as CSS styles can be hard to understand if you didn't write them yourself. 

Changing the `background-color` property of a given element will supply the background with said color. We know this makes sense since we know every HTML element is a box; `background-color` colors in the box.

## Understanding Color

Going into depth on how color works is beyond this class, but basically every color on your screen is composed of some combination of red, green, and blue. All three methods of selecting a color provide the same thing; a combination of these three colors. RGB is the most straightforward example of this, since you're literally picking how much of each color you want. Hex codes and color names work the same, with color names being the most limited (only 147 options).

*Hue* is what we refer to as color, which is affected by saturation and brightness. *Saturation* refers to how much gray is in a color, and *brightness* is how much black is in a color. A really important term when designing a page is **contrast**; contrast is the difference between the colors of your foreground and background content. For example, low contrast would have a light color text on a light color background, while high contrast would have a light color text on a very dark background. Keep in mind, text is easiest to read with higher contrast, but *too much contrast* is bad for long spurts of reading. A medium contrast is best for longer paragraphs.

Last thing I want to go over is *Opacity*. Opacity is when you give a color a transparent attribute- making something see through. It's really easy, but wasn't always supported, and still is not supported on older machines;

```css
p.one {
	background-color: rgb(0,0,0);
	opacity: 0.5;
}
```

There are two other tags we aren't going to go over, to keep things simple. These are `hsl` and `rgba`. If you are interested in learning about these, give them a quick google. The standard three methods of color should be enough for us, but if you need a more complex shade, look into them. 

# Summary

- There are three main ways to place color into your pages; RGB, HEX, or Plain Name.
- Comments are made with an opening and closing tag; `/* */`
- Two main ways to integrate color into your pages; `color` for text, and `background-color` for box fill

---
Next: 
[Chapter 12]({{< ref "HTML & CSS - Chapter 12" >}}) 
