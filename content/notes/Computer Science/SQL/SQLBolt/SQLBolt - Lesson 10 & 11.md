---
aliases: 
draft: false
tags:
  - computerscience
  - SQL
  - documentation
title: SQLBolt - Lesson 10 & 11
date: 2024-10-11
updated: 2024-10-11T14:59
---

-------------------------------------------------------------------------------

# Queries with Aggregates

Aggregates are analogous with built-in functions. They're helpful pieces of code we can use to make writing our queries easier. The syntax is as follows:

```SQL
SELECT AGG_FUNC(column_or_expression) AS agg_description
FROM mytable
WHERE constraint_expression;
```

With the previous syntax, we would use said function over all rows and return a single result. Here are some functions we'll use:

- `COUNT(column or *)`: returns the number of rows if no columns specified, otherwise returns number of non-NULL values in chosen column
- `MIN(column)`: returns smallest numerical value for all rows in group
- `MAX(column)`: returns largest numerical value for all rows in group
- `AVG(column)`: returns average numerical value for all rows in group
- `SUM(column)`: returns sum of all numerical values for all rows in the group

There's another concept we should look at called *grouped aggregate functions*, which instead of returning values for all rows, allows you to return multiple values based upon a specified delimiter or group. We can achieve this by using the `GROUP BY` statement:

```SQL
SELECT AGG_FUNC(column_or_expression) AS agg_description
FROM mytable
WHERE constraint_expression
GROUP BY column;
```

Since we already filter out our rows using the `WHERE` clause, if we wanted to filter our `GROUP BY` data we would need to use something additional called a `HAVING` clause. They are written very similar to your `WHERE` clause:

```SQL
SELECT AGG_FUNC(column_or_expression) AS agg_description
FROM mytable
WHERE constraint_expression
GROUP BY column
HAVING group_condition;
```


---
Next: 
[Lesson 12]({{< ref "SQLBolt - Lesson 12" >}}) 
