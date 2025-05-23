---
aliases: 
draft: false
tags:
  - computerscience
  - python
  - classes
title: Inheritance
date: 2024-11-11
updated: 2024-11-16T10:30
---

-------------------------------------------------------------------------------


According to the AI road map I've been following, this and the rest of the concepts in this folder are meant to be considered more advanced concepts. Some of these have been covered in the [Python Tutorial]({{< ref "The Python Tutorial Notes - Chapter 1, 2, and 3" >}}), some have not. This is the starting note, but I won't link these concepts together unless necessary, as the concepts aren't explicitly tied together.

# What is Inheritance?

Inheritance is the concept that you can build a new class based off of, or *derived* from, an existing class. You can actually build one based off many, and the syntax is as follows;

```python
class NewClass(BaseClass, AnotherClass):
	<statement-1>
	...
	<statement-n>
```

Remember, we use capital letter for our class names in this instance not because we have too, but because it's best practice. 

The new class has access to the same class methods as the original base class(es), as well as any new methods created in the new class definition. You could even override base methods, for multiple different reasons. 

Let's look at a really basic example I came up with;

```python
class Person:  
    def __init__(self, name, age):  
        self.name = name  
        self.age = age  
        self.goals = []  
  
    def __repr__(self):  
        return f"My name is {self.name} and my age is {self.age}"  
  
    def print_goals(self):  
        print("I'd really like to...")  
        for goal in self.goals:  
            print(goal)  
  
class Student(Person):  
    def __init__(self, name, age):  
        super().__init__(name, age)  
        self.goals = ["Finish School!"]
```

We have a starter class, `Person`.  `Person` has three methods, `__init__`, `__repr__`, and `print_goals`. We created an additional class, `Student`, who only has an `__init__` method that overrides the `Person` classes own `__init__`. This is done to ensure every student created, has a default goal set to `"Finish School!"`. An arbitrary example, but it does the job. 

Another important note is that any `Student` object will have access to `print_goals`, since that method exists in the parent class.
