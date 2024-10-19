---
aliases: 
draft: false
tags:
  - computerscience
  - SQL
  - documentation
title: SQLBolt - Lesson 13
date: 2024-10-12
updated: 2024-10-15T07:54
---

-------------------------------------------------------------------------------

# Inserting Rows

When we first started going over SQL databases, we just understood them as basic tables with columns of properties and rows of instances. The next step up is the *Database Schema*, which describes all tables in a database and the datatypes those rows can contain.

Because each row has defined types that are allowed, it keeps the database cleaner and easier to navigate.

Our first non-`SELECT` statement, we can start to insert data into our tables using the `INSERT` statement:

```SQL
INSERT INTO mytable
(column, another_column,...)
VALUES (value_or_expr, another_val_or_exp,...),
   (value_or_expr2, another_val_or_exp2,...),
   ...;
```


You can `INSERT` multiple rows at a time if you wish, and it is always best practice to insert data for every column within your entered row. You could also use `INSERT` for specific columns, in which your entered row should match the amount of rows exactly. 


---
Next: 
[Lesson 14]({{< ref "SQLBolt - Lesson 14 & 15" >}}) 
