---
aliases:
draft: false
tags:
  - computerscience
  - AI
  - machine_learning
  - python
title: Support Vector Machines
date: 2025-11-29
updated: 2025-12-04T10:52
---

-------------------------------------------------------------------------------


For the theory and more detail on how this model works, go back to [How AI Works - Chapter 3]({{< ref "How AI Works - Chapter 3" >}}) to freshen up. We only have two concepts to go over before we jump into the code. 

One concept not touched on in the text is the concept of **Gamma**. Gamma is a metric that can high or low; the more gamma you have, the less input values you consider when drawing the boundary between points. Usually what you'll have is high gamma approaches having a very loose boundary that follows the flow of your points, while a low gamma approach will have a more rigid approach that might even miss-label some points.

Another concept when looking at the above examples are **regularization**. The more loose a boundary is the higher the regularization, and the more strict the lower the regularization. Now, let's get into the code.

We've actually worked with this dataset before, so we should be somewhat familiar with it. Loading it is just like we did last time;

```python
import pandas as pd
from sklearn.datasets import load_iris
iris = load_iris()
```

One thing we did last time was just use the `load_iris()` object as is. This time, just so we can say we have some experience doing so, we're going to turn our object into a dataframe, like the one's we've been using since the beginning. 

```python
df = pd.DataFrame(iris.data,columns=iris.feature_names)
df.head()
```

Make sure it looks good before moving on. Essentially, we just used Pandas' `DataFrame` function to turn the `data` from our `load_iris` object into a usable Pandas dataframe. We also sent in the names of the columns, using `iris.feature_names` instead of just leaving them blank. This can help us identify or call them. 

Every model we've used so far usually has all of their data in one single data frame, both input and output. We currently only have input, so let's bring in our output. We should create a new column in our data frame like so;

```python
df['target'] = iris.target
```

We have a numerical representation for our output, we could also drag in the categorical version as well. We'll do this using something called *lambda*, which is like a self-defined function but shorter and faster to use. While it's more complicated to look at, it makes our life a lot easier;

```python
df['flower_name'] = df.target.apply(lambda x: iris.target_names[x])
df.head()
```

I also think now is a good time to review how we can visualize our dataset. Last time we used the iris dataset, I showed you all a neat way of looping through the iris' data method to get what you want. For example, the following will plot the sepal length and width for each;

```python
plt.xlabel('Sepal Length')
plt.ylabel('Sepal Width')
for i in range(50):
	plt.scatter(iris.data[i][0], iris.data[i][1], color='red', marker='.')
for i in range(50, 100):
	plt.scatter(iris.data[i][0], iris.data[i][1], color='blue', marker='+')
for i in range(100, 150):
	plt.scatter(iris.data[i][0], iris.data[i][1], color='green', marker='*')
```

This mainly worked out due to our exploration of the dataset together during class. However, this is not the most readable format we could write, and using a dataframe makes this a lot easier. First, we can separate our data frame into smaller data frames that will make the separation we did before a bit smoother;

```python
df_set = df[:50]
df_ver = df[50:100]
df_vir = df[100:]
```

Now that we have each different type of flower in it's own respective data frame, calling them for plots is much easier;

```python
plt.xlabel('Sepal Length')
plt.ylabel('Sepal Width')

# Setosa vs. Versicolor
plt.scatter(df_set['sepal length (cm)'], df_set['sepal width (cm)'], color='purple', marker='.')
plt.scatter(df_ver['sepal length (cm)'], df_ver['sepal width (cm)'], color='pink', marker='*')
```

Now, let's get into using our SVM. As always, we're going to create our test split by first creating an `X` data frame and `y` table;

```python
X = df.drop(['target', 'flower_name'], axis='columns')
y = df.target
```

Then perform the train test split;

```python
from sklearn.model_selection import train_test_split
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2)
```

And just like every other model, we'll create the model object, fit it, and use it.

```python
from sklearn.svm import SVC
base_model = SVC()
```

```python
base_model.fit(X_train, y_train)
```

Be sure to check out the parameters of your model before we score it and see how things change. The `C` in your parameters is your **regularization** (see above), `gamma` is set to `auto`, and your `kernel` is `rbf`. If you don't remember what these are, again refer to Chapter 3. Let's score our model with the default parameters;

```python
base_model.score(X_test, y_test)
```

The first time I ran it, I got around 93%. I decided to run it again and got 96% pretty consistently. Let's use this as a metric for the following changes. Starting with changing the value of C, or increasing our regularization. If we set our model with the following parameter, `C=10`, I found that the score was varying in values but more often then not went up to 1.  Using the exact same data set (setting `random_state=10`) made no difference, really showing how the data provided in training really does make a huge impact on the reliability of a model.

We could also get `gamma=10` to increase the gamma. This actually ends up decreasing our overall score, averaging at 90% accuracy this time. Bump it up to 100, and accuracy is all the way down at 45%. The last one we can change based on the notes from chapter 3 is your kernel. We can set `kernel='linear'`, which on my machine gave me between 96-100% which was overall much more accurate than the default `rbf` method. However, what's not being tested here due to the small size of the data set is the impact on training time. Refer to the table at the end of chapter 3 for more details.

