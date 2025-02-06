---
aliases: 
draft: false
tags:
  - computerscience
  - AI
  - machine_learning
  - textbook
  - math
  - probability
title: Deep Learning - Chapter 3
date: 2025-01-21
updated: 2025-01-26T16:27
---

-------------------------------------------------------------------------------


# Probability and Information Theory

When we encounter situations where the output is unknown, *probability theory* gives us a mathematical framework to deal with these statements. They use the term "quantifying uncertainty" which I like a lot. The connection between AI applications and probability come from two places; algorithms often use probability theory to give AI it's reasoning abilities, and probability with statistics are used to grade and categorize the behavior of the AI models/agents.

The distinction is made between probability theory and *information theory*, where the former is concerned with making uncertain statements, and the latter gives us the ability to quantify the levels of uncertainty.

## Why Probability?

While programmers often work in fields that are deterministic (machines run instructions without errors (that aren't human) relatively well), there is still need for understanding the theory.

When designing machine learning agents, it's normal to run into uncertain or what we call *stochastic* quantities. Essentially, stochastic refers to a random element, making the outcome or output unable to be precisely determined (though it can be analyzed and averaged).

There are three main sources of uncertainty in modeling;

1. Inherent stochasticity in a system being modeled
	1. Basically, there is always an element of randomness that must be accounted for
2. Incomplete observability
3. Incomplete modeling

Sometimes, it's "safer" to use a simple and uncertain rule over a complex and certain one, *even when the certain one is deterministic and we can afford too*. Take for example, the term "Most birds fly". You could spend a while explaining the actual statement, "All birds fly, except baby birds, sick birds, penguins,..." on and on. You might even forget about Kiwis.

Probability theory originates from the need to analyze the frequency of events. We see simple forms of this in things like statistics in card games, what we call *frequentist probability*. We also have the degree of belief, which relates to levels of certainty, or *Bayesian probability*. Both do use similar, if not the same formulas in calculations.

## Random Variables

Simply put, **Random Variables** are variables that can take on a random value. Denoted with a lowercase script, subscripts are possible values of the random variable: x is a random variable, and $x_1$ & $x_2$ are possible values of x. It can also be represented as random vector, **x** with $x$ as a value of **x**.

On it's own, random variables don't do much. However, when paired with a probability distribution, it's randomness can be mapped and understood.

## Probability Distributions

A *probability distribution*, hinted too just previously, describes how likely a random variable is to give a certain output, otherwise known as a possible state. The distribution changes depending on the variables being *discrete* or *continuous*.

I needed a refresher on the difference between the two. Discrete data has exact values; think of shoe sizes, the number of pages in a book, or people in a room. Conversely, continuous data can take on any value within a given range; how long a movie is, the temperature outside, or the time it takes to complete a test.

### Discrete Variables and Probability Mass Functions

When describing distributions with discrete variables, we are describing them using a *probability mass function*, or PMF. We denote these functions with capital p's, $P$. For reading sake, the book will have different outcomes denoted with different variables rather than names, $P(x)  != P(y)$. We say the probability of x = $x$ is known as $P(x)$, with a range of 0 (impossible) to 1 (certain).

We can expand this a level further, and create a *joint probability distribution*, which will use two or more variables; $P($x$=x,$y$=y)$ denotes the probability of both x and y. You can see this written as $P(x,y)$ often.

PMF comes with some rules in order for $P$ to be a valid function:

1. The domain (inputs or $x$) of $P$ must be the set of all possible states of x.
2. All of the $P(x)$ values (range or output) must be between 0 and 1.
3. The sum of all the $x$ values must add to one; $\sum_{x\in X}P(x)=1$. This property is called **normalized**.

### Continuous Variables and Probability Density Functions

When working with continuous random variables, instead of PMF, we're going to use a *probability density function*, or PDF. Just like a PMF, a PDF has rules as well,

1. The domain of $p$ must be the set of all possible states of x.
2. All of the $p(x)$ values must be greater than or equal to 0.
3. $\int p(x)dx=1$. They proceed to go this assuming you know about integral (which I don't) and it flew right over my head. Will need to come back to this later.

## Marginal Probability

Marginal probability distribution refers to grabbing the probability of a subset of random variables within a known set of random variables.

To find the probability of lets say x from a known $P($x,y$)$, you can use the *sum rule*; $P($x$=x)=\sum_{y}P($x$=x,$y$=y)$. When using continuous variables, replace summation with integration.


## Conditional Probability

Anytime we are concerned with the probability of a given event based on another event, we call that *conditional probability*. We would say that the probability of y$=y$ given x$=x$ as $P($y$=y|$x$=x)$. You compute this using $(P($y$=y|$x$=x))/P($x$=x)$. It i s also only defined when $P($x$=x) >0$.

### The Chain Rule of Conditional Probabilities

If we were to perform a probability distribution over many random variables, we are able to decompose it into a conditional distribution over only *one* variable.


## Independence and Conditional Independence

Variables are considered *independent* if you can express their probability distribution as the product of two factors, separating x and y; $p($x$=x,$y$=y)=p($x$=x)p($y$=y)$.

The other scenario we may encounter are variables that are *conditionally independent*, where x and y are random conditionally independent variables given the variable z, and the conditional probability distribution over x and y factorizes like so;  $p($x$=x,$y$=y|$z$=z)=p($x$=x|$z$=z)p($y$=y|$z$=z)$.

We can simply denote these two as x$\perp$y, and x$\perp$y | z.

## Expectation, Variance and Covariance

Just like we represent the probability of an event happening, we need to represent the expected value, or *expectation*, of a given function ($f(x)$). We commonly refer to this as the average of the probability distribution $P($x$)$, or more specifically the value $f$ takes on for each $x$ of $P$. For discrete variables it's solved with summation ($\sum_{x}P(x)f(x)$) and with continuous variables it's solved with integral ($\int p(x)f(x)dx$). Depending on how much we know about our random variables, changes how we express $E[ ]$, but we always assume the existence of square brackets accounts for multiple random variables.

*Variance* is a measurement used to represent the range of the values of a function; Var$(f(x))=E[(f(x)-E[f(x)])^2]$. We could actually visually see the variance in a dataset, when the variance is low enough, the values of $f(x)$ will cluster near the expected value. If we square root the variance, we actually get the *standard deviation* of our function.

Similarly, we can calculate *covariance*, which is the representation of two values and their linear relativity. Some concepts to remember about covariance and dependence:

- High absolute values of covariance means values have a wide range and far from the mean simultaneously
- If covariance is positive, both variables have high values simultaneously
- If covariance is negative, one variable has a high value at times the other has a low value, and vice versa
	- We could measure *correlation* to normalize the contribution of each variable to measure relevance
- Two variables that are independent have zero covariance, and two variables that have **nonzero** covariance are dependent
- Independence is a *stronger* requirement than zero covariance:
	- For two variables to have zero covariance, they must have no linear dependence
	- It is possible for two variables to be dependent but have zero covariance

## Common Probability Distributions

### Bernoulli Distribution

A distribution over a single binary variable, controlled by a single parameter $\phi \in[0,1]$ ; essentially returns the probability of variable being equal to 1. Two useful properties that stuck out to me are

- $P($x$=1)=\phi$
- $P($x$=0)=1-\phi$

### Multinoulli Distribution

Sometimes called the categorical distribution, the *Multinoulli distribution* is a distribution of a single discrete variable with $k$ different states, and $k$ is finite. We denote it with vector $p\in[0,1]^{k-1}$, and $p_i$ will return the probability of the $i$-th state.

### Gaussian Distribution

One of the most common distributions over real numbers is appropriately called normal distribution, or *Gaussian distribution*.

The formula ($N(x;\mu,\sigma ^{2})=\sqrt{1/2\pi \sigma^{2}}exp(-{1/2\sigma^{2}}(x-\mu)^{2}$) has a lot to inspect. Our parameters are $\mu\in R$ and $\sigma \in (0, \infty)$ are what control the distribution; specifically, $\mu$ is the coordinate of the central peak of the distribution (average, $E[$x$]=\mu$), and $\sigma$ is the standard deviation, with $\sigma^{2}$ as the variance.

It's usually a good idea to run a normal distribution over an application if you're unsure of what form the distribution should take for two main reasons;

1. Most distributions we want to model are close to normal distributions, **central limit theorem** (sum of independent random variables are normally distributed).
2. Among other distributions with the same variance, normal distribution has the maximum amount of uncertainty over real numbers (least amount of prior knowledge)

### Exponential and Laplace Distributions

Often in deep learning, we will desire a probability distribution with a sharp point at $x=0$. We can do this in two ways:

1. **Exponential Distribution**: $p(x;\lambda)=\lambda 1_{x>=0}exp(-\lambda x)$ 
	1. $1_{x>=0}$ assigns zero to all values of $x$.
2. **Laplace Distribution**: Laplace$(x;\mu,\gamma)={1/2\gamma}exp(-{|x-\mu |/ \gamma})$  

### Multiple Distributions

There are a few more distributions the book goes over, but since I don't want to jump too deeply into machine learning mathematics yet (at least before I read a good pre-calculus textbook) I'd rather just abbreviate the next few subsections into the following idea; often, you'll encounter situations where you'll use multiple different distributions together. This leads to the introduction of *latent variables*, random variables are can't observe directly that will be discussed in a later chapter.


## Bayes' Rule

If we know $P($y|x$)$, *Bayes' Rule* tells us we can find $P($x|y$)$ using $(P($x$)P($y|x$))$/$P($y$)$. If we don't know $P($y$)$, we can find it with $\sum_x P($y|x$)P(x)$. 

## Technical Details of Continuous Variables

The book is pretty upfront about the aspects of mathematics it won't go over. In this case, we turn our attention to *measure theory*. Essentially, measure theory helps us deal with paradoxes, which is out of the scope of examples in this book.

Some terms that come from measure theory that might come up:

- *Measure zero*: a description of a set that is negligibly small
- *Almost everywhere*: a property that "holds almost everywhere" except for a set of measure zero

## Information Theory

Originally used in sending messages via radio, *information theory* is a branch of mathematics that is centered on the information that is sent via signal. Information theory is important because it helps in the creation of code used in communication, and even helps in the realm of machine learning with continuous variables and their message length.

One of the largest takeaways we should remember from information theory is that the notification of an irregular event is more important that the notification of a regular event (Compare "sun rose in the morning" and "three moons in the sky").

To put into more formal context; likely events should have a low amount of information, guaranteed events shouldn't have any information, less likely events should have high information content, and independent events should have additional information. 

To satisfy the previous properties, we can use $I(x)=-logP(x)$. $I(x)$ is in *nats*, where one nat is the amount of info obtained after an event of probability $^{1}_{e}$. 
