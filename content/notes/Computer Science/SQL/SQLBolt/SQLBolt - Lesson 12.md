---
aliases: 
draft: false
tags:
  - computerscience
  - SQL
  - documentation
title: SQLBolt - Lesson 12
date: 2024-10-11
updated: 2024-10-12T10:49
---

-------------------------------------------------------------------------------

# Order of Execution

The order of execution within queries is important to understand. When getting unexpected output one of the first things you should check is your syntax and be sure you 100% know what you're saying/what you expect to get back. If you aren't writing complete or correct sentences, you'll never get correct responses.

The following syntax is the complete structure for a query and is executed sequentially (one after the other):

```SQL
SELECT DISTINCT column, AGG_FUNC(column_or_expression),...
FROM mytable
	JOIN another_table
	ON mytable.column = another_table.column
	WHERE constraint_expression
	GROUP BY column
	HAVING constriant_expression
	ORDER BY column ASC/DESC
	LIMIT number OFFSET number;
```

As we've seen through the problems we've faced, we can obviously leave out unneeded statements and clauses, but when all put together this is the order in which they would appropriately execute.


---
Next: 
[Lesson 13]({{< ref "SQLBolt - Lesson 13" >}})

