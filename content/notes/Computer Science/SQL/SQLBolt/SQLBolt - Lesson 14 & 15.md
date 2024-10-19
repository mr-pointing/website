---
aliases: 
draft: false
tags:
  - computerscience
  - SQL
  - documentation
title: SQLBolt - Lesson 14 & 15
date: 2024-10-12
updated: 2024-10-15T17:11
---

-------------------------------------------------------------------------------

# Updating Rows

If we can `SELECT` rows, and `INSERT` data into rows, we can most certainly `UPDATE` them as well.

`UPDATE` works similarly to `INSERT`, and needs a `WHERE` clause to specify which rows should be updated:

```SQL
UPDATE mytable
SET column = value_or_expression
    other_column = value_or_expression
    ...
WHERE condition;
```

Obviously, like `INSERT`, the values or expressions returned should match the data type of the expected column/property.

A helpful tip is to always try a `SELECT` statement out first to make sure you are grabbing all the rows you think you want *before* you make any changes.


# Deleting Rows

Deleting rows is actually quite simple; 

```SQL
DELETE FROM mytable
WHERE condition;
```

Just make to sure to use this statement with *caution*; if you leave out the `WHERE` clause, **all rows will be deleted.**

Same tips as updating; try a `SELECT` statement to grab all rows you want to make sure it works *before* deleting.


---
Next: 
[Lesson 16]({{< ref "SQLBolt - Lesson 16" >}}) 

