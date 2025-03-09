---
aliases: 
draft: false
tags:
  - computerscience
  - python
  - tkinter
  - modules
title: Interactive Applications
date: 2025-03-09
updated: 2025-03-09T19:16
---

-------------------------------------------------------------------------------

The above has taught you how to make things appear inside your window. This will only get you so far; the things in your window need to do things. Let's learn about *events*.

# Using Events and Event Handlers

Going back to when we learned about the `window.mainloop()`, the loop this starts is known as the *event loop*. During this, the window will wait for some response. All we have to code is the events that we want to happen in response to these events, otherwise known as *event handlers*.

Tkinter keeps track of all the different types of events that can happen in a window. Given an object `event`, there is an attribute called `.type` which keeps track of the type of event that occurred. You can create handlers that listen for these actions and change something in the window upon action happening.

The window actually keeps track of all the events that happen within it inside of a list, and runs an event handler everything a new event is added to that list.

```python
import tkinter as tk

window = tk.Tk()

# Our event handler
def handle_keypress(event):
	"""Print the character associated to the key pressed"""
	print(event.char)

window.mainloop()
```

The only thing we are missing is the ability to let our window know when exactly it should do this new function.

# Using `.bind()`

There's a method called `.bind()` which tells the given object what to do with a given event, and what function to call given it receives that event.

```python
# Bind keypress to event handle_keypress()
window.bind("<Key>", handle_keypress)
```

This isn't going to do much; it will print out the character you press, but only in the terminal of your IDE. You can use `.bind` on the window like the above example, or to any widget, like in the example below;

```python
def handle_click(event):
	print("ouch")

button = tk.Button(text="Please don't click me")
button.bind("<Button-1>", handle_click)
```

## Using `command`

When binding buttons to a function, the button widgets actually have an easier way of doing this than `.bind()`. We can use the `command` attribute that every button has. 

```python
window.rowconfigure(0, minsize=50, weight=1)  
window.columnconfigure([0, 1, 2], minsize=50, weight=1)  
  
btn_decrease = tk.Button(master=window, text="-")  
btn_decrease.grid(row=0, column=0, sticky="nsew")  
  
number = tk.Label(master=window, text="0")  
number.grid(row=0, column=1)  
  
btn_increase = tk.Button(master=window, text="+")  
btn_increase.grid(row=0, column=2, sticky="nsew")
```

The above will create a simple counter with a button on each side, one for addition and the other for subtraction. The reason we need `sticky="nsew"` instead of any other is so that it'll fill the screen no matter what size it is. It looks a lot better than if you had just used `"e"` or `"w"`. Nothing's really done yet though, we can start writing the functions we need.

Let's tackle addition first. We need to write our function but need the value that currently exists in our label. The only way to access the text of the label is through a dictionary reference, `number['text']` in the case for the above example. That means we need to get the text and make it a number value so we can accurately set the new value with no type errors. Sounds hard, but let's see it in action:

```python
def increase():
	value = int(number['text'])
	number['text'] = f"{value + 1}"

def decrease():
	value = int(number['text'])
	number['text'] = f"{value - 1}"
```

Then, use then by passing them through the `command` attribute upon initialization of the button;

```python
...
btn_decrease = tk.Button(master=window, text="-", command=decrease)
...
btn_increase = tk.Button(master=window, text="+", command=increase)
```


# Making a Text Editor

This is a really fun task, and can definitely be customized to your liking depending on how you can dream it up. Due to it's simplicity, we can use a simple grid structure to accomplish 3 main tasks: open a file, edit a file, and save the changes made to a file.

Not only should it be able to do these three things, but it should look nice and clean. When resized, your editor should resize as well. An 800x800 window is a great place to start, and we can mimic their example of a thin left column and wide right column to begin. As an added challenge, you can try to replicate the Microsoft word and Google Docs have of a thin top strip instead.

Let's look at the code, then talk about it after:

```python
import tkinter as tk  
  
window = tk.Tk()  
window.title("Text Editor")  
  
window.rowconfigure(0, minsize=800, weight=1)  
window.columnconfigure(1, minsize=400, weight=1)  
  
edit_text = tk.Text(window)  
button_frame = tk.Frame(window, relief=tk.RAISED, bd=2)  
open_button = tk.Button(button_frame, text="Open...")  
save_button = tk.Button(button_frame, text="Save As...")  
  
open_button.grid(row=0, column=0, sticky="ew", padx=5, pady=5)  
save_button.grid(row=1, column=0, sticky="ew", padx=5)  
  
button_frame.grid(row=0, column=0, sticky="ns")  
edit_text.grid(row=0, column=1, sticky="nsew")  
  
window.mainloop()
```

All of this is as we've seen; pretty standard stuff. The only thing I want to explain is the `minsize=400` attached to the window column configuration. This setting will tell your editor the size you'll allow the text to wrap too: the lower the number, the thinner your user can make their window. This can be left at the default 800, but I changed it to 400 to make it a little more flexible.

Obviously, all we've done is create the environment. We haven't made any of the functionality yet. Let's start with the open feature, since that's likely where your user will start;

```python
def open_file():  
    file_path = askopenfilename(  
        filetypes=[("Text Files", "*.txt"), ("All Files", "*.*")]  
    )
    if not file_path:  
        return  
    edit_text.delete("1.0", tk.END)  
    with open(file_path, mode="r", encoding="utf-8") as input_file:  
        text = input_file.read()  
        edit_text.insert(tk.END, text)  
    window.title(f"Text Editor - {file_path}")
```

Tkinter has it's own way of obtaining a file path; it can open up file explorer window for you to choose your own text file. We have to import this option with `from tkinter.filedialog import askopenfilename`. We choose we file types we want it to ask for, then if we get a file we can open, delete any text currently in the box, and replace it with the text we got from the file we chose. We also change the title of the window to reflect the file we got.

The save feature is nearly identical, with a different Tkinter library. This time, we'll use `asksaveasfilename`, which does the same thing as the last one we just described with saving instead of opening.

```python
def save_file():  
    file_path = asksaveasfilename(  
        defaultextension=".txt",  
        filetypes=[("Text Files", "*.txt"), ("All Files", "*.*")],  
    )
    if not file_path:  
        return  
    with open(file_path, mode="w", encoding="utf-8") as output_file:  
        text = edit_text.get("1.0", tk.END)  
        output_file.write(text)  
    window.title(f"Text Editor - {file_path}")
```



