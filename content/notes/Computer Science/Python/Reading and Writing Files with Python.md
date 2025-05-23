---
aliases: 
draft: false
tags:
  - computerscience
  - python
  - output
  - input
title: Reading and Writing Python Files
date: 2024-09-14
updated: 2024-09-15T13:11
---

-------------------------------------------------------------------------------

This is a more general file for Python input and output for files. I feel like I constantly need to look up this stuff, so things I find I'll write down here for reference. 

# Reading in a CSV

I was solving some [Python Problems]({{< ref "Python Problems" >}}) and needed to format easily from a CSV. I did a quick google and came across this [article](https://saturncloud.io/blog/how-to-convert-a-csv-file-to-a-dictionary-in-python-using-the-csv-and-pandas-modules/) which reminded me [Pandas]({{< ref "Pandas" >}}) has a easy CSV reader. The syntax is like so,

```python
>>> import pandas as pd
>>> stock_data = pd.read_csv('stocks.csv')  
# to_dict() is a method of a pandas object, and orient is a parameter that tells  
# the object how to place the values in their dictionary  
>>> stock_dict = stock_data.to_dict(orient='records')  
>>> print(stock_dict)
```

There's also Python's built-in `csv` module.

```python
# import csv
>>> import csv
# read csv file to a list of dictionaries
>>> with open('data.csv', 'r') as file:
...    csv_reader = csv.DictReader(file)
...    data = [row for row in csv_reader]
>>> print(data)
```

# Writing to a CSV

Just like reading in a CSV, `pandas` has a relatively easy option. Here's an example with writing a list of lists, using data frames;

```python
>>> import pandas as pd
>>> a = # some list of lists
>>> my_df = pd.DataFrame(a)
>>> my_df.to_csv('output.csv', index=False, header=False)
```

However, from what I gathered from some community posts, it seems like you should use built-in modules before relying on ones like `pandas`. In this case, Python's built in `csv` module can deal with this pretty easily;

```python
>>> import csv
>>> a = # some list of lists
>>> with open('output.csv', 'w', newline='') as f:
...    writer = csv.writer(f)
...    writer.write_rows(a)
```
