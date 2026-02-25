---
aliases:
draft: false
tags:
  - computerscience
  - html
  - textbook
title: HTML & CSS - Chapter 8
date: 2026-02-17
updated: 2026-02-23T11:38
---

-------------------------------------------------------------------------------

# Extra Markup

There's a lot we left out in the previous chapters. Again, HTML is not a challenging language to pick up and use, but there are some nuances to it we glanced over to just begin writing. In this chapter, we'll quickly go over some of the semi-important things we've moved past, as well as introduce some more advanced topics before we move into the CSS portion of this course.

## Version

The HTML we've been writing is technically called HTML5. Each new version on HTML improves upon the last iteration, which is the whole purpose of version management. Before this was XHTML 1.0, and before that was HTML4. HTML5 is a lot looser than the previous versions, and at the time of the text's printing it technically wasn't even finished. The fully complete specification sheet going over all of HTML5 in painful detail can be found [here](https://www.w3.org/TR/2011/WD-html5-20110405/).

One of the changes that we can really thank HTML5 for was the introduction of an easier DOCTYPE declaration. Like we know from every page we've written thus far, declaring a `DOCTYPE` on the first line of any HTML file set's up that file to be read as HTML. In earlier versions, we had to write out exactly which type of standards we were following by linking to them. Here's an example of what it looked like in HTML4;

```html
<!DOCTYPE html PUBLIC
"-//W3C//DTD HTML 4.01 Transitional//EN"
"http://www.w3.org/TR/html4/loose.dtd">
```

## Comments, IDs, and Classes

The first of the extra info, is making a comment. If you've taken a programming class with me before, you know I like a file to be not only well formatted, but well documented. Going forward, we should leave comments in all of our work explaining who we are, what we're displaying, and leaving info on complex or interesting decisions. Comments are left between the `<!--` opening and `-->` closing tag. Again, comments will not show up in the actual web-page but as a part of the text in the file, that can be read by either opening the file up with a text editor (like notepad++) or viewing the developer tool section of your browser.

Something I should have already mentioned at this point, especially with the last chapter, is the use of the `id` attribute with HTML elements. This will start to make more sense in the next chapter with the introduction of CSS, but essentially if you want to give an individual element in your web page a unique identifier, the `id` attribute is the way to go. Here's a standard element with an `id`;

```html
<p id="beginning">It was the best of times...</p>
<p id="ending">...it was the worst of times.</p>
```

Once we start styling our pages to look nice, we'll find a lot more use for the `id` attribute. Another way to identify elements is with the `class` attribute. If `id` is for individual elements, `class` is used for multiple elements that should be treated the same. It works the exact same way an `id` attribute works, but multiple elements will have the same attribute rather than having each one contain a new `id`.

```html
<p>There are only some sentences I want to be changed</p>
<p class="action">Which ones exactly?</p>
<p>I think you'll be able to tell the difference...</p>
<p class="action">...I hope!</p>
```


## Grouping Elements

We've discussed this way early on, but we know that some tags create new lines while others don't. We should call any element that creates a new line a *block element*, and anyone that doesn't an *inline element*. One thing we haven't touched on is how to actually group elements together into one designated area. 

Up until this point, we've written our code in either the `body` of `head` of our page, mostly the `body`. Just separating into two general parts is just too messy for most web developers. We should have some way to differentiate parts of our page from one another, especially now that we're about to introduce styling. The best way to do this is to use a `div` tag. This `div` acts like a giant block element, that you can put anything inside. Think of it as an extension of your `body` tag. Want all of the elements of your title and subheadings in one neat section? Place them in a `div`. Want to ensure your paragraphs have unique spacing from the other sections of your page? Use a `div` tag. There are so many ways to use it, there is no wrong way (unless your `div` is the entire page!).

```html
<div class="heading">
	<img src="images/logo.gif" alt="Mr. Pointing">
	<ul>
		<li><a href="index.html">Home</a></li>
		<li><a href="bio.html">About</a></li>
		<li><a href="works.html">Works</a></li>
		<li><a href="contact.html">Contact</a></li>
	</ul>
</div>
```

Another tag we might not use that much but you should know about is the `span` tag. It's almost the exact opposite of a `div` tag; instead of using it to create a newline block for a list of elements, it's a way of accessing part of your inline elements without having to create a new line or use a different tag you don't necessarily need. Here's a basic example; imagine you want to have some styling set to the class called `art`, that you only want to affect one word in your `p` tag.

```html
<p>Some might say that <span class="art">art</span> is dead. I would argue the contrary!</p>
```

## Outside and Meta Data

We have some content that exists on another webpage we want to include on our page. A link is fine, but sometimes we can do more. For example, we want to include a Google Map or YouTube video. One nice way to accomplish this is using the `iframe` element, which will allow you to integrate the content we just brought up into your page. You provide a `src` attribute, as well as a `height` and `width` and you're good to go. Most places nowadays will actually give you a copy/paste portion of code to place in your page, to save you the difficulty of writing it all out from scratch. Fair warning, due to a lot of changes, getting YouTube to work is somewhat challenging as their embed feature never works on my local machine in testing.

Finally, let's end the chapter on something I've been hinting at since chapter 1. We only lightly discussed what goes in the `head` tag. I told you that it mostly contains information about your page, that the user doesn't end up seeing. It can also contain other things, but the main portion of your `head` tag will contain `meta` tags. `meta` tags contain the literal data about your page that is mostly seen by the browser and search engines. The tag itself is a one-liner, meaning it opens and closes in the same tag. There are some attributes we should look at though;

1. `name="description"`: used to pass into the `content` attribute a short description of your page.
2. `name="keywords"`: used to pass into the `content` attribute a string of keywords for your site.
3. `name="robots"`: decides whether or not your site will be indexable by search engines. If you don't want your page to be used by engines like Google, use `contents="nofollow"`. 
4. `http-equiv="author"`: used to pass into the `content` attribute the name of the author of the page (you!)
5. `http-equiv="pragma"`: used to decide if you want your page cached by the machine's local browser. To not allow it, use `content="no-cache"`.


# Summary

- We are currently on HTML5
- Comments should be used to display important information about choices made on your page
- `id` tags are for unique elements, `class` tags are for multiple elements
- `div` tags should be used to group block elements together, while `span` should be used to keep all block elements inline
- `meta` tags describe the information about a page used by a browser and/or search engine


---
Next: 
[Chapter 9]({{< ref "HTML & CSS - Chapter 9" >}}) 
