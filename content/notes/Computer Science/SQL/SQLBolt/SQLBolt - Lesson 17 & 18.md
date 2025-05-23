---
aliases: 
draft: false
tags:
  - computerscience
  - SQL
  - documentation
title: SQLBolt - Lesson 17 & 18
date: 2024-10-15
updated: 2024-10-15T17:11
---

-------------------------------------------------------------------------------

# Altering Tables

If you need to include additional information not provided by the original tables creation statement, you can use an `ALTER TABLE` statement to manipulate and create columns.

## Adding Columns

Extremely similar to how we add in new rows, adding in a new column uses the following syntax:

```SQL
ALTER TABLE mytable
ADD column DataType OptionalTableConstraint
   DEFAULT default_value;
```

We specify a table we want to add into, provide the column's name and datatype, and we have the option for a table constraint and default value if needed. It's usually good practice to insert some default value, since all rows that already exist in the table will need some value for the new column (otherwise it will be NULL).


## Removing Columns

Even though the syntax for dropping a column is super easy, not every database will allow you to do so. The one we're going to use primarily (SQLite) doesn't, but it doesn't hurt to know.

```SQL
ALTER TABLE mytable
DROP column_to_be_dropped;
```

In SQLite, we'd have to make a new tables without the column we want to drop.

## Renaming Tables

Renaming a table is also extremely easy to do;

```SQL
ALTER TABLE mytable
RENAME TO new_table_name;
```

The important concept behind this lesson is that the conventions used really does differ depending on the database used. Again, those could be MySQL, Postgres, SQLite, Microsoft SQL Server, to name a few.

## Dropping Tables

Where `DELETE` would delete the data and rows inside, if we wanted to drop the *ENTIRE TABLE* and it's schema for whatever reason, we'd use the following syntax:

```SQL
DROP TABLE IF EXISTS mytable;
```

Again, we use the `IF EXISTS` statement to ensure we avoid any thrown error messages. If the table you're deleting also has `FOREIGN KEY` dependencies, that will become an issue and you'll have to first edit the rows and columns there before deleting. 
