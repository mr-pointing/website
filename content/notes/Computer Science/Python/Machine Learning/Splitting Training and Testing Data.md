---
aliases:
draft: false
tags:
  - computerscience
  - machine_learning
  - AI
  - python
title: Splitting Training and Testing Data
date: 2025-11-05
updated: 2025-11-08T17:39
---

---

As we know from our [previous lessons]({{< ref "How AI Works - Chapter 2" >}}), we should split our data into two types; training and testing. So far, we've just been using all of our data when making our models. Thankfully, `sklearn` can help us out a lot here. Make sure to grab the dataset from classroom and let's dive in.

As always, load in your data and our libraries,

```python
import pandas as pd
import matplotlib.pyplot as plt
%matplotlib inline

df = pd.read_csv("usedcarprices.csv")
```

Let's visualize our data so we can tell what type of model we should use;

```python
plt.scatter(df.Age, df.Sell_Price)
```

```python
plt.scatter(df.Mileage, df.Sell_Price)
```

You should see two graphs with a negative correlation for both. That make's logical sense; we should probably use Linear Regression. This time though, we're going to perform our test/training split.

Let's separate our input and output data;

```python
X = df[['Mileage', 'Age']]
y = df['Sell_Price']
```

Then, all we need to do is import and call the method to do the split for us,

```python
from sklearn.model_selection import train_test_split
X_train, X_test, y_train, y_test = train_test_split(X,y,test_size=0.3)
```

What we just did was tell Python we want to separate our training data into 70% training data, 30% test data. We can call each new variable to see what's inside/`len()` to see the length of each. From here, we can fit our model with the training data, and predict using the testing data;

```python
from sklearn.linear_model import LinearRegression
reg = LinearRegression()
reg.fit(X_train, y_train)
```

```python
test_vals = reg.predict(X_test)
```

Make sure to call your `y_test` values to compare them against your predicted values. One more parameter you should be aware of is the `random_state` parameter, which you can pass into your training split like in the example below to always make sure your training/testing split is the same every time it's ran;

```python
X_train, X_test, y_train, y_test = train_test_split(X,y,test_size=0.3, random_state=10)
```

