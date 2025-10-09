---
aliases:
draft: false
tags:
  - computerscience
title: Gradient Descent
date: 2025-10-02
updated: 2025-10-06T09:24
---

---

This one will be a quick one, but it's really important. We know that given an input dataset, and given a _function_, we can calculate the output. For example, if we have $x=[1, 2, 3]$, and the function $y=3x-2$, we could reasonably figure out the dataset of $y$; $[1, 4, 7]$. Another term for this function, in the case of Machine Learning, is a _prediction function_.

Sometimes, we're only given the input and output data. It would be incredibly helpful if we were able to figure out that prediction function, so we can predict unseen input values with precision. We're actually going to continue working with the dataset we began working with in single variable linear regression.

To start, we know that in the last lesson we were able to figure out the predicted price given some input value(s). This time, let's think about it from a graphical standpoint;

Given this graph, how could we draw a line of best fit?

{{< image src="/images/scatter.jpg" alt="scatter_plot" position="center" style="border-radius: 8px;" >}}

Not only did I choose pretty scattered data points, there are many different ways you could try and attempt to draw your _line of best fit_. However, your main objective is still the same; minimize the amount of error between the predicted and expected amount.

The above definition actually has a name; it's called **Mean Squared Error**. Here's the formula;

$mse=\frac{1}{n}\sum^{n}_{i=1}(y_i-y_{predicted})^2$

Looks like a lot, but it's not that much. $n$ is the amount of data points we have (in our above example, $n=4$ ) and we're getting the sum of all of the actual values of y versus the expected values of y, squared (we square them to avoid skewed results!). We could _also_ call this formula a **cost function**. There are different types of cost functions, but MSE is a popular one to begin with. We can rewrite the above equation as;

$mse=\frac{1}{n}\sum^{n}_{i=1}(y_i-(mx_i+b))^2$

Obviously, guessing and checking every combination of $m$ and $b$ is inefficient and will take you forever. This is where our topic of conversation comes into play. **Gradient Descent** is a machine learning algorithm that calculates the line of best fit for a training data set. Conceptually this is a little weird; if you plot the values of $m$ and $b$ against the MSE (or in this case, cost), you'll actually get a ball-like graph like in the image reference below.

![gradient descent](https://builtin.com/sites/www.builtin.com/files/styles/ckeditor_optimize/public/inline-images/national/gradient-descent-convex-function.png)

We start at a point, usually (0,0). We calculate the cost, then reduce the value of $m$ and $b$, and again calculating the cost. We continue to do this until we reach the bottom, or the _minima_, where the **error is minimum**. That is our answer, or we'll use that $m$ and $b$ for our function.

How do we calculate the steps we need to take as we travel down? We don't want to miss our minima, and if we're going at a constant rate down, we could eventually miss our minima and never know. A better approach would be to gradually lower the amount decreased as we go on by steps

## Resources

- https://builtin.com/data-science/gradient-descent
- https://www.youtube.com/watch?v=vsWrXfO3wWw&t=202s

