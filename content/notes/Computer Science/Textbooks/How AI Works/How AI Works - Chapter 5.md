---
aliases:
draft: false
tags:
  - computerscience
  - AI
  - textbook
  - machine_learning
title: How AI Works - Chapter 5
date: 2025-12-28
updated: 2025-12-28T12:58
---

-------------------------------------------------------------------------------

# Convolutional Neural Networks: AI Learns to See

While the last chapter toted how advanced neural networks were, they weren't always able to select the correct features, determining the right amount of dimensions, along with their inability to learn, lead to our next topic; *Convolutional Neural Networks*. What they do differently than the networks we looked at in the last chapter is they actually generate new representations of their inputs while also being able to classify them. This is called *end-to-end learning*. 

CNN's learn based off of the structure of it's inputs. For the sake of keeping it simple, we'll focus on just two-dimensional structures, or images. The combination of the inputs actually matters here; Sending in `x0, x1, x2` will yield a different result than `x2, x1, x0`, helping the network understand the training data more. The network breaks the inputs down into smaller, easier-to-digest portions. These layers aren't always human-readable, almost always not. 

