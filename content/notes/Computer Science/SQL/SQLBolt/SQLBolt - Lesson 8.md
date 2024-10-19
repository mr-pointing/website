---
aliases: 
draft: false
tags:
  - computerscience
  - documentation
  - SQL
title: SQLBolt - Lesson 8
date: 2024-10-07
updated: 2024-10-11T14:07
---

-------------------------------------------------------------------------------

# NULL Values

Unfortunately, working with data is an easy way to see that we don't live in a perfect world. There are more than a few instances of there not being any data available to display, which can cause all sorts of issues with our queries. These values are what we call **NULLS***, and can differ depending on your situation.

Most often at the start, we can leave them as NULL. However, depending on the structure of your table, you could do a 0, or even an empty text string.

We can search or avoid NULL values by using the `IS NULL` or `IS NOT NULL` when using our `WHERE` clause.

```SQL
SELECT column, another_column
FROM mytable
WHERE column IS/IS NOT NULL
AND/OR condition...
```


---
Next: 
[Lesson 9]({{< ref "SQLBolt - Lesson 9" >}}) 

