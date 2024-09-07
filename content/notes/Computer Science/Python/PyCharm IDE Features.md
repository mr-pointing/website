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
updated: 2024-09-01T10:14
---


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
	1. Ex. `def sum_list(num_list: list) -> list:`
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


8/12/2024

## Code Completion

Exactly what you think; PyCharm doing it's best to complete your snippets. Sometimes awesome, other times frustrating.

### Basic Completion

Out of the gate, you can begin using completion. As soon as you type PyCharm will begin prompting what it thinks you might want to use. You can move your cursor down and hit enter on whatever you want from it's list. The more you type, the more specific the request.

You can also use `Ctrl` `Space` anywhere to activate it.


### Tab Completion

In situations where you've moved your caret over a variable you want to change and you get completions. You can use `Tab` instead of `Enter` to replace the word after the caret instead of entering it before it.


### Postfix Completion

Let's say you have a variable you just grabbed from a dictionary. If you know you're going to need that value for some statement, you can type `.if`, `.for`, or `.while` to throw it into a structure using the variable as the argument. I'm sure there are more, but that's all I need to worry about for now.


### F-string Completion

Just like the other completions, when filling out an f-string variable, you can use auto-completion there as well.


8/16/2024

## Refactoring


### The Refactoring Menu

The refactoring menu can be opened anytime using `Ctrl` `Alt` `Shift` `T`. One example they used was the following:

```python
import random

def foo(x, random):
	print(x + random)
```

If I wanted to pass in the random module as a parameter instead of as the entire library, we can use our Refactoring Menu to chose option 5, or Introduce Parameter, to automatically create one for us. The above will become like so:

```python
import random

def foo(x, r=random):
	print(x + r)
```

You have the option to leave it as r (probably will be the first letter in the name) or name it whatever you'd like.


### Rename

When you need to rename a variable within a file, you can move your caret over the variable and press `Shift` `F6`.

The renaming tool will let you type in what you want to replace it. If there are only one reference of the name, it'll pass through no issue. However if you have multiple references with the same name, say in different classes in the same file, PyCharm will warn you and ask to clarify what you want to refactor.


### Extract Variable

There are often moments where we are using some value, like in the example below:

```python
nums = [10,2,14,3,5]
for i in range(0, 10):
	if nums[i] > nums[i+1]:
		nums[i], nums[i+1] = nums[i+1], nums[i]
```

In this situation, `i+1` could become a variable. If we use `Ctrl` `Alt` `V` when our caret is over `i+1`, we are given an option to replace the instance or all occurrences of the pattern. The previous example will now look like:

```python
nums = [10,2,14,3,5]
for i in range(0, 10):
	num_var = i+1
	if nums[i] > nums[num_var]:
		nums[i], nums[num_var] = nums[num_var], nums[i]
```

You can do the same thing with methods instead of variables, using `Ctrl` `Alt` `M`, but for whatever reason the macro wouldn't work for me? I had to use my mouse to open it manually. Let's refactor the example above:

```python
nums = [10,2,14,3,5]
for i in range(0, 10):
	num_var = i+1
	if nums[i] > nums[num_var]:
		swap_vals(nums, i, num_var)

def swap_vals(nums, i, num_var):
	nums[i], nums[num_var] = nums[num_var], nums[i]
```

Not the best example, but for demonstration purposes it does the job.


### Quick-Fix Refactoring

Not much of an example here since it's a general tip, but we can use Quick-fix (`Alt` `Enter`) to help us with refactoring. Always remember to use quick-fix when we have yellow or red lines under our code.


### In-place Refactoring

Let's say you have the following example:

```python
q = "What is your name?"
a = input("Enter your name: ")

print(f"Welcome to the world, {a}!")
``` 

If you want to rename the use of `a` to become `answers`, you can just start typing the new name. PyCharm will pick up that you are renaming a used variable. When you are done typing the name, you hit `Alt` `Enter` to auto refactor all uses.


## Code Assistance

### Restoring Removed Code

Often we'll remove some piece of code, and end up finding out later or even in a few lines that we need that code chunk. Thankfully, PyCharm keeps all of your files changes locally. At any time, you can right-click and choose `Local History` -> `Show History`.


8/27/2024

### Code Formatting

I cannot stress this enough, that code is increasingly more difficult to read the more out of sorts it looks. To keep your code looking nice and neat, you can use `Ctrl` `Alt` `L` to "lint" the file. This will format the code to have consistent line and character spacing, and even give you some more advanced options like *Optimizing Imports*.


### Parameter Info

This is super small, but so so helpful. I can't wait to use this feature when doing projects of my own. Regardless, if your caret is in a method's parenthesis, you can hit `Ctrl` `P` to view the method's signature, or *required parameters*. When just learning a programming language, it can be difficult to remember how many arguments each function takes. I definitely want to implement this in my lesson planning this year.


### Quick Popups

One new addition to writing functions I want to start with this year is using a documentation string at the beginning of a function, like so:

```python
def print_three_times(value):
	"""
	Prints given thing three times.
	"""
	...
```

Getting used to this will help, since if you use your caret over the call of `print_three_times()`, and hit `Ctrl` `Q`, you'll get a little popup showing a nice representation of the documentation string. `Ctrl` `Shift` `I` will show you the entire definition rather than just the doc string.


### Editor Assistance Workflow

Like we've already seen, we can do a lot with `Alt` `Enter`. We can also get deeper dives into error messages by using `Ctrl` `F1`, which will tell us more than one line of detail. The best way to navigate through your errors is not by using the mouse, but hitting `F2` to move from error to error.


## Navigation

### Search Everywhere

At any point during a project, you can hit `Shift` twice to open up the **Search Everywhere** tool. If you need to find something, type what you're looking for, use the arrow keys to navigate to what you need, and hit enter to get there.

Sometimes though, we want to search for specific things. In this case, we can use `Ctrl` `N` to search for classes. We'll explore some more as we go.


### Find and Replace in Files

Find and Replace seems useless until you really need it. When you have a large enough project, sometimes the changed variable name isn't an easy couple lines of edits. Missing one or two will cause unneeded frustration.

`Ctrl` `Shift` `F` will open the **Find in Files** window. It's actually a really neat feature that is more complex than it seems. The tutorial has a great example; let's say we want to search for a string like `apple`, but since `pineapple` has `apple` in it, that will also get picked up. To avoid that, we can hit `Alt` `W`, or click `W` in the window, to strictly search for only the word `apple`.

Once you know what you want to replace, you can hit `Ctrl` `Shift` `R` to open up the **Replace** window (just an add on to the Find In one) and type whatever you'd like to replace your text with. You can also determine the scope of your changes; if you want to change all occurrences in a file, directory, project, etc.


8/31/2024

### Declarations and Usages

Whenever your caret is on the use of a function or method, you can use `Ctrl` `B` to jump to the declaration of said method.

Likewise, when your caret is over a declaration, you can use `Ctrl` `B` to see all of it's usages.

If you want a more detailed view on your usages and declarations, you can use `Alt` `F7`, which for some reason wasn't working on my machine. I had to change it to `Windows`, `F7` instead. Now that's working, we can use this view to see both usages and declarations at the same time.

If you want too, you can pin that view to your window by right clicking the header of the view, then choosing pin. At anytime you want to hide the view, you can hit `Shift` `Escape`. Since this view is apart of the `Find` view, we can just use `Alt` `3` to open it back up.


9/1/2024

### File Structure

the structure of our code is obviously very important. Sometimes, when working on larger projects, you'll want to take a quick look at the entirety of said structure for any number of reasons. One of the most 


