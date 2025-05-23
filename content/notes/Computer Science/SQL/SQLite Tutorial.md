---
aliases: 
draft: false
tags:
  - computerscience
  - SQL
  - python
title: SQLite Tutorial
date: 2024-10-15
updated: 2024-10-19T12:10
---

-------------------------------------------------------------------------------


# What is a Database?

Essentially, a database is a place in which your data and tables exists, organized in a way described by the *database schema*. 

There are many database platforms that use SQL as their main language; MySQL, NoSQL, Microsoft SQL Server, just to name a few. The one we're going to work with due to it's ease of use and lightweight installation is SQLite (appropriately named).


# Creating Our First Database

## Connection

We can actually use SQLite directly inside of PyCharm, our IDE. Just like any other module, we can use `pip install sqlite3` to install SQLite in our project.

Once installed, we can use an `import` statement to grab it and use it in our main Python file. Now we have to make a connection;

```python
import sqlite3

conn = sqlite3.connect('movies.db')
```

The connection is an important resource. Like everything in Python, we have to be descriptive and tell Python exactly what we want to do. By establishing this connection, we are telling Python that the variable `conn` is our way to access SQLite functions we're trying to use.


## Cursor

Now that we have a connection, we need a resource in which we can get information and make changes. For this, we can use something called a *cursor*. Think of a mouse cursor on your screen; you point at what you want, and click to move forward into whatever you're looking at. A SQLite cursor is similar in theory; we're going to use the cursor in order to actually run SQL commands.

For now, let's just set up our structure before we focus on actually writing and queries. Here's a really basic way to write a cursor:

```python
c = conn.cursor()
```

Super simple, right? We are using our connection variable `conn` to make a cursor-type object. We'll come back to use it in a second. First, let's look at two more things our skeleton should have. 


## Commit and Close

In order to actually make alterations and additions to our tables, we have to do something called committing our changes. Very similar to how you commit changes in Git, you need to tell Python to make that change. 

We also need to make sure that before we stop editing or selecting from a database, we should close our connection to the database. The reason why we do so isn't so important; if you are curious though, think about what happens if we leave the door open to a room we only want certain people to go in? All sorts of things can go wrong, so it's best practice to close your connection after connecting.

We haven't made any changes or additions yet, so these will go naturally at the bottom of our code. Our code should now look something like this;

```python
import sqlite3

# Connection to database
conn = sqlite3.connect('movies.db')

# Cursor object
c = conn.cursor()

# SQL queries go here


# Commit changes
conn.commit()

# Close db
conn.close()
```


## Create a Table

Making a table seems like the logical next step. Right after we make our cursor, we can start writing a statement to actually use it; `c.execute()`. The parameter for the method is a SQL query, which we will become more familiar with as time goes on. For now, let's start by creating a table and adding a few rows of data. Feel free to copy and paste the code below:

```python
c.execute("""  
CREATE TABLE IF NOT EXISTS movies (      
    title TEXT NOT NULL,    
    year INTEGER NOT NULL,    
    director TEXT NOT NULL)  
""")

c.execute("""  
INSERT INTO movies (title, year, director)  
VALUES ("2001: A Space Odyssey", 1969, "Stanley Kubrick"), 
        ("Super 8", 2011, "JJ Abrams"),  
        ("Howl's Moving Castle", 2004, "Hayao Miyazaki");          """)
```


This will give you a table called `movies` and a few of my favorite movies to populate it. We're going to use this as our primary platform for learning SQL. For exercises, I'll provide you with the database file (file type `.db`) and you are expected to be able to load it and run queries from it using PyCharm. 


# Conventions

SQLite has it's own way of doing things, just like other database management systems have their own. These are the *conventions* of the database. Let's go over a few different aspects of SQLite that make it unique.

## Datatypes

Unlike other databases with multiple different datatypes, SQLite has just *5*. This makes it super easy to dictate what types your columns should be:

1. `NULL`
2. `INTEGER`
3. `REAL`
4. `TEXT`
5. `BLOB`

`NULL` or empty refers to an empty piece of memory, usually reserved for some purpose or left out unintentionally. `INTEGER` and `REAL` are our number types for whole and decimal respectively, while `TEXT` acts like a string type for anything and `BLOB` for binary/files (mp3 file, jpeg file, etc.).


## Inserting Many Records

Inserting data into a table one record at a time would drive any common person nuts. To avoid insanity, we can use `c.executemany()` with placeholders to make our lives easier. Say we have the following information:

```python
many_movies = [
			   ("Paths of Glory", 1957, "Stanley Kubrick"),
			   ("Cloverfield", 2008, "JJ Abrams"),
			   ("Porco Rosso", 1992, "Hayao Miyazaki"),
]
```

We have this nice convenient list that contains tuples of movie data for us to insert into our movie table. We just have to change our execute statement slightly;

```python
c.executemany("INSERT INTO movies VALUES (?,?,?)", many_movies)
```

The question marks act as a placeholder for the values provided by each tuple in our `many_movies` list.


## Selecting and Formatting Data

Since we're using PyCharm, we can actually pull up a *terminal* of the database we created and use that to run all of our queries. But, it doesn't hurt to know how to do so using SQLite's format, just incase you need to do some work outside of PyCharm.

When you want to select and print data to the screen in a script, you have to do two main things;

1. Query the database
2. Fetch the results

Simple and easy to execute. Step one is a basic `c.execute()` with the select statement we want to use, and step two is a choice between three options:

```python
c.execute("SELECT * FROM movies")

c.fetchone()
c.fetchmany(5)
c.fetchall()
```

The different fetch requests are self explanatory, `fetchone()` returns the last record, `fetchmany(x)` will return `x` amount of records, and `fetchall()` will return all of the records.    

Getting them out to the screen is the more interesting part, and where formatting gets involved. Like all of the container objects in Python, when you retrieve a record it's going to come in parts, broken down by the columns. Printing just the record is going to look a bit ugly, so we can use a `for` loop to make it look a little nicer:

```python
c.execute("SELECT * FROM movies")
movies = c.fetchall()
for movie in movies:
    print(f"{movie[0]} directed by {movie[2]} released in {movie[1]}")
```


## Primary Keys

Small note to touch on; SQLite actually creates a primary key for your records in the background for you. When selecting, you can select `rowid` and will return the numbered unique integer for each record. Pretty useful stuff. It's also a good idea to use `rowid` when updating single records. 


# Challenge

Here's our challenge: we're going to make a few functions:

1. Show all records
2. Add a record
3. Delete a record
4. Add many records
5. Where clause selecter
