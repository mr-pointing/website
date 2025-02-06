---
aliases: 
draft: false
tags:
  - computerscience
  - textbook
  - syntax
title: CPL - Chapter 5
date: 2025-01-28
updated: 2025-02-04T18:47
---

-------------------------------------------------------------------------------

# Names, Bindings, & Scope

We should understand that in across programming languages, like when we use the term *identifier* or *name* (both are synonymous), it depends on the language we are using. Different languages have different naming conventions and rules or **syntax**. We'll look at variables in this chapter, and the different parts their made out of;

- Name
- Address
- Value
- Type
- Lifetime
- Scope

## Bindings

A *binding* is an association between an attribute and an entity, such as between a variable and it's type or value, or between an operation and a symbol. We consider the moment where the binding takes place appropriately as *binding time*. Before any variable can be reference, it must be bound to a data type (which will be covered in the next chapter). 

Here's a very a basic sample in C++:

```c++
count = count + 5;
```

Let's review some key details going on behind the scenes:

- *Count's Type?* Bound at compile time
- *Meaning of +?* Bound at compile time, after operands have been determined
	- Quick interjection on my notes; the difference between "compile time" and "compiler design time" is compile time is the event of source code into machine code, while compiler design time is the literal design on the language
- *5's meaning?* Bound at compiler design time
- *Count's Value?* Bound at execution time

A **static binding** refers to when a binding occurs before run time begins, and remains unchanged throughout execution. Whereas a **dynamic binding** refers to when a binding occurs during runtime or can change through the course of it's execution. 

### Static Type Binding

Two types of declaration: *Explicit declaration*, when there exists a statement in a program that lists variable names and specifies they are a particular type, and *Implicit declaration*, when you associate variables with types through default conventions, rather than declaration statements, using type inference. Think C++ (explicit) vs. Python (implicit).


### Dynamic Type Binding

Here, the variable is bound to a type when it is assigned a value in an assignment statement. The variables type can change any number of times during execution. 

Dynamic binding does have benefits, allowing for a more broadly built program for situations where the type of a value isn't relevant. However, this does present a few issues, as there now more potential for type errors, and is more costly leading to longer execution times.

Dynamic binding uses pure interpreters, while static bindings use compilers.

### Storage Bindings & Lifetime

A few terms to understand:

- **Allocation**: the process in which a memory cell is bound to a variable from a pool of available memory
- **Deallocation**: the process of placing a memory cell that has been unbound from a variable back into the pool
- **Lifetime**: The time during which the variable is bound to a specific memory location.

We can break down scalar variables into four different categories based off their lifetime, Static, Stack-Dynamic, Explicit Heap-Dynamic, & Implicit Heap-Dynamic.

1. *Static Variables*: One that is bound to a memory cell before program execution begins & remains bound to that same memory cell until program execution terminates
	- Overall these are most useful as global variables, accessed across the program without changing
	- They're efficient, addressing is direct so the cost of run time is low, and there's no run time overhead for allocation/deallocation 
	- Unfortunately this leads to reduced flexibility, no ability for recursion over them, and storage cannot be shared amongst variables
2. *Stack Dynamic Variables*: Those whose storage bindings are created when their declaration statements are elaborated, but whose types are statically bound
	- When the storage allocation & binding process occur based off of a declaration, usually run-time
	- **Stack dynamic variables are allocated from run-time stack**
	- This allows for recursive subprograms
	- Downsides are the run-time overhead of allocation/deallocation, slower access, and subprograms cannot be history sensitive
	- C, C++, & Java use dynamic-stack variables as default for method calls
3. *Explicit Heap-Dynamic Variables*: nameless (or abstract) memory cells that are allocated & deallocated by explicit run-time instructions written by the programmer
	- These can only be referenced via pointers or reference variables
	- Bound to a type at compile time, which is static
	- Bound to storage during run-time
	- These are often used to construct dynamic strucures
	- However, using pointers & reference variables correctly can be challenging, and storage can be complex
4. *Implicit Heap-Dynamic Variables*: Bound to heap storage only when they are assigned values, all attributes are bound every time they are assigned
	- Ex: `highs = [74, 84, 86, 90, 71]`
		- Regardless of it's actually used or not, `highs` is now an array of numeric values
	- Of all types, implicit heap-dynamic variables have the highest degree of flexibility and highly generic looking (good thing)
	- There is a cost for all of the run-time overhead maintaining all dynamic variables, and there is a loss of error detection on the compiler side

## Scope

*Scope* is formally defined as the range of statements in which a variables if visible, or if it can be referenced or assigned.

*Static scope* is the method of binding names to nonlocal variables; the scope of a variable can be statically determined (prior to execution). Generally two categories; nested & non-nested. 

*Static parent* is where the program or subprogram that declares a sub program inside it. 

```Java
function big(){
	function sub1(){
		var x = 7;
		sub2();
	}
	function sub2(){
		var y = x;
	}
	var x = 3;
	sub1();
}
```

In the above example, the `x` inside function `sub2` is actually going to be equal to 3, not 7. New static scopes can be defined during code execution in some languages.

### Blocks

*Blocks* are sections of usually stack dynamic variables; storage is allocated when the section ins entered, and deallocated when exited. 

**Declaration Order**: In some languages, all data declarations must occur in the beginning of the function. Others, don't care so much. Certain languages will not allow the use of a variable before it's declaration.

*C++ and Java?* The scope of all local variables if from their declarations to the ends of the blocks in which those declarations appear.

Some variables have a *global scope*, which means they are defined outside of functions (in main) which are potentially visible to other functions. 

When we use the word **declaration**, we mean specifying types & other attributes without allocation memory or storage. When we say **definition**, that actually specifies attributes *and* storage allocation.

Different languages have different ways of declaring a global variables. In C, `extern` can be used to make a global variables visible to a function if the variable is declared after the function. In C#, `::` is used to access global variables hidden by local variables. In PHP, all variables declared outside of a function is considered a global variables accessible in two ways;

1. Function can create a variable of the same name in the function the `global` preceding it
2. Function can create a variable and use the `$GLOBALS` array with the subscript as the index

In general, static scoping is unnecessarily complicated, hard to read, rigid, and overall awkward to use.

### Dynamic Scoping