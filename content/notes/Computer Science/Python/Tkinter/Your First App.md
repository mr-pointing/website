---
aliases: 
draft: false
tags:
  - computerscience
  - python
  - modules
  - tkinter
title: Your First App
date: 2024-10-27
updated: 2025-03-09T19:17
---

-------------------------------------------------------------------------------

[Link](https://realpython.com/python-gui-tkinter/) to the tutorial.



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



---
Next: 
[Widgets]({{< ref "Widgets" >}}) 


