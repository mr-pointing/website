---
aliases: 
draft: false
tags:
  - computerscience
  - python
  - modules
title: Tkinter Tutorial
date: 2024-10-27
updated: 2024-11-07T12:10
---

-------------------------------------------------------------------------------

[Link](https://realpython.com/python-gui-tkinter/) to the tutorial.


# Building Your First Application

What makes Tkinter nice is that it's a built-in library, meaning it should come with all versions of Python 3.12. If you're using Ubuntu (like me) for this example you will have to install it but it doesn't take long at all (`sudo apt-get install python3-tk`).

Creating your first window is incredibly simple. The following code will get you up and running in no time:

```python
import tkinter as tk

window = tk.Tk()

words = tk.Label(text="I Love Python!")
words.pack()

if __name__ == "__main__":
	window.mainloop()
```

The above code will give you an empty window that will stay open until you close it.

The *window* is our environment, while any content inside of our window is a *widget*, aka the `words` variable. The `mainloop()` method starts the environment, telling Python to run it until the user turns it off.

The reason we have to use `pack` is to ensure the content we want actually appears in our window.

## Widgets

Below are a few different types of widgets;

- `Label`: displays text
- `Button`: displays a button that can have text and do action commands
- `Entry`: displays a text input form for a single line
- `Text`: displays a text input form for multi-line entry
- `Frame`: a rectangular area for widgets or padding between widgets

There are many more widgets, as well as *themed widgets*, which are more updated versions of classic widgets, but we don't need to get into that today.


### Labels

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



### Buttons

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


### Entry

Many, if not all applications work by collecting some input from the user. To start collecting, we can use a really basic text input stream, `Entry`. Combined with a `Label`, and you can create a super basic text-entry form.

```python
name_label = tk.Label(text="Name")
entry = tk.Entry()
name_label.pack()
entrys.pack()
```

This tutorial uses `.get()`, `.delete()`, and `.insert()` to retrieve, edit, and enter information, but honestly at the moment I'm not seeing the relevance? For my project and many projects, I'm not sure why I'd need to edit the text-entry forms. If anything, I'm hoping later it will teach how to enter information and save it when in the main loop.


### Frames

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

#### Adjusting Frame Appearance

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


## Controlling Layouts with Geometry Managers

Tkinter has three *geometry managers*, or methods that define how the content of your app is structured. `.pack()` is just one of them; we also could use `.place()` or `.grid()`. You can only use one at a time, so let's discover the instances in which we'd use them.


### `.pack()`

When using `.pack()`, you're actually using a *packing algorithm* in order to place the widgets on screen. It accomplishes this in two steps;

1. Creates a *parcel*, or a rectangular shape that is large enough for the content within it (the rest of the window is filled with empty space)
2. Automatically centers the widget inside the parcel unless another location is given

We could visualize how this works by using three `.pack()` statements after one another with varying sizes to see how pack will structure our app:

```python
import tkinter as tk

window = tk.Tk()

frame1 = tk.Frame(master=window, width=100, height=100, bg='red')
frame1.pack()

frame2 = tk.Frame(master=window, width=50, height=50, bg='green')
frame2.pack()

frame3 = tk.Frame(master=window, width=25, height=25, bg='blue')
frame3.pack()

window.mainloop()
```

Since we packed our red frame first, that box will appear first. Same goes for our green and blue boxes. Again, we see that since we offered no *anchor point*, we have centered boxes again. 

`.pack()` takes a few useful arguments we should discuss. The first is to use `fill` with `X`, `Y`, or `BOTH`. `X` will fill the window in horizontal directions, `Y` fills the window in vertical directions, and `BOTH` will fill in both directions. Using this feature with hard-coded width and heights is a little tricky. I suggest playing around with different features and seeing what you get. 

Here's what I noticed; 

- When using `fill=tk.X` with a dedicated height and width, it worked as I thought. It also worked as intended with *just* a height, but not with only a width.
- When using `fill=tk.Y` with a dedicated height and width, it **didn't** work the way I thought. I figured it would take up the window as I made it longer, but it stayed it's 100x100 size. I even thought it had something to do with the other frames being packed, but even with them removed I couldn't get it to expand vertically. Even with a solo height and solo width, I wasn't able to get it to work.
	- I ended up having to use another argument, `expand`, and set it equal to `True` to get the fill to actually work vertically
- With `fill=tk.BOTH`, along with `expand=True`, you can nicely get it to expand in all directions. You can even let it rock with no height or width, and it'll function just fine.


### `.place()`

The `.place()` manager uses *exact locations* when organizing and structuring widgets. `.place()` takes two arguments, `x` and `y`. The one thing to be aware of when using `.place()` is that your screens point of origin, or (0, 0), is at the top left of your screen, and the limit of your screen is the bottom most right-hand side.

The following code is an easy example of placing label widgets within a packed frame;

```python
import tkinter as tk

window = tk.Tk()

frm = tk.Frame(master=window, width=150, height=150)
frm.pack()

lbl1 = tk.Label(master=frm, text="I'm at (0, 0)", bg='red')
lbl1.place(x=0, y=0)

lbl2 = tk.Label(master=frm, text="I'm at (75, 100)", bg="yellow")
lbl2.place(x=75, y=100)

window.mainloop()
```


You might notice when running this example, our yellow box is cut off. That's because our *Frame* isn't large enough. We would need to expand it a little bit (perhaps to 200) to actually let it render fully.

This reason is a large part of why `.place()` isn't all that great. Screen sizes vary on multiple different factors (operating systems, size and form-factor, fonts, etc.) making it difficult to account for where something will be compared to other elements. If your locations are relevant to your application thought (think of a map) `.place()` has it's uses.


### `.grid()`

