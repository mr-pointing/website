---
aliases: 
draft: false
tags:
  - computerscience
  - SQL
  - documentation
title: SQLBolt - Lesson 9
date: 2024-10-11
updated: 2024-10-11T14:31
---

-------------------------------------------------------------------------------

# Queries with Expressions

Now that we understand the basics of querying, we can really start to dive deeper by building more complex statements as *expressions*. These expressions can be mathematical or even basic string functions.

When writing expressions, we should use the `AS` keyword to create an alias for our expression, which makes our statements easier to read. This can be used on columns or tables. 

The following statement is a great example of an expression:

```SQL
SELECT particle_speed / 2.0 AS half_particle_speed
FROM physics_data
WHERE ABS(particle_position) * 10.0 > 500;
```

Obviously this is a pretty complex expression, but that's not so much the point; more so, it shows the capabilities of what's possible.


---
Next: 
[Lesson 10 & 11]({{< ref "SQLBolt - Lesson 10 & 11" >}}) 

