---
aliases:
draft: false
tags:
  - computerscience
  - css
  - textbook
title: HTML & CSS - Chapter 16
date: 2026-05-19
updated: 2026-05-19T06:33
created: 2026-05-19T06:16
---

-------------------------------------------------------------------------------

# Images

To get right into it, we've already sort of styled images in the past. By passing in a width and height, we directly controlled how our images look. Now that we're in CSS, we can still obviously use those same measurements as a part of our styling sheet;

```css
img.large {
	width: 500px;
	height: 500px;
}
img.medium {
	width: 250px;
	height: 250px;
}
img.small {
	width: 100px;
	height: 100px;
}
```

Now that we know some useful tips from the last chapter, we can combine them to help create more interesting layouts with our images. Take the following example, where we use `float`, and we make some `align` classes;

```html
<p><img src="images/magnolia-medium.jpg"
alt="Magnolia" class="align-left medium" />
<b><i>Magnolia</i></b> is a large genus that
contains over 200 flowering plant species...</p>
<p><img src="images/magnolia-medium.jpg"
alt="Magnolia" class="align-right medium" />
Some magnolias, such as <i>Magnolia stellata</i>
and <i>Magnolia soulangeana</i>, flower quite
early in the spring before the leaves open...</p>
```

```css
img.align-left {
	float: left;
	margin-right: 10px;
}
img.align-right {
	float: right;
	margin-left: 10px;
}
img.medium {
	width: 250px;
	height: 250px;
}
```

When using images, you must keep in mind that they are still *inline elements*, meaning whatever text you have on page with them will flow around them. If you want to let's say center an image, you are best off turning your image into a *block element*, using the following example;

```css
img.align-center {
	display: block;
	margin: 0px auto;
}
img.medium {
	width: 250px;
	height: 250px;
}
```

One idea some of you are already beginning to experiment with is using background images. Thankfully, this is actually quite easy to do, and can be given to most elements;

```css
body {
	background-image: url("images/pattern.png");
}
```

The only major thing we should know before styling them a bit is that usually, background images are the last thing loaded on a web page, so it may seem "slow" compared to other elements on your page. If you do have a pattern to use, the image might be small; this is where we pass in a repeater to help us;

```css
body {
	background-image: url("images/pattern.png");
	background-repeat: repeat-x;
	background-attachment: fixed;
}
```

You can choose to repeat in either x or y, or just `repeat` for both directions. I also introduced this `background-attachment`; this will tell CSS what to do with the image as the user scrolls on the page. `fixed` will tell the image to stay put, while `scroll` will move with the user. Last up is the positioning, which will tell your image where to be positioned if not repeated in your element. There are many positions, made up of a selection of left right center, then top center bottom.

```css
body {
	background-image: url("images/flower.png");
	background-repeat: no-repeat;
	background-position: center top;
}
```

# Summary

- Dimensions of an image can be determined using CSS
- Images can be both horizontally and vertically aligned using CSS
- Background images are possible and controllable


---
Next: 
[Chapter 17]({{< ref "HTML & CSS - Chapter 17" >}}) 
