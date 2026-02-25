---
aliases:
draft: false
tags:
  - computerscience
  - html
  - textbook
title: HTML & CSS - Chapter 7
date: 2026-02-08
updated: 2026-02-17T11:21
---

-------------------------------------------------------------------------------

# Forms

Once again, we stumble across another staple of HTML, the *form*. We understand any form to be a space where there are boxes or lines that allow user input. These can be in the form of text boxes, drop-down menus, scales, whatever you can think of. Like most HTML elements, the uses are numerous. Whether you're collecting info for a newsletter, or filling out a request form, forms make all of that data collection trivial.

## Types of Forms

Every time you use Google, you're faced with a form: a basic textbook looking to collect your query. There are way more than just that though. We can create;

- Single line text input
- Password text input
- Multi-line text input
- Radio buttons
- Check boxes
- Drop-down boxes
- File uploads

We also usually have a button or two that allow you to submit the form. Regardless of your intention, the use of a form is nearly the same in all accounts;

1. Fill out a form and press submit
2. The data collected is sent to a server with names for each question
3. Server processes the information given (usually with PHP, C#, VB.net, or Java)
4. The server accepts the form, saves the data in some way, and sends the user to a confirmation page

## Form Structure

Like most HTML structures, the tag is self explainable; the `form` tag contains the form elements you'll fill out, as well as some special attributes that tell the form what to do. 

- `action`: slightly depreciated, tells the form what to do when submitted
- `method`: takes in two types, `get` or `post`

To talk briefly about `method`, since it is a bit more complicated than just accepting two words. `get` will attach the information you pass into the form at the end of the URL, so it's mostly used for short forms or just receiving data from a web server. On the other hand, we use `post` when wee want to send info over HTTP headers. What's happening here is more likely to be covered in a higher level HTML or AP Computer Science course, but all you need to know is that if you're having the user upload a file, submit sensitive info, or just have a lot of info, you're going to use `post` instead of `get`. 


### `input`

A single-line text input box. It takes in a few attributes- we pass in a `type="text"` to identify it's a text-box. We use the `name` attribute to the identify what the forms' input will be known or identified as. We'll also learn how to use another attribute called `id`, which we'll come across another time. The `maxlength` attribute tells the box how many characters long the box should be. 

We can also use the `input` tag to set up a password covered box, using `type="password"`. 

```html
<form action="http://www.example.com/login.php">
	<p>Username:
		<input type="text" name="username" maxlength="30" />
	</p>
	<p>Password:
		<input type="password" name="password" maxlength="30" />
	</p>
</form>	
```

Another type is `radio`, which creates nice looking radio buttons. When using radio buttons, you also have to use `value` to tell the HTML server that your form is being submitted too which one was chose, as well as an option for if you want it to pre-checked or not with `checked`. Set it equal to `check` to mark it already chosen. 

```html
<form action="http://www.example.com/login.php">
	<p>Please select your favorite genre:
		<br>
		<input type="radio" name="genre" value="rock" checked="checked"/> Rock
		<input type="radio" name="genre" value="pop"/> Pop
		<input type="radio" name="genre" value="jazz"/> Jazz
	</p>
</form>
```


We can use type equal to `checkbox` to create a select-able check box. The attributes here are nearly the same as using a radio button.

```html
<form action="http://www.example.com/login.php">
	<p>Please select your music service:
		<br>
		<input type="checkbox" name="service" value="spotify" checked="checked"/> Spotify
		<input type="checkbox" name="service" value="apple_music"/> Apple Music
		<input type="checkbox" name="service" value="youtube_music"/> YouTube Music
	</p>
</form>
```


If you want to upload a file, set the input type to `file`. Relatively simple, the only thing you need to include is an attribute for the name, and a new `button` tag with type set to `submit`, with a `value` for what you want the button to say.

```html
<form action="http://www.example.com/login.php" method="post">
	<p>Upload your song in MP3 format:
	<input type="file" name="user-song"/>
	<button type="submit" name="upload" value="Upload"/>
</form>
```

The last use of `input` we'll look at together is the option for a date input. We can create this easily by setting our `input` tag's `type` attribute to `date`;

```html
<form action="http://www.example.com/login.php">
	<label for="departure">Departure date:</label>
	<input type="date" id="departure" />
	<input type="submit" value="Submit"/>
</form>
```

### `textarea`

Similar to using `input` with `type="text"`. The only new attribute would be `cols` and `rows`. Later on we'll make this decision with CSS, but we can also use it directly in the `textarea` tag. 

### `select`

Whenever you want to have users select from a drop down list, we use a `select` tag. Each choice will be denoted with an `option` tag, that takes in the `value` tag. Usually you use drop down menus when you have a bunch of options, since there would be too many radio buttons or check boxes.


```html
<form action="http://www.example.com/login.php">
	<p>Which device do you listen to music mostly?:
	<select name="devices">
		<option value="phone">Phone</option> 
		<option value="radio">Radio</option>
		<option value="mp3">MP3 Player</option>
	</select>
	</p>
</form>
```


### `label`

The most up to date way to use text around your inputs are to use a `label` tag. There are tons of ways you can use this, but if you ask me, we start by giving the input tag an `id` attribute, then using the `label` tag with a `for` attribute, like so;

```html
<form action="http://www.example.com/login.php">
	<label for="placement">Body Placement:</label>
	<select id="placement" name="placement" required>
		<option value="">Select a part</option>
		<option value="arms">Arms</option>
		<option value="back">Back</option>
		<option value="chest">Chest</option>
		<option value="legs">Legs</option>
		<option value="shoulder">Shoulder</option>
		<option value="other">Other</option>
	</select>
</form>
```


## Extra Form Info

Now that we have most if not all of the important form fields we're going to use in this course, let's get some additional best practice tools under our belt. First up is grouping all of our input fields together. Later on we'll learn a more general approach to grouping elements, but there's a specific grouping made for input fields; `fieldset`. `fieldset` is a container tag, meaning we open it and put our form fields inside of it. Here's an example with some of the questions above formatted nicely and neatly;

```html
<form action="http://www.example.com/login.php">
	<fieldset>
	<legend>Music Questionnaire</legend>
		<label for="devices">Which device do you listen to music on the most?</label>
		<select name="devices">
			<option value="phone">Phone</option> 
			<option value="radio">Radio</option>
			<option value="mp3">MP3 Player</option>
		</select>
		<br>
		
		<label for="user-song">Upload your song in MP3 format: </label>
		<input type="file" name="user-song" id="user-song"/>
		<br>
		
		<label for="genre">Choose your favorite music genre: </label>
		<input type="radio" name="genre" value="rock" checked="checked"/> Rock
		<input type="radio" name="genre" value="pop"/> Pop
		<input type="radio" name="genre" value="jazz"/> Jazz
		
		<br>
		<input type="submit" value="Submit"/>
	</fieldset>
</form>
```

Obviously when filling out a form, there are certain fields we want to be filled out whenever it's submitted. These are called *required fields*, and setting one up is as easy as passing the attribute `required="required"` in any question you need to be filled out before submitting. Traditionally, these are saved for things like passwords, email and contact info, and anything else that the creator deems necessary. We consider this to be a type of **form validation**, and there are few more ways we can do that. If you want your text to be formatted as a email, you set your `input` tag's type to `email`. If you want your text to be a URL, again set your `input` tag's type to `url` this time. 


# Summary

- Anytime you want to collect information from the user, use a `form` tag to enclose your questions in
- All questions should be in a name/value pairs
- HTML5 introduced new ways of validating forms 


---
Next: 
[Chapter 8]({{< ref "HTML & CSS - Chapter 8" >}}) 
