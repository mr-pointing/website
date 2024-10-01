---
aliases: 
draft: false
tags:
  - computerscience
  - documentation
  - SQL
title: SQLBolt - Lesson 4
date: 2024-09-29
updated: 2024-09-29T14:04
---

-------------------------------------------------------------------------------

# Filtering and Sorting Results

One way to ensure we don't get duplicate rows, we could use the `DISTINCT` keyword;

```sql
SELECT DISTINCT column, another_column, ...
FROM mytable
WHERE condition(s);
```

This however is pretty indiscriminate, and we'll look at how to specify duplicates with `GROUP BY` later.

Often in the real world, our data is not going to be ordered nice and neatly. Quite often, data is inserted without rhyme or reason, and purely based off when some events happened and collected rather than compared to the rest of the data in the data set. Because of this, we'll want to order our data off a certain condition to make it more readable. 

To accomplish this, we can use the `ORDER BY` clause;

```sql
SELECT column, another_column, ...
FROM mytable
WHERE condition(s)
ORDER BY column ASC/DESC;
```

`ASC/DESC` refers to how your data is sorted: *ascending* or *descending* order.

Some additional clauses we can add to an `ORDER BY` clause is `LIMIT` and `OFFSET`. `LIMIT` will determine how many rows to return, while `OFFSET` will determine where to begin returning rows from.

```sql
SELECT column, another_column, ...
FROM mytable
WHERE condition(s)
ORDER BY column ASC/DESC
LIMIT number OFFSET number;
```


A reason to use something like `LIMIT` and `OFFSET` are for faster and more accurate returns. Think of a website like Reddit, wouldn't it be problematic for your browser if every time you load the page, it gave you **every single** post? 

---
Next: 
[Lesson 6]({{< ref "SQLBolt - Lesson 6" >}}) 
