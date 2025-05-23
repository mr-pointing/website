---
aliases: 
draft: false
tags:
  - computerscience
  - documentation
  - SQL
title: SQLBolt - Lesson 6
date: 2024-09-29
updated: 2024-09-29T14:15
---

-------------------------------------------------------------------------------

# Multi-table Queries with JOINs

Unlike the database we've been using for most of these lessons, real world data is usually divided into different tables, often through a process we call **normalization**. Normalization is the procedure used to break down large tables into smaller more organic tables. This reduces duplicate data, and allows for a more natural growth of data within respective tables.

Due to our data being broken up, our queries will in turn have to become more complex to grab information over multiple tables. We can achieve this with a `JOIN`.

Let's try to visualize this; since our data is being broken down through normalization, we are going to have to introduce some system so each entity is accurately represented across our normalized tables. We call this system a *primary key*, and is usually an ID in the form of a number or hashed string.

The first type of join is an `INNER JOIN`. This join will take two tables and combine the information into a single row based off the tables primary key:

```sql
SELECT column, another_table_column, ...
FROM mytable
INNER JOIN another_table
  ON mytable.id = another_table.id
WHERE condition(s)
ORDER BY column, ... ASC/DESC
LIMIT num_limit OFFSET num_offset;
```
