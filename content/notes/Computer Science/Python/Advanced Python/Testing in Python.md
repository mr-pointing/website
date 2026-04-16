---
aliases:
draft: false
tags:
  - computerscience
  - python
  - testing
title: Testing in Python
date: 2026-03-31
updated: 2026-04-14T06:55
created: 2026-04-01T09:16
---

-------------------------------------------------------------------------------

# Testing Code

[Link](https://realpython.com/python-testing/) to article.

While testing in Python can and is a complicated topic, we don't have to go too deep into it while still being able to accomplish a good amount of testing. Obviously, up until this point you should have a basic understanding of the application you created, as building out a good test means  using your program as intended, sometimes even more so to be rigorous. 

## Types of Testing

Most people when writing any kind of code will stop at some point, run the code, and check to see if what they wrote so far actually runs and makes sense. This *is* a form of testing, just a more informal approach; this method is known as **exploratory testing**. This approach works, but is not nearly enough to ensure your program is able to stand on it's own two legs. It's informal for a reason, there is no plan in mind just making sure it runs. 

If we wanted to really make sure things are working properly, we should set up a system where we control everything down to a science, and ensure runs pass consistently. However, doing this manually can become a lot quickly. A good project has more than just 1 or 2 things going on. Once you pass 4-5+ things going on at any point, you start to lose track and can easily make mistakes. Why go through the hard work of writing the code when you now have an even more challenging job of tracing it through with 5 or more examples? 

What we just described is considered **Manual testing**. We don't want to manual test past a certain point. We're going to want to move from manual to **Automatic testing**. This way, we'll write out exactly how we expect to interact with our program, as well as anticipate output and check it to see if it's giving out desirable results. We'll write this script using a few modules and functions built directly into Python.

Before we do that though, let's explore some more terminology that might become more relevant. Each portion of your program you want to test is called a *test step*, and checking step for a correct response is called *test assertion*. The collection of multiple test step components is called **integration testing**, and as you can imagine is extremely important when programming, considering how many components are working in tandem. Here arises another problem; say we're testing 10+ components, and one or two fail. How do we know why those specific parts failed? That's not necessarily the integration tests job. This type of job is more up the alley of the **unit test**, or smaller isolated test that operates on a single component. 

The complexity of your test relies on the complexity of your program. For example, let's say we want to ensure the output of a mathematical function like the `sum()` function. We can write the following as our first simple unit test;

```python
>>> assert sum([1, 2, 3]) == 6, "Should be 6"
```

If you ran the above code, nothing should have happened. There's a good reason for this; 1 + 2 + 3 equals 6! If it didn't, then we'd have a problem. Try changing one of the numbers to something else, and see what you get. If your numbers do not equal 6, you likely got a traceback `AssertionError`. That's a good thing, our unit test is working as intended. However,  a single line is not enough once we start testing entire projects. Here's a nice basic skeleton we can use;

```python
def test_sum():
	assert sum([1, 2, 3]) == 6, "Should be 6"
	
if __name__ == "__main__":
	test_sum()
	print("All test cases passed!")
```

Save this as something like `test_sum.py`, and if you run it getting the final print statement you know everything is working as intended. We can even begin to start writing other functions;

```python
def test_sum():
	assert sum([1, 2, 3]) == 6, "Should be 6"
	
def test_sum_tuple():
	assert sum((1, 1, 2)) == 6, "Should be 6"
	
if __name__ == "__main__":
	test_sum()
	test_sum_tuple()
	print("All test cases passed!")
```

## Test Runners

Before we get into what a test runner is, the article I'm following suggested also looking into [doctest]({{< ref "Testing with Doctest" >}}) as another option, where you write the tests as part of your module's docstrings. I haven't looked into it as of writing this note, but I'm putting is here as a reminder to look into it more later.

A test runner is just a method of running tests and collecting the output, delivering advice on how to address your problems, or debug. There are multiple options for test runners, but let's start with what's natively built into Python. That would be using `unittest`. It includes both a testing framework *and* test runner. 

To start using it, two things must be true;

1. Your test cases are placed in classes as methods
2. Instead of using `assert`, you'll use the `unittest.TestCase` class

To see exactly how to accomplish this, let's reconfigure that `test_sum.py` file to use `unittest` and call it `test_sum_unittest.py`;

```python
import unittest

class TestSum(unittest.TestCase):
	
	def test_sum(self):
		self.assertEqual(sum([1, 2, 3]), 6, "Should be 6")
		
	def test_sum_tuple(self):
		self.assertEqual(sum((1, 2, 2)), 6, "Should be 6")
	
if __name__ == "__main__":
	unittest.main()
```

As you can see, since we want to check for equality, we use the `assertEqual()` method. There's a whole list of asserts [here](https://docs.python.org/3/library/unittest.html#assert-methods), which we'll come back to in a second. As you start to write more complex programs, you'll find more use for more complex asserts than just equality. Now that we've written out a `unittest`, run the code and see what you get. You'll see a "list" of tests; `.` if it passed and `F` if it failed. We should only have two items in this list, one `.` and one `F`. Be sure to read over the documentation on this if you want more examples.

There are two other relevant runners, `nose2` and `pytest`. What's really nice about these two are the quality of life changes; `nose2` works on top of `unittest`, meaning you should learn `unittest` first before moving onto the other two, on top of `pytest` being even easier to write. The main draws to learning and using these two are how much easier it is to decipher the error messages for failed tests. As your test cases increase, `unittest` starts to become harder to parse. Both also have nice discovery methods of finding test cases without having to directly tell the runner where to find them.

## Writing a Python Test

Although we've looked at how to use Python testing, all we've tested up until this point are built-in functions that should be working regardless of our expected output. Let's build something a little more realistic; we're going to write some code, then build out another testing environment our test cases will live inside of.

Set up a new project environment (preferably in PyCharm to best follow along but we take what we can get). Let's create our own sum function, in a new file called `our_sum.py`;

```python
def new_sum(numbers):  
    total = 0  
    for num in numbers:  
        total += num  
    return total
```

Now, we should define a main environment to run out tests;

```python
import unittest  
  
from our_sum import new_sum  
  
  
class TestSum(unittest.TestCase):  
    def test_list_int(self):  
        """Test to see if it can add up a list of integers"""  
        data = [1, 2, 3]  
        result = new_sum(data)  
        self.assertEqual(result, 6)  
  
  
if __name__ == "__main__":  
    unittest.main()
```

What's super nice about running this through PyCharm is how PyCharm will recognize it's trying to run a test, and will actually look a bit different than a normal run. This is an additional layer on top to help you understand the output of your test cases. 
