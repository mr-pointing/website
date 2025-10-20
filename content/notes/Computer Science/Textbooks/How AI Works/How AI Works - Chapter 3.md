---
aliases:
draft: false
tags:
  - computerscience
  - AI
  - textbook
  - machine_learning
title: How AI Works - Chapter 3
date: 2025-09-30
updated: 2025-10-20T19:29
---

---

# Classical Models: Old-School Machine Learning

Obviously, we need to start with baby steps. No one picks up a new hobby and starts with the most advanced material. We're going to look at 3 of what we call the _classical_ models; neither symbolic nor connectionist AI models that aren't as advanced as any of the neural networks we'll take a peek at in chapter 4.

## Nearest Neighbor

This model is so simple, that the training data is the model, meaning there is no training. If you get an unknown input, you classify it to what it's closest too, and that's that. Regardless, they're still super useful, and are a good representation of actual real life data.

The step up of nearest neighbor is _k-nearest neighbor_, where _k_ is some number (usually 3, 5, 7, etc.) representing the amount of neighboring data points it will compare against. For unknown input, a voting system is used by the model to decide which of the classes it belongs too. If there's a tie, a random one is selected (resulting in 50/50 shot). Take the following graph for example;

{{< image src="/images/knn_pre.png" alt="knn_pre" position="center" style="border-radius: 8px;" >}}

We have three different classifications here. As you can see though, they're pretty intermingled, and it's difficult in some areas what we'd classify each as. Now, let's introduce two new shapes; a triangle and a pentagon. Then, we can draw lines to the nearest shapes to help us classify. Let's use three;

{{< image src="/images/knn_post.png" alt="knn_post" position="center" style="border-radius: 8px;" >}}

Now we can make our classifications. The triangle belongs to the squares, since it's a clear majority of all three squares. The pentagon belongs to the diamonds, with a 2 to 1 win over the squares. This was also an easy example because we're able to graph it using only two dimensions, meaning it only has 2 features. It's entirely possible to have more though. We can use KNN with our MNIST data set; in that case, it would be a vector of 784 elements for each of the pixels, with 60,000 training examples, or points in space. KNN is unfortunately pretty slow though, since it has to calculate all the distances in the set.

KNN also has an interesting effect when observing how the amount of data points and dimensions reflects on the models accuracy. If we provide the model with all of the available training data for our MNIST set, we would get close to 99% accuracy. As we decrease the amount of data, obviously it gets worse, but not all that bad. With only _60 samples_, which may or may not even contain all of the digits available (likely not), you'll get a whopping 66% accuracy. Pretty good, and way better than a random guess.

There's also this odd phenomena with a data set so large; **the curse of dimensionality**. Basically, the more dimensions there are, the more samples needed for accurate readings. Fortunately, because of the makeup of our dataset, our points will likely be clustered together. 5's look like 5's, and so on, making our classification easier than other data sets. If you want an example of how hard it is to scale KNN to more complex images, the CIFAR-10 data set is comprised of 50,000 images of 10 different classifications (cars, animals, etc.). A model with all 50,000 images is only accurate **35.4%** of the time. Not great.

## Decision Trees

We did one of these in chapter one, so let's expand on them a bit more here. Everything starts at a root node, and conditional yes or no questions await each branching path. This is repeated until a final node called a leaf node is found, containing a classification or a label for whatever is getting classified.

These types of decision trees are what we call _deterministic_, or stay the same every time upon input. This is often not the most reliable upon complex data, so the need for _forests of trees_ arose. One step further, since each tree is deterministic and we don't want just one of the same tree over and over again, came **random forests**, a foundational concept in machine learning. In this forest of decision trees, each one is randomly constructed of the basic conditional statements making up the original tree. Each random tree has pros and cons, but our inputs have a much higher chance of correct classification in this manner than before.

Seems like making trees random shouldn't work, or at least shouldn't give you the same answer every time. The reason why it does goes like this; _bagging_, _random feature selection_, and _ensembling_. We start with our training data, and continue to make trees using our data set along with tree-specific training sets created through that bagging process mentioned just above. It's the process of creating a new dataset using **random sampling with replacement** (we might use it more than once, or never!).

Here's a basic example; we start with $[5, 9, 3, 4, 1, 2]$. Then, we start to make variations of this dataset, like;

- $[3, 4, 4, 9, 5, 5]$
- $[1, 9, 5, 2, 2, 1]$
- $[2, 2, 2, 9, 3, 5]$

We also call these bootstrapped data. In our case, we want to bootstrap our dataset for each randomly generated decision tree. This leads to the next step; training the tree on a randomly selected set of features. **_Every single tree in the random forest is trained using a bootstrapped version of your data, using only a subset of that data_**. If you understand that, you're golden.

Onto the last part; using the tree by creating an ensemble of the answers provided by each tree. Each tree is going to spit out a value (more often then not, it won't be understandable by a human) that represents a classification. All trees come together to do a majority-wins-type situation, meaning the more trees classify a label, that label will be chosen.

## Support Vector Machines

