---
aliases:
draft: false
tags:
  - computerscience
  - css
  - textbook
title: HTML & CSS - Chapter 14
date: 2026-04-10
updated: 2026-05-12T08:40
created: 2026-04-14T10:20
---

-------------------------------------------------------------------------------

# Lists, Tables and Forms

As we move through the CSS portion of this book, you should start to realize everything we learned in the HTML portion has some CSS style we can apply to it. In this chapter, we'll learn how to start working on our Lists, Tables, and Forms that we learned about in earlier chapters.

## Lists

I already know how popular this is going to be based on how many students have already asked questions about this, so strap in. First off, up until this point we've been calling each list item a number of bullet point. The more accurate name for that item is called a *marker*, and it can be styled in numerous different ways. The first thing we can do is choose a default style type, using `list-stlye-type` on our `ol` or `ul`. Each list type has different style types;

- Unordered Lists
	- `none`
	- `disc`
	- `circle`
	- `square`
- Ordered Lists
	- `decimal`
	- `decimal-leading-zero`
	- `lower-alpha`
	- `upper-alpha`
	- `lower-roman`
	- `upper-roman`

You also have the option to use an image with `list-style-image` instead, but use caution as a large image will be compressed and look bad if it has to become so tiny. Also edit the margins on your elements like in the next example to ensure your elements are spaced out properly;


```css
ul {
	list-style-image: url("images/star.png");
}
li {
	margin: 10px 0px 0px 0px;
}
```

We can also position the marker, which mostly helps in two circumstances; if we want to move the markers to where our text sits (like when centering) or choosing how the lines are formatted when moving onto a new line. Use the following example to try out `outside` and `inside`;

```css
ul {
	width: 150px;
}
li {
	margin: 10px;
}
ul.outter {
	list-style-position: outside;
}
ul.inner {
	list-style-position: inside;
}
```

## Tables

Editing our tables becomes a lot easier now that we know a good chunk of the styles we'd use to edit any common table. Here's a great example. First, write out the HTML and run it to see what it looks like pre-styling to really understand how much heavy lifting CSS can really do; 

```html
<h1>First Edition Auctions</h1>
	<table>
		<tr>
			 <th>Author</th>
			 <th>Title</th>
			 <th class="money">Reserve Price</th>
			 <th class="money">Current Bid</th>
		</tr>
		<tr>
			 <td>E.E. Cummings</td>
			 <td>Tulips & Chimneys</td>
			 <td class="money">$2,000.00</td>
			 <td class="money">$2,642.50</td>
		</tr>
		<tr class="even">
				 <td>Charles d'Orleans</td>
				 <td>Poemes</td>
				 <td class="money"></td>
				 <td class="money">$5,866.00</td>
		</tr>
		<tr>
				 <td>T.S. Eliot</td>
				 <td>Poems 1909 - 1925</td>
				 <td class="money">$1,250.00</td>
				 <td class="money">$8,499.35</td>
		</tr>
		<tr class="even">
				 <td>Sylvia Plath</td>
				 <td>The Colossus</td>
				 <td class="money"></td>
				 <td class="money">$1031.72</td>
		</tr>
	</table>
```

```css
body {
	font-family: Arial, Verdana, sans-serif;
	color: #111111;
}
table {
	width: 600px;
}
th, td {
	padding: 7px 10px 10px 10px;
}
th {
	text-transform: uppercase;
	letter-spacing: 0.1em;
	font-size: 90%;
	border-bottom: 2px solid #111111;
	border-top: 1px solid #999;
	text-align: left;
}
tr.even {
	background-color: #efefef;
}
tr:hover {
	background-color: #c3e6e5;
}
.money {
	text-align: right;
}
```

I implore you to take your time inserting and seeing the changes made with each attribute. I won't harp again how important it is to your learning to actually write these out yourselves. Another attribute we can change concerning our tables are the borders between our cells. Specifically; what happens when we have empty cells? It depends on your browser, but you can tell CSS exactly what you want to happen with it's border by passing in the `empty-cells` attribute. You can give it a value of `show` or `hide`, to show or hide empty cells respectively. 

We can also change the space between our cells, using the the `border-spacing` attribute. There already is a small space provided by your browser, but now you'll have the ability to pass in a pixel amount for how large you want the spacing between them, like with `border-spacing: 5px 15px;`. If you want to get rid of all spacing and have cells share the same border, you can use `border-collapse: collapse;`.


## Styling Forms

Something about forms makes the human mind gloss right over them. It's our job as website designers to make engaging forms that people actually want to fill out. The more ugly a form, the less likely someone will fill it out all the way through. The most common things we should focus on styling are;

- Text inputs and text areas
- Submit buttons
- Labels on forms

The goal here is simple; keep everything uniform while also looking stylish. Uniformity relies on consistency; do all of your labels and boxes line up? Are any randomly in a different area than they should be? Are my boxes large enough for the amount of text I'm having my user enter? These are the things you should be asking yourself when designing a form. Let's start with the inputs; here are a bunch of really common styles we can pass onto our inputs:

```css
input {
	font-size: 120%;
	color: #5a5854;
	background-color: #f2f2f2;
	border: 1px solid #bdbdbd;
	border-radius: 5px;
	padding: 5px 5px 5px 30px;
	background-repeat: no-repeat;
	background-position: 8px 9px;
	display: block;
	margin-bottom: 10px;
}
input:focus {
	background-color: #ffffff;
	border: 1px solid #b1e1e4;
}
input#email {
	background-image: url("images/email.png");
}
input#twitter {
	background-image: url("images/twitter.png");
}
input#web {
	background-image: url("images/web.png");
}
```

Here we edit our `input` element, the pseudoclass `focus` on the `input` element, as well as some unique id's for our `input` fields. These images work as tiny placeholders so users have an idea of what goes in there even without a label. We will go into a little more detail on background images in chapter 14. 

Next up are styling submit buttons. This example has some higher level concepts we won't touch on for another chapter or two, but it reveals some ideas you will likely want to try out yourself;

```css
input#submit {
	color: #444444;
	text-shadow: 0px 1px 1px #ffffff;
	border-bottom: 2px solid #b2b2b2;
	background-color: #b9e4e3;
	background: -webkit-gradient(linear, left top,
			 left bottom, from(#beeae9), to(#a8cfce));
	background:
			 -moz-linear-gradient(top, #beeae9, #a8cfce);
	background:
			 -o-linear-gradient(top, #beeae9, #a8cfce);
	background:
			 -ms-linear-gradient(top, #beeae9, #a8cfce);
}
input#submit:hover {
	color: #333333;
	border: 1px solid #a4a4a4;
	border-top: 2px solid #b2b2b2;
	background-color: #a0dbc4;
	background: -webkit-gradient(linear, left top,
			 left bottom, from(#a8cfce), to(#beeae9));
	background:
			 -moz-linear-gradient(top, #a8cfce, #beeae9);
	background:
			 -o-linear-gradient(top, #a8cfce, #beeae9);
	background:
			 -ms-linear-gradient(top, #a8cfce, #beeae9);
}
```

Here's another example of styling a form; this time, we'll look at some styles to give us a more interesting fieldset/legend;

```css
fieldset {
	width: 350px;
	border: 1px solid #dcdcdc;
	border-radius: 10px;
	padding: 20px;
	text-align: right;
}
legend {
	background-color: #efefef;
	border: 1px solid #dcdcdc;
	border-radius: 10px;
	padding: 10px 20px;
	text-align: left;
	text-transform: uppercase;
}
```

Let's look at a really common issue, how to align form controls. Say we have the following HTML;

```html
<form action="example.php" method="post">
	<div>
		 <label for="name" class="title">Name:</label>
		 <input type="text" id="name" name="name" />
	</div>
	<div>
		 <label for="email" class="title">Email:</label>
		 <input type="email" id="email" name="email" />
	</div>
	<div>
		 <span class="title">Gender:</span>
		 <input type="radio" name="gender" id="male"
			 value="M" />
		 <label for="male">Male</label>
		 <input type="radio" name="gender" id="female"
			 value="F" />
		 <label for="female">Female</label><br />
	</div>
	<div>
		 <input type="submit" value="Register"
			 id="submit" />
	</div>
</form>
```

Here's a really easy way of making sure everything stays nice and styled accordingly;

```css
div {
	border-bottom: 1px solid #efefef;
	margin: 10px;
	padding-bottom: 10px;
	width: 260px;
}
.title {
	float: left;
	width: 100px;
	text-align: right;
	padding-right: 10px;
}
.radio-buttons label {
	float: none;
}
.submit {
	text-align: right;
}
```

# Summary

- While most CSS properties can be used interchangeably, some styles help change lists, forms, and tables specifically
- List markers are editable
- Table cells can have their borders and spacing styled as well as their content
- Forms are easier to use if form controls are controlled via CSS vertical layout


---
Next: 
[Chapter 15]({{< ref "HTML & CSS - Chapter 15" >}}) 

