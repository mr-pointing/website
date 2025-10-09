---
aliases:
draft: false
tags:
  - computerscience
  - AI
  - machine_learning
  - python
title: Linear Regression
date: 2025-09-21
updated: 2025-10-08T19:58
---

---

# Single Variable

A great beginner model, _Linear Regression_ uses input and output features to predict new inputs. There are lots of things we can predict; stock prices, collectibles, cars, you name it. An easy one we can use for now is home prices. Take the following table for example;

| Area | Price  |
| ---- | ------ |
| 1750 | 465000 |
| 2000 | 545000 |
| 2300 | 570000 |
| 2800 | 595000 |
| 3200 | 614000 |

Our objective is to create a model that will correctly price out a new house given we provide a square footage area. We can see a really clear pattern; as the area increase, the price increases. We could easily plot this on a scatter plot and see the correlation. We should also remember from algebra that we can create a line of best fit, that would minimize the amount of error between the expected amount and the actual amount (the price). Sounds, confusing, let's actually see what happens.

Let's keep some formulas in mind;

- We want to minimize $\sum^{n}_{i=1}($ Difference of Actual vs. Expected $i)^2$
- The Line of Best Fit is made using $y=mx+b$ , where homeprice = $m$ \* (area) + $b$
  - $m$ is slope and $b$ is the y-intercept

Now, remember, we're using Jupyter Notebook, so all of these pieces of code should be ran **sequentially**, or one after the other. Let's begin with some imports:

```python
import pandas as pd
import numpy as np
from sklearn import linear_model
import matplotlib.pyplot as plt
```

What is an import? Think of the functions Python has built-in; `print`, `type`, `input`; all of these are predefined functions that are some number of lines of code that accomplish some task. Other people can also make their own type of functions, and are _callable_ via these libraries we are importing. The **Pandas** library is going to give us a matrix-like structure called a _Dataframe_ and allow us to easily read-in and read-out data. The [NumPy]({{< ref "What is NumPy" >}}) library is going to introduce easier-to-use arrays. The `sklearn` library is going to give us the model we'll be using, and `matplotlib` gives Python an easy-to-use library for making statistical plots (in our case, a scatter plot).

**BEFORE WE START**, make sure you have a version of the `.csv` (Comma Separated Value) file downloaded in your `H:` drive, or somewhere you know the path too. Drag that `.csv` file into your Jupyter Notebook environment, or hit the upload files button in the top left bar. Now, we can begin;

```python
df = pd.read_csv("houseprices.csv")
```

First step is basic; we're going to create a new variable called `df` that will house all of our data in a nice, easily readable form. You can either `print(df)` or simply call `df` to make sure your data got in there okay.

Making a scatter plot with this info is one of the easier things we're going to do today. We start by laying out the important info like labels for `x` and `y`;

```python
%matplotlib inline
plt.xlabel('Area')
plt.ylabel('Price')
plt.scatter(df.area,df.price,color='red',marker='+')
```

You should get back out a pretty picture of our scatter plot. Feel free to play around with the colors and marker used. Challenge; try and include a title (every good graph needs one!).

Now, we're going to have to separate our data. We want to train our model on both the inputs and outputs, but we have to tell our model which is which. Since we only have two variables, we can split them pretty easily;

```python
new_df = df.drop('price', axis='columns')
new_df
```

The above creates a new Dataframe object with just the home areas inside;

```python
price = df.price
price
```

We now have our prices and areas completely separated. Now, the real magic; fitting our model. It's even easier than you think;

```python
reg = linear_model.LinearRegression()
reg.fit(new_df, price)
```

Now, predicting a home with let's say, 2500 sqft works like so;

```python
reg.predict([[2500]])
```

How does this get done? Well, we actually already know; $y=mx+b$! If we fill this out using our `reg` _object variables_;

```python
> reg.intercept_
np.float64(351543.4217368695)
> reg.coef_
array([87.87311492])
```

We can use the simple mathematics of Python to run them in a formula;

```python
> 2500*87.87311492+351543.4217368695
571226.2090368695
```

Now that we know what's going on under the hood, we can simply run it as intended;

```python
> reg.predict([[2500]])
571226.20904836
```

# Multiple Variables

There aren't many situations in real life where only one single variable affects an outcome like price. Most of the time, there are many different variables that we need to consider. To continue using our home example;

| Area | Bedroom | Age | Price  |
| ---- | ------- | --- | ------ |
| 2450 | 2       | 23  | 535000 |
| 2900 | 3       | 18  | 580000 |
| 3100 |         | 20  | 605000 |
| 3400 | 3       | 32  | 583000 |
| 3900 | 4       | 6   | 685000 |
| 4150 | 5       | 7   | 762000 |

Our original formula for getting price, $y=mx+b$, turns into;

- $price=m_1*area+m_2*bedrooms+m_3*age+b$

We should open up a new environment to work in, as well as to get comfortable working and using Python.

```python
import pandas as pd
import numpy as np
from sklearn import linear_model
```

This time, we won't need to use a scatter plot since we're using multiple variables (it would need to be a 4-dimensional point!).

```python
df = pd.read_csv('full_houseprices.csv')
df
```

When running our new Dataframe, you'll notice that we have a NaN value in our bedrooms column. Totally fine, and part of the lesson. Remember, data is messy. Quite often we are going to have to clean up our data manually, especially if we are working for a company/client. Working with empties is not great, and we should avoid it whenever possible.

It's really up to us on what we should fill our empties with. For our context, we could use something like the median bedrooms of the dataset, which we could get in a few different ways. Here's an easy way;

```python
df.bedrooms.median()
```

We get 3. Great, we can use that. Let's fill all blanks with this value;

```python
df.bedrooms = df.bedrooms.fillna(df.bedrooms.median())
```

Make sure to call `df` and ensure your values have been entered correctly. Just like before, we're going to fit out model with all the input features and output features. We don't need to create new variables this time;

```python
reg = linear_model.LinearRegression()
reg.fit(df.drop('price', axis='columns'), df.price)
```

To keep things nice and organized, we can begin predicting by passing in the values in order of appearance;

```python
reg.predict([[3250, 6, 40]])
```

### Exercise

Given a dataset on hiring stats (`hiring_stats.csv`), you are going to build a model that will output what each new hire's salary should be. There are three features you should be concerned with; years of experience, written test score, and interview score. Based off of these three, provide a prediction for the following new hires;

- 3 years, 8 test score, 7 interview score
- 11 years, 9 test score, 10 interview score

---

Next:
[Gradient Descent]({{< ref "Gradient Descent" >}})
