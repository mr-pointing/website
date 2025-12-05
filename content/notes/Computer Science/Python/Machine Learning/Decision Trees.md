---
aliases:
draft: false
tags:
  - computerscience
  - AI
  - machine_learning
  - python
title: Decision Trees
date: 2025-11-19
updated: 2025-12-02T09:10
---

---

Time to start tackling some of the models we discussed in [How AI Works - Chapter 3]({{< ref "How AI Works - Chapter 3" >}}). We're going to do this out of order- we'll come back to KNN another day. For now, we can start by building our first _Decision Tree_. I'm not going to go into too much detail in this note, since we go over it in more detail in the note just above. Instead, let's work through the Python code together so we can begin working on our exercise.

The dataset we're going to use is interesting and worth looking at before we just start using it. Before we move on, let's look at it together, and I want you to try and figure out how your brain would try to split up each categorization. Our objective is to find out which positions in a given company earns a wage of over $100k p/year. How would you begin breaking down your data?

We have a few approaches based on the amount of columns we have. We have three columns; company, job, and degree. One thing to keep in mind is the amount of **Entropy** or randomness each split will give you.

Here's a basic example using our dataset; say you broke it down by the company. We have three, Google, Facebook, and ABC Pharma. If we then look at each company, we'd see _everyone_ at Facebook makes over $100k. 3 out of 4 at ABC Pharma don't, and about half of Google does. Our Entropy rates are 0, ~.25, and 1. Versus if we broke it down by degree. It's another half split for bachelors and a 6/2 split for masters. We have _more_ entropy when we broke it down by category, leading to less information gain versus a high information gain by having a super low entropy.

Now that we have a breakdown of the data, let's write some code.

```python
import pandas as pd
df = pd.read_csv("salaries.csv")
df.head()
```

We should definitely make sure we break up our data into inputs and output;

```python
X = df.drop('salary_more_then_100k', axis='columns')
X.head()
```

```python
y = df['salary_more_than_100k']
```

As you should notice, we have mostly categorical data. The only numerical data we have is the output, or whether or not they make $100k. This is bad for us, because we're going to have to encode this. We're going to use the `LabelEncoder` introduced in the latter portion of [One Hot Encoding]({{< ref "One Hot Encoding" >}});

```python
from sklearn.preprocessing import LabelEncoder
le_company = LabelEncoder()
le_job = LabelEncoder()
le_degree = LabelEncoder()
```

```python
X['company_n'] = le_company.fit_transform(X['company'])
X['job_n'] = le_job.fit_transform(X['job'])
X['degree_n'] = le_degree.fit_transform(X['degree'])
```

Make sure to call `X` to ensure everything got in safely. Obviously now that we've done our encoding, we can drop our categorical columns;

```python
X_final = X.drop(['company','job','degree'], axis='columns')
```

This process should start to feel familiar. We processed our data, put it into a format we can use for input and output, and now again like many times now we'll use our input and output to fit our model.

```python
from sklearn.model_selection import train_test_split
X_train, X_test, y_train, y_test = train_test_split(X_final, y, test_size=0.3)
```

```python
from sklearn import tree
tree_model = tree.DecisionTreeClassifier()
tree_model.fit(X_train, y_train)
```

Now that we've made our model, let's run a prediction and see how accurate our model is.

```python
tree_model.predict([[2, 1, 0]])
```

```python
tree_model.score(X_test, y_test)
```

## Exercise

You are going to determine whether or not someone was going to survive the sinking of the Titanic. You're going to use the following features as your determining factors;

1. Pclass
2. Sex
3. Age
4. Fare

Be sure to calculate the score of your model as well.

