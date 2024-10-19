---
aliases: 
draft: false
tags:
  - computerscience
  - SQL
  - documentation
title: SQLBolt - Lesson 16
date: 2024-10-15
updated: 2024-10-15T17:11
---

-------------------------------------------------------------------------------

# Creating Tables

One of the hardest things to do in data science (at least, to me) is pick up another person's collected data. It will often take a few minutes of "getting calibrated" to understand the rows from simple things like understanding naming conventions (some are really bad) to more complex things like what story the data is telling. 

The more complicated problems will end up needing some visualization tools which is something we'll look at later, so for now let's not think too big. However, one of the best ways to become more familiar with a dataset is to build it from scratch. Since we're building it from scratch, that means we're going to need some tables to store the data in.

```SQL
CREATE TABLE IF NOT EXISTS mytable (
   column DataType TableConstraint DEFAULT default_value,
   another_column DataType TableConstraint DEFAULT d_v,
   ...
);
```

The syntax works like this; we start with a `IF NOT EXISTS` statement. This will prevent the creation of a duplicate table error, since two tables cannot exist with the same name. You can generally name your table whatever you want, but we like to stick to conventional naming practices; try to remember to use snake casing (`snake_case`) and be as descriptive as you can without being *too* descriptive (think `grade_table` vs. `grades_for_my_senior_year_2024_2025`).

Inside parenthesis goes the *schema* for the table; the rows and the types expected for them. You can also use optional constraints on values being inserted or even a default value in the case of NULLS.

Here's a really basic example;

```SQL
CREATE TABLE movies(
   id INTEGER PRIMARY KEY,
   title TEXT,
   director TEXT,
   year INTEGER,
   length_minutes INTEGER
);
```

## Table Data Types

| Type                                                 | Description                                                                                                                       |
| ---------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------------------- |
| `INTEGER`, `BOOLEAN`                                 | Whole integer values, basic number or age. Bools will be represented as 0 or 1                                                    |
| `FLOAT`, `DOUBLE`, `REAL`                            | More precise decimal numbers. Used for measurements or fractions                                                                  |
| `CHARACTER(num_chars)`, `VARCHAR(num_chars)`, `TEXT` | Text-based types, used to store any information in quotations. First two are used when more precise memory management is required |
| `DATE`, `DATETIME`                                   | Date and date with time, respectively                                                                                             |
| `BLOB`                                               | Binary data                                                                                                                       |

## Table Constraints

Certainly not a comprehensive list, but a few that are common and useful. 


| Constraint           | Description                                                                                     |
| -------------------- | ----------------------------------------------------------------------------------------------- |
| `PRIMARY KEY`        | Values in this column are unique and are identifies for each individual row                     |
| `AUTOINCREMENT`      | Integer value that goes up automatically as data is inserted                                    |
| `UNIQUE`             | Ensures no other row in the database has the same value for this specific column                |
| `NOT NULL`           | Cannot be empty or NULL                                                                         |
| `CHECK (expression)` | Allows you to basically have a conditional statement checked before inserting data              |
| `FOREIGN KEY`        | Ensures that there exists a value in another table that corresponds to the newly inserted value |


---
Next: 
[Lesson 17 & 18]({{< ref "SQLBolt - Lesson 17 & 18" >}}) 
