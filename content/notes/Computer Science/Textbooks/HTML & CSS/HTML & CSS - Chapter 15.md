---
aliases:
draft: false
tags:
  - computerscience
  - css
  - textbook
title: HTML & CSS - Chapter 15
date: 2026-05-04
updated: 2026-05-19T06:16
created: 2026-05-04T07:02
---

-------------------------------------------------------------------------------

# Layout

Another important chapter that we've been working towards for a few weeks now, styling our *layout* means applying styles to how our page is formatted. Like every chapter, this is best studied by applying the following code snippets and messing around with them; don't be afraid to experiment!

Before moving into anything new, let's do a quick review on how things work as we understand. We know that each element within a given HTML page is a box. Some of these boxes create new boxes that disrupt the flow of a page, called *block-level elements*. These will always begin a new line and be completely separate from one another, like a `h1` tag or a `p` tag. We also know that some boxes actually blend into the background, and sit wherever used, like when we use the `i` tag or the `b` tag. These are called *inline elements*, and flow nicely between text.

We also have *container elements*, which do exactly what they're called; contain other elements. The best example for these are `div` tags, since they are used to contain relevant elements together.

## Controlling Positions

CSS let's us do whatever we want pretty much, but it's best to be consistent and stick to the positioning schemes it gives your right out of the box. By calling the `position` property, and sometimes even the `float` property, we can start to use these positioning schemes. There are some relevant terms we should understand before trying anything;

- *Normal Flow*: Default behavior, elements appear underneath one another regardless of size
- *Relative Positioning*: Changes only the positioning of the selected element, moves to where designated
- *Absolute Positioning*: Does not effect the surrounding elements by literally not moving from where it was placed on the screen; will move with the user as they scroll
- *Fixed Positioning:* Similar to Absolute, except it does not move when the user scrolls
- *Floating Elements:* Allows other elements to "float" or move next to elements around it

Normal flow really doesn't need an explanation as it's what happens by default/no CSS at all, but if you wanted to hard-code the default behavior for whatever reason you can use `position: static;`. Again, not many reasons to do this but you never know.

We can look at how to start manipulating using relative, as that's the first divergence from normal behavior. When working with text boxes, for example, you can slightly move boxes out of the normal flow using the following; 

```css
p.example {
	position: relative;
	top: 10px;
	left: 100px;
}
```

Absolute is a bit weird to work with but it's not that bad. All you're doing is using what we call the **box offset properties** (which we used in the last example!) to tell your element where to appear.

```css
h1 {
	position: absolute;
	top: 0px;
	left: 500px;
	width: 250px;
}
p {
	width: 450px;
}
```

In the previous example, we set the heading we made to become `absolute`, as well as tell it where to appear. It will have 500px of space to it's left, no space at all on top, and it should be 250px wide. One way we can keep our boxes from overlapping or anything weird to happen is to ensure their sizes don't go over one another, hence why we said to keep the `p` tag to a width of 450px.

Using the `fixed` position is also simple enough, and again will allow an element to remain on the spot given even after the user scrolls down. Here's a basic example;

```css
h1 {
	position: fixed;
	top: 0px;
	left: 50px;
	padding: 10px;
	margin: 0px;
	width: 100%;
	background-color: #efefef;
}
p.example {
	margin-top: 100px;
}
```

Like I just brought up, overlapping elements can be annoying. Not only annoying, but ugly. Let's say we continue using the previous example, but changed our `p.example` styling to the following;

```css
p.example {
	position: relative;
	top: 70px;
	left: 70px;
}
```

If you run it now, you should get all of your paragraph text over your title, which is kind of the opposite effect of what we're looking for. If we want to ensure our Heading appears in front, we should pass in `z-index: 10;` to our styling for our `h1` tag. The reason we picked 10 is no reason at all, other than the larger the number, the more precedence it takes. Meaning; if we have a few elements with a `z-index` property, and one has  10 and the other has a 7, the one with 10 takes priority.

Floating elements can be tricky, as they completely diverge from the default behavior. Instead, they rely on the size of our elements, and even the browser window. It's also good practice to use the `width` property in tandem, to give you greater control over your elements. Here's a basic example using a `blockquote`;

```css
blockquote {
	float: right;
	width: 275px;
	font-size: 130%;
	font-style: italic;
	font-family: Georgia, Times, serif;
	margin: 0px 0px 10px 10px;
	padding: 10px;
	border-top: 1px solid #665544;
	border-bottom: 1px solid #665544;
}
```

This creates a really nice looking quote that sits to the right side inside your paragraph. The `float` property is how many web designers achieve side by side elements. One issue designers have to keep in mind is how the height of your boxes will change the positioning of them. For example, say you have a couple of different `p` tags with different amounts of text in each. If you set up the following `css` with that, it will look quite jank;

```css
body {
	width: 750px;
	font-family: Arial, Verdana, sans-serif;
	color: #665544;
}
p {
	width: 230px;
	float: left;
	margin: 5px;
	padding: 5px;
	background-color: #efefef;
}
```

One way we could fix this is setting all of the `p` tags to have the same amount of content, forcing them to be the same size. This is hardly practical, as this isn't always possible. Albeit a little more complicated, a far more sensible approach is to create a class to use the `clear` property, like in the following;

```css
.clear {
	clear: left;
}
```

The `clear` property is hard to understand, so it's best to try it out yourself. You can use `left` to not allow left-hand sides of your box not touch any other element; same applies to `right`, `both`, and `none`. It specifically works with elements within one container; say for example, you have a div with multiple `p` tags within it, or even just regular tags within a `body`.

Speaking of using a `div`, something weird happens when you have elements floating within one. Let's say for example we have our same code from above, but now we're going to put our `p` tags in a `div` and we want to give our `div` a border. Sometimes, when specifying a border, like with `div {border: 1px solid #665544;}`, the `div` will respond by thinking elements are 0 pixels tall, and only part of the `div` will have a border. To fix this, use `overflow: auto;` and `width: 100%;` alongside your border for it to work properly.

Another neat trick you guys might want to do is create columns on your page. Maybe we want to have information in one column, and shorthand dates of reference in another. We can accomplish this by creating classes of our own, and using the `float` attribute;

```css
.column1of2 {
	float: left;
	width: 620px;
	margin: 10px;
}
.column2of2 {
	float: left;
	width: 300px;
	margin: 10px;
}
```

This will create a really nice basic column layout. Applying this to more columns is also pretty flexible, and with some critical thinking you can put together some smart classes;

```css
.column1of3, .column2of3, .column3of3 {
	width: 300px;
	float: left;
	margin: 10px;
}
```

## Screen Size and Resolution

This textbook is so outdated, they're using an *iPhone 4* as a reference for size! That really goes to show you how fast things change. That aside, the text still offers a great piece of advice; there is so much variety with screen sizes, it's difficult to plan for all of them. That being said, we can still use best practice skills to make sure they look good on most screens.

More often today we try to shoot for 960-1000 pixels wide for screen design. Designing for mobile is a small course within itself, but it can be done if you're willing to consider it. For now, let's focus on desktop viewing.

There are two main types of layouts we should be conscious of when making a page; having a **fixed width layout** or a **liquid layout**. Fixed width pages have their elements stay the size they're at as the browser window changes size. Measurements are usually in pixels, which tend to be pretty accurate and gives you a greater amount of control over your layout. Images will stay their size determined no matter what, and generally you're not concerned about the users screen size. Obviously, this means we could have some huge gaps on our screen if the users screen is big enough. Not only that, but if the resolution on the screen is higher than we designed for, our content can come out looking tiny. Maybe a user wants to increase the font-size; this would cause issues as the elements wouldn't increase in size alongside the text.

```html
<body>
<div id="header">
		 <h1>Logo</h1>
		 <div id="nav">
			 <ul>
				 <li><a href="">Home</a></li>
				 <li><a href="">Products</a></li>
				 <li><a href="">Services</a></li>
				 <li><a href="">About</a></li>
				 <li><a href="">Contact</a></li>
			 </ul>
		 </div>
</div>
<div id="content">
		 <div id="feature">
			 <p>Feature</p>
		 </div>
		 <div class="article column1">
			 <p>Column One</p>
		 </div>
		 <div class="article column2">
			 <p>Column Two</p>
		 </div>
		 <div class="article column3">
			 <p>Column Three</p>
		 </div>
</div>
<div id="footer">
		 <p>&copy; Copyright 2011</p>
</div>
</body>
```

```css
body {
	width: 960px;
	margin: 0 auto;}
	#content {
	overflow: auto;
	height: 100%;}
	#nav, #feature, #footer {
	background-color: #efefef;
	padding: 10px;
	margin: 10px;
}
.column1, .column2, .column3 {
	background-color: #efefef;
	width: 300px;
	float: left;
	margin: 10px;
}
li {
	display: inline;
	padding: 5px;
}
```

Liquid layouts are the exact opposite; they stretch and contract as your use manipulates their window. Percentages are more common here, since your page is likely going to have to fill the entire browser window. Text increasing works well here, and smaller screens get easier viewing here. Unfortunately, you lose a lot of direct control over the layout of your elements, and can take some time and experimentation to get it to look exactly the way you want. 

```css
body {
	width: 90%;
	margin: 0 auto;}
	#content {overflow: auto;}
	#nav, #feature, #footer {
	margin: 1%;
}
.column1, .column2, .column3 {
	width: 31.3%;
	float: left;
	margin: 1%;
}
.column3 {
	margin-right: 0%;
}
li {
	display: inline;
	padding: 0.5em;
}
#nav, #footer {
	background-color: #efefef;
	padding: 0.5em 0;
}
#feature, .article {
	height: 10em;
	margin-bottom: 1em;
	background-color: #efefef;
}
```

# Summary

- `div` elements make great containers
- You can determine the flow of your page by specifying `relative`, `absolute`, or `fixed` positioning
- `float` allows you to move elements next to one another
- Pages tend to be either fixed width or liquid


---
Next: 
[Chapter 16]({{< ref "HTML & CSS - Chapter 16" >}}) 
