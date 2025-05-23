---
aliases: 
draft: false
tags:
  - computerscience
  - python
  - SQL
  - input
title: Importing CSV to SQL Table Using Python
date: 2025-02-10
updated: 2025-02-10T16:44
---

-------------------------------------------------------------------------------

From [Stack Overflow](https://stackoverflow.com/questions/2887878/importing-a-csv-file-into-a-sqlite3-database-table-using-python):

#### Using SQLite

```python
import csv, sqlite3

con = sqlite3.connect(":memory:") # change to 'sqlite:///your_filename.db'
cur = con.cursor()
cur.execute("CREATE TABLE t (col1, col2);") # use your column names here

with open('data.csv','r') as fin: # `with` statement available in 2.5+
    # csv.DictReader uses first line in file for column headings by default
    dr = csv.DictReader(fin) # comma is default delimiter
    to_db = [(i['col1'], i['col2']) for i in dr]

cur.executemany("INSERT INTO t (col1, col2) VALUES (?, ?);", to_db)
con.commit()
con.close()
```

#### Using Pandas

```python
df = pandas.read_csv(csvfile)
df.to_sql(table_name, conn, if_exists='append', index=False)
```
