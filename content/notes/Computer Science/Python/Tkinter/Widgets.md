---
aliases: 
draft: false
tags:
  - computerscience
  - python
  - tkinter
  - modules
title: Widgets
date: 2025-03-09
updated: 2025-03-09T19:17
---

-------------------------------------------------------------------------------

Below are a few different types of widgets;

- `Label`: displays text
- `Button`: displays a button that can have text and do action commands
- `Entry`: displays a text input form for a single line
- `Text`: displays a text input form for multi-line entry
- `Frame`: a rectangular area for widgets or padding between widgets

There are many more widgets, as well as *themed widgets*, which are more updated versions of classic widgets, but we don't need to get into that today.


## Labels

Using a `Label` object, we can show basic text that can't be edited by the user or even images. The text example is up above, where we pass the text we want to the `text` parameter of `Label`. We can do basic text editing by adding additional parameters like `fg` and `bg`, which change the color of the text color and background color respectively. You can also do `width` and `height`, which change the size in *text units*, a rather odd unit of measurement (uses the width of the number 0). We'll learn more expressive formatting later.

```python
big_word = tk.Label(
	text="big words!",
	fg="red",
	bg="black",
	width=20,
	height=20
)
```



## Buttons

Buttons work incredibly similarly to `Label`, and even take some of the same parameters. You can make a button with the the following example;

```python
button = tk.Button(
	text="I'm a button!",
	width=30,
	height=10,
	bg="green",
	fg="orange"
)
```


## Entry

Many, if not all applications work by collecting some input from the user. To start collecting, we can use a really basic text input stream, `Entry`. Combined with a `Label`, and you can create a super basic text-entry form.

```python
name_label = tk.Label(text="Name")
entry = tk.Entry()
name_label.pack()
entrys.pack()
```

This tutorial uses `.get()`, `.delete()`, and `.insert()` to retrieve, edit, and enter information, but honestly at the moment I'm not seeing the relevance? For my project and many projects, I'm not sure why I'd need to edit the text-entry forms. If anything, I'm hoping later it will teach how to enter information and save it when in the main loop.


## Frames

Frames seem to be mostly for containing other widgets, like in the following example:

```python
frame_a = tk.Frame()
frame_b = tk.Frame()

label_a = tk.Label(master=frame_a, text="In frame A")

label_b = tk.Label(master=frame_b, text="In frame b")

label_a.pack()
label_b.pack()

frame_a.pack()
frame_b.pack()
```

These frames will by default stack on top of one another. All of the five widgets we went over have this `master` argument, so you can dictate which widgets will appear in which frame. 

### Adjusting Frame Appearance

The `relief` attribute of a given frame is what the border of the frame will look like when printed. The following attributes can be added onto any frame, and we're going to create a Python dictionary to store and use them conveniently;

```python
import tkinter as tk

border_effects = {
	"flat": tk.FLAT,
	"sunken": tk.SUNKEN,
	"raised": tk.RAISED,
	"groove": tk.GROOVE,
	"ridge": tk.RIDGE,
}
```

Then, we can use the following for loop to see how each of them appear:

```python
window = tk.Tk()

for relief_name, relief in border_effects.items():
	frame = tk.Frame(master=window, relief=relief, borderwidth=5)
	frame.pack(side=tk.LEFT)
	label=tk.Label(master=frame, text=relief_name)
	label.pack()

window.mainloop()
```

Since we used the `tk.LEFT` attribute with `side` when packing, all of our frames are appearing next to each other on the left hand side. If we left it out, we'd have that stacking method used earlier.

Few notes on naming; you may immediately pack a widget you don't want to use a variable for like so, `tk.Label(text="Hello, Tkinter").pack()`. We also use specific notation when shortening the names of widgets:

```python
Label -> lbl
Button -> btn
Entry -> ent
Text -> txt
Frame -> frm
```


---
Next: 
[Geometry Managers]({{< ref "Geometry Managers" >}}) 
