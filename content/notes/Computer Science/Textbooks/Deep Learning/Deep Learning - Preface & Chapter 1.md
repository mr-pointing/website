---
aliases: 
draft: false
tags:
  - computerscience
  - AI
  - machinelearning
  - textbook
title: Deep Learning - Preface
date: 2024-10-25
updated: 2024-10-31T10:27
---

-------------------------------------------------------------------------------

# Preface
## MIT Press Online Edition

### Ian Goodfellow, Yoshua Bengio, and Aaron Courville

[Link](https://www.deeplearningbook.org/) to the book.


# Chapter 1

## Introduction

This book is intended to prepare you for concepts and theory used in Machine Learning and Artificial Intelligence, more specifically *deep learning*, or the multi-layered stacked concepts that make up the intelligence of an AI model. 

Like most textbooks, it goes into the why of AI, and what they do best; solving problems that humans are generally not good at. AI was designed to tackle these problems, problems that are generally abstract or formal.

AI start with the information that they're trained or, or their *knowledge base*. These are the hard-coded pieces of data that provide the computer with context. Just using the knowledge base however proved that there were issues not being addressed; how often should the knowledge base be updated? If it's been a while, the information can become unreliable, making it useless.

The process of allowing a computer to extract information from raw data, and having it use that information to come up with new answers, is the process we call *Machine Learning*.

The *representation* of the data, or how the data points are fed to the machine, is important. The book uses the great example of the AI actually communicating and observing a patient, but rather using attributes of the patient given via data points.

For example, *logistic regression* can determine if a child should be delivered via cesarean or not. Rather than the AI being thrusted onto the patients lap and it "scans" them like in a sci-fi movie, the doctor will feed the AI some characteristics about the patient (aka a *feature*), then it can make it's predication.


## Features

One of the most difficult parts of this process is deciding which feature is relevant, and which aren't. Not only that, but the way our data is represented is also difficult to determine. *Representation Learning* has algorithms that can be used to grab important and deterministic features.

*Autoencoders* are algorithms that have a **encoder** and **decoder** function, which can show input in a new representation that might be more efficient to learn from.

When attempting to choose or design features, what we're actually trying to do is find our *Factors of Variation*, or the aspects/concepts that help us make sense of the data. For example, when looking to identify speech, the factors of variation are the age, sex, and accent of the speaker. 

Of course, the more we analyze things that happen in our daily life, we learn quickly that many, many factors of variation make up any given example. The hard part is identifying which of these factors are the most important. 

This is where deep learning gets involved; we can use the simpler concepts to teach agents, or AI models, more complicated concepts. One example we can look at is *Multilayer Perceptron's*, or an **MLP**. Essentially, it's a mathematical function mapping that connects input values to output values, made up of the small simple concepts we defined before. These simple concepts come together to make prediction's on a more complicated level. 

There are two main ways to measure depth of a model:

1. The amount of steps executed (think algorithms)
2. How complex the connections between concepts are

We can also simplify this into depth of computational graph (1) versus depth of the probabilistic modeling graph (2).

Deep learning falls into the sub-category of representation learning, which is a sub-category of machine learning.


## Who is This Book For?

Pretty much who I expected; university students and software developers who want a fast track into Deep Learning. I fit somewhere in the middle; a post-graduate school educator looking to learn more about the field to land a tech job. I'm honestly just reading this for Part 1, which is all pre-requisite math information that I need for many other aspects of my education, but I might end up going through the other parts later.

To be specific, this book walks through Linear Algebra, Probability, & Numerical Computations before getting into ML basics.

## History

To go over it briefly, deep learning went by a few different names before becoming what it is today. From the 50's to the 80's it was known as *cybernetics*, and from then to around 2006 it was known as *connectionism*.

Since deep learning is heavily connected to how the brain functions, people have also called deep learning *artificial neural networks (ANN)*. While the resemblance is clear, these designs are generally not designed with the intention of replicating biological function. We should look at deep learning to understand multiple layers of complex content, rather than imitating human anatomy (also, humans know so little about how to the brain functions, it's not a great model to base new technologies on).

The first models of deep learning were basic linear functions, that make simple predictions based on some input data. We call these *linear models*, and are still used commonly today. However, they have their own limitations being that they're so basic. 

After neuroscience faded from the frontlines, the movement of connectionism, or *parallel distributed processing* became relevant. It really is the precursor to representational learning; simple computational units can come together to perform more complex and "intelligent" calculations.

Once 2006 hit, there was another machine learning evolution, with the introduction of the *deep belief network* which we can analyze later. More importantly, the actual algorithms themselves didn't differ much from the 80's to the early 00's. The difference, however, came in the form of more training data.

More training data allowed for more access to these deep learning algorithms; one did not need to be as savvy to get desired output from these algorithms since they could be trained faster and more efficiently than before. 

>[!fact]
> We consider a model to have an acceptable performance with around 5000 examples per category, and at or above human performance with 10 million examples

Not only do we have more training data, we have more processing power to actually do more training. Computers used to take up entire buildings with maybe 8 gigabytes of storage; phones now sit nicely in our pockets with triple, if not quadruple the amount of space. We have faster and more available CPU's and GPU's.

The accuracy and complexity of these models have, over time, also gotten better. Models are able to learn through trial and error without human intervention in a process called *reinforcement learning*, and the error rate from models aging has steadily decreased in many areas.


---
Next: 
[Chapter 2]({{< ref "Deep Learning - Chapter 2" >}}) 
