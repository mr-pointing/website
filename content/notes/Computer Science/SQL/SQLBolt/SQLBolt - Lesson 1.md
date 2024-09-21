---
aliases: 
draft: false
tags:
  - computerscience
  - SQL
  - documentation
title: SQLBolt - Lesson 1
date: 2024-09-15
updated: 2024-09-21T16:51
---

-------------------------------------------------------------------------------


When we want to get information for a SQL table, we use the `SELECT` statement, or a *query*. Within a query is what data we want, where to get it from, and any additional formatting we want done before we get said data.

When selecting information from a table, we have to understand the make-up of a table. Let's say we have a `reptiles` table. There might be different types of reptiles (snakes, lizards, turtles, crocodiles) but each reptile has characteristics that make it unique. These characteristics are broken down into the different columns within a table, and each entry of a reptile is denoted by the rows.

This is important for understanding how we write queries. The syntax looks like this:

```SQL
SELECT skin_color, avg_body_temp, has_teeth 
FROM reptiles; 
```

The above will grab some data from some columns from a reptile table I made up. Let's say we wanted to grab *everything* from the reptile table, we could use this:

```sql
SELECT *
FROM reptiles;
```

Note that in both, we must end our query with a semicolon. The newline in-between parts of our query is optional but a good convention to follow to make reading easier.

---------------------------------------------------------------
Next: 
[Lesson 2]({{< ref "SQLBolt - Lesson 2" >}}) 
