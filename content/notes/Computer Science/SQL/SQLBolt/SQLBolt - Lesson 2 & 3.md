---
aliases: 
draft: false
tags:
  - computerscience
  - SQL
  - documentation
title: SQLBolt - Lesson 2
date: 2024-09-21
updated: 2024-09-23T17:05
---

-------------------------------------------------------------------------------

# Specifying Data to Select (Constraints)

When our table has only a few rows, a `select *` query isn't so bad. However, if we have hundreds, sometimes thousands of rows of data, retrieving all of them at once becomes an issue. 

That reason is why we have the ability to specify our results with conditional statements:

```sql
SELECT column, another_column, ...
FROM mytable
WHERE condition
  AND/OR another_condition
  AND/OR ...;
```

We can collect more complex results from building more complex queries. Say for example we wanted to collect reptiles who don't have teeth and are the color green, we could use a query like this:

```sql
SELECT name
FROM reptiles
WHERE skin_color = "Green"
AND has_teeth = 0
```

The different *logical operators* can be seen in the table below:

| Operator               | Condition                                | Example                                    |
| ---------------------- | ---------------------------------------- | ------------------------------------------ |
| =, !=, <, <=, >, >=    | Standard numerical operations            | `col_name != 10`                           |
| `BETWEEN...AND...`     | Number is within range of two values     | `col_name BETWEEN 2.5 AND 7.5`             |
| `NOT BETWEEN...AND...` | Number is not within range of two values | `col_name NOT BETWEEN 2.5 AND 7.5`         |
| `IN (...)`             | Value exists in a list                   | `col_name IN ("Example1", "Example2")`     |
| `NOT IN (...)`         | Value does not exists in a list          | `col_name NOT IN ("Example1", "Example2")` |

Both numbers and words can exist within a table. Just like Python, we can define the type of input like `INT` and `FLOAT` for numbers, and `VARCHAR` for words/mixed content. String content must be within quotes and does have some of it's own conventions for conditionals;


| Operator   | Condition                                                                                                 | Example                                                            |
| ---------- | --------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------ |
| =          | Case sensitive exact string comparison                                                                    | `col_name = "abc"`                                                 |
| != or <>   | Case sensitive exact inequality comparison                                                                | `col_name != "abcd"`                                               |
| `LIKE`     | Case insensitive exact string comparision                                                                 | `col_name LIKE "ABC"`                                              |
| `NOT LIKE` | Case insensitive exact string inequality comparison                                                       | `col_name NOT LIKE "ABCD`                                          |
| %          | Used anywhere in a string to match a sequence of zero or more characters (only with `LIKE` or `NOT LIKE`) | `col_name LIKE "%AT%"` (This will return AT, ATTIC, CAT, and BATS) |
| _          | Used anywhere in a string to match a single character (only with `LIKE` or `NOT LIKE`)                    | `col_name LIKE "AN_"` (This matches AND, but not AN)               |

---
Next: 
[Lesson 4]({{< ref "SQLBolt - Lesson 4" >}})  
