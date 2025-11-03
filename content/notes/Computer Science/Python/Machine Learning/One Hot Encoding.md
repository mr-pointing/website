---
aliases:
draft: false
tags:
  - computerscience
title: One Hot Encoding
date: 2025-10-29
updated: 2025-11-03T09:15
---

---

Each time we learn a new model, our goal remains slightly the same; build a model that trains on input data to predict accurate output. One thing that has changed with each model is the type of data, or how we use it. This time, we're going to learn how we handle text information, slightly more complicated than numbers.

We know that Python doesn't understand English, or any human language for that matter. All it understands is numbers, so anytime we have data that is mostly string data we should and usually have to transfer it into another data type. If our computers have a hard time with words and have an easy time with numbers, it makes sense we should convert all strings into numbers. Well, how could we do that?

Let's say we have the following data set;

Borough,Area,Price
Brooklyn,2600,550000
Brooklyn,3000,565000
Brooklyn,3200,610000
Brooklyn,3600,680000
Brooklyn,4000,725000
Queens,2600,585000
Queens,2800,615000
Queens,3300,650000
Queens,3600,710000
Manhattan,2600,575000
Manhattan,2900,600000
Manhattan,3100,620000
Manhattan,3600,695000

The area and price are already numerical, meaning we probably can leave those as is. But what about borough? How do you think we could change our data around to account for this?

One easy, human way to do this is to give each borough a number. Brooklyn would be 1, Queens would be 2, and Manhattan would be 3. That's not a bad approach, but again we are working with a computer here. Whenever we have simple numerical data like that, the model can sometimes mistake each number for a _priority_, meaning that the computer will think Brooklyn is a higher priority than Queens, Queens more than Manhattan, and so on.

Our first definition of the data, we consider the column of boroughs to be a **Categorical Variable**, meaning it can be categorized. These are _nominal_ categoricals; think of an example of colors, ice cream flavors, etc. The categories _don't have any relation to one another_. The other type of categorical is _ordinal_, where the categories do relate to one another in some way, almost like a scale. Think of college degrees, adjectives to describe your feelings, etc.

If we had ordinal categorical variables, we could easily use numerical ordering and just replace each string with it's corresponding number. Unfortunately that won't be possible with nominal variables, so we're going to have to learn about **One Hot Encoding**. In this case, we're going to create three new columns; one for each borough. Then, depending on which borough each row belongs too, there will be a 0 in the corresponding column, and 0 in the rest of them. These will be called _dummy variables_, and despite their name they're going to help us out a lot.

Let's get into the code. Make sure you have the above data downloaded as a CSV. Then, load it into your Jupyter notebook file as per usual;

```python
import pandas as pd
df = pd.read_csv("onehot.csv")
```

Pandas actually has a really useful method that allows you to create your dummy variables super fast;

```python
dummies = pd.get_dummies(df.borough, dtype=int)
dummies
```

Make sure to call dummies to ensure your data looks as expected. The `dtype=int` is needed to make sure we're getting 1's and 0's instead of Boolean values by default. After you make sure it looks good, we can create a merged dataframe of both the original and new dummies;

```python
merged = pd.concat([df, dummies], axis='columns')
merged
```

Make sure your columns match up, and you have a 1 in the correct column for the given row's borough. Now that we have all of our information together, we can drop all of the useless info. For us, that means dropping the `borough` column, and we're actually also going to drop one of the newly made dummy columns.

When working with dummy variables, there's this concept called a _dummy variable trap_, or _multi-co-linearity_. Essentially, the inclusion of all dummy categories causes issues with the intercept of our function, and technically if we have dummy variables for all other categories, the last one we removed is implied by the absence of any 1 at all. For us, let's drop Manhattan;

```python
final = merged.drop(['borough', 'manhattan'], axis='columns')
final
```

Now that we have our data set up the way we want it, let's start to work on our linear regression model;

```python
from sklearn.linear_model import LinearRegression
reg = LinearRegression()
```

We're also going to have to set up our X and Y. X is going to be all of our data except for `price`, since that's our Y. We can create those variables easily;

```python
x = final.drop('price',axis='columns')
x
```

Make sure that looks good, then create Y;

```python
y = final.price
y
```

Next up we train our model;

```python
reg.fit(x,y)
```

Since we have basically no data, training takes barely a second. Now that we have our model, it's ready to be used. Let's try and predict what it would be like to live in a 3250 sqft home in Queens;

```python
reg.predict([[3250,0,1]])
```

How about a 4000 sqft home in Manhattan?

```python
reg.predict([[4000,0,0]])
```

How do we know how accurate our model is? We could predict existing data points to see how accurate it is, but there's an easier way. There's a method each model has that can be used to get a score of between 0 and 1; 1 for most accurate or perfect, 0 for obviously not;

```python
reg.score(x, y)
```

Now, since we did all of that work, let's learn how to do it even easier. This is where one hot encoding comes into play. This might seem a little counter-intuitive since we're about to make numerical representations that have the same issue we ran into in the beginning of this lesson, but stick with me.

First up, let's make a new dataframe to make sure we're not criss-crossing any data, and bring in a **Label Encoder** that will transform our strings into numbers;

```python
from sklearn.preprocessing import LabelEncoder
le = LabelEncoder()
dfle = df
dfle.borough = le.fit_transform(dfle.borough)
dfle
```

Then, we make our x and y variables;

```python
x2 = dfle[['borough', 'area']].values
x2
```

```python
y2 = dfle.price.values
y2
```

Now that our data is in place, let's perform the One Hot Encoding. We need to create our OHE object and call one of it's methods to fit our new data;

```python
from sklearn.preprocessing import OneHotEncoder
from sklearn.compose import ColumnTransformer
ct = ColumnTransformer([('borough', OneHotEncoder(), [0])], remainder = 'passthrough')
```

This will correctly label our dummy variables as non-ordinal. We can create our new dummy data set by replacing `x2` using `ct`;

```python
x2 = ct.fit_transform(x2)
x2
```

Just like before, we should drop one of our dummy columns as is best practice;

```python
x2 = x2[:,1:]
x2
```

Now, just like before, we're good to train our dataset;

```python
reg.fit(x2, y2)
```

And make some predictions.
