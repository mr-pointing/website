---
aliases: 
draft: false
tags:
  - computerscience
  - documentation
  - SQL
title: SQLBolt - Lesson 7
date: 2024-10-07
updated: 2024-10-07T17:17
---

-------------------------------------------------------------------------------

# Outer Joins vs. Inner Joins

Any table from an `INNER JOIN` will *only contain information that belongs in **BOTH** tables.* These can be limiting, which is where `LEFT`, `RIGHT`, and `FULL JOIN`'s come into the picture.

Our syntax for a standard expression doesn't change, only get's different options for our `JOIN` keyword. 

```SQL
SELECT column, another_table_column, ...
FROM mytable
INNER/LEFT/RIGHT/FULL JOIN another_table
  ON mytable.id = another_table.id
WHERE condition(s)
ORDER BY column, ... ASC/DESC
LIMIT num_limit OFFSET num_offset;
```

Let's say we have two tables, joining table A to table B. Doing a `LEFT JOIN` will include rows from A even if there isn't a match in B. Similarly, a `RIGHT JOIN` will return rows found in B even if there is no match in A. If we were to do a `FULL JOIN`, all rows are kept even if there is no match.


---
Next: 
[Lesson 8]({{< ref "SQLBolt - Lesson 8" >}})  
