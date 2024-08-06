---
aliases:
  - python
  - IDE
draft: false
tags:
  - computerscience
  - python
  - IDE
  - documentation
title: PyCharm IDE Features
date: 2024-07-09
---
Modified: July 23 2024 

-------------------------------------------------------------------------------

### Get Acquainted with PyCharm

1. The project view is one of the main tool windows, containing the project directory, external libraries, and scratch files. You can also open it with `Alt` `1`.
2. The Python interpreter is easily viewable in the status bar in the bottom right.
3. You can run, debug, or other option on the top right of the window. You can also press `Shift` `F10`.
4. We got an unexpected error in our code, featured below. We can place stop at the return statement to debug our code and see what's wrong. After placed, use the debug option (lil green bug).

```python
def find_average(values):
	result = 0
	for v in values:
		result += v
	return result
print("AVERAGE", find_average([5,6,7,8]))
```

5. There is a debug workflow lesson later on we can do.
6. When hitting `Alt` `Enter` on something, that's called performing a quick fix. You can quick fix formatting issues, and even functions to add intentions.
7. **Intentions are specifiers added to functions to define what type of return object is expected.**
8. Shift twice on anything will open the Search Everywhere dialog, where you can do things with the selected text like case it or something else.

## Editor Basics

### Context Actions

1. `Alt` `Enter` invokes the Show Context Actions.
2. We can do things like remove redundant parameters, or change the format to professional standard. 

### Search for actions

1. `Ctrl` `Shift` `A` will Find Action.
2. Same action as double `Shift`. You can search for 'about' to find out info on PyCharm.
3. We can even edit IDE settings, like line number visibility.

### Expand and shrink the code selection

1. `Ctrl` `W` to select the word under the caret, and you can continue to press it to move outwards to the entire call.
2. `Ctrl` `Shift` `W` will work the other way around, shrinking down to a single word.

### Comment Line

1. Comment any line using `Ctrl` `Slash`. You can uncomment using the same command.

### Duplicate and Delete Lines

1. Press `Ctrl` `D` wherever your caret is to duplicate it to another line below it. You can also duplicate multiple lines at the same time.
2. You can press `Ctrl` `Y` to delete the current line.

### Move Code Fragments

1. You can move whole lines down using `Alt` `Shift` `DownArrow`. You can move whole lines up using `Alt` `Shift` `UpArrow`.
2. You can also move whole methods down, but replacing `Alt` with `Ctrl`.

### Collapse

1. We often have to collapse code quickly for the sake of readability. We can use `Ctrl` `Minus` to collapse anything we are currently in.
2. `Ctrl` `Equals` will expand a code region.
3. `Ctrl` `Shift` `Minus` will collapse all collapsible code in the file.
4. `Ctrl` `Shift` `Equals` will expand all expandable parts of the file.

### Surround and unwrap

1. You can select a piece of code, and use `Ctrl` `Alt` `T` to bring up the surround with template feature. You can choose from a few structures like `if`, `while`, and `try`.
2. You can unwrap using `Ctrl` `Shift` `Delete`.\

### Multiple selections

1. Let's say you have a bunch of `<th>` tags that need to be `<td>` tags. We can use our caret to hover over what we want, then use `Alt` `J` to select it.
2. From there, we can use `Alt` `J` again to select the next occurrence, `Alt` `Shift` `J` to deselect the last selected occurrence, and `Ctrl` `Alt` `Shift` `J` to select all occurrences of it.