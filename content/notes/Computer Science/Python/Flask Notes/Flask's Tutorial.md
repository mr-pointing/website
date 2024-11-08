---
aliases: 
draft: false
tags:
  - computerscience
  - flask
  - python
title: Flask's Tutorial
date: 2024-11-06
updated: 2024-11-08T12:20
---
[Link](https://flask.palletsprojects.com/en/stable/tutorial/) to tutorial.

-------------------------------------------------------------------------------

I was really hesitant to start this note, since I basically ran through this tutorial once already to start and complete my final project, [Lython]({{< ref "Lython" >}}). However, since I'm starting Sarah's site, and I want to test out a bunch of features/really get to understand Flask, let's go through it once more.

Last time, I did a combination of going through the tutorial, then making changes as I saw fit. I feel like I missed some crucial details I want to review, and I never documented my process. I'm going to completely go through it as if I don't want to make any edits, then make edits *after* it's finished. 

I also want to run this entirely through PyCharm. The way I know it worked before for me was keeping all my code in a directory inside the PyCharm project. 

Again, this tutorial is meant to teach enough to get an application started and going. The docs go over more detail, and I already went through the [quick start guide]({{< ref "Flask's Quickstart" >}}) so that has even more detail.

# Project Layout

If you were doing this from scratch, you could go into any directory and use the following commands to create and enter the directory for the project:

```bash
mkdir flask-tutorial
cd flask-tutorial
```

Since we're using PyCharm, let's choose a Flask application when creating our project. We will also create an application directory, `flaskr`, and a tests directory, `tests`. We'll talk about tests later, but the `flaskr` directory will hold all our Python files, as well as the `templates` directory (HTML pages) and `static` directory (CSS files).

The following is a preview of what we're going to end up with at the end of this project. 

```
/home/user/Projects/flask-tutorial
├── flaskr/
│   ├── __init__.py
│   ├── db.py
│   ├── schema.sql
│   ├── auth.py
│   ├── blog.py
│   ├── templates/
│   │   ├── base.html
│   │   ├── auth/
│   │   │   ├── login.html
│   │   │   └── register.html
│   │   └── blog/
│   │       ├── create.html
│   │       ├── index.html
│   │       └── update.html
│   └── static/
│       └── style.css
├── tests/
│   ├── conftest.py
│   ├── data.sql
│   ├── test_factory.py
│   ├── test_db.py
│   ├── test_auth.py
│   └── test_blog.py
├── .venv/
├── pyproject.toml
└── MANIFEST.in
```

We can also using the following `.gitignore` file to ensure we don't grab anything we don't need while using Git.

```
.venv/

*.pyc
__pycache__/

instance/

.pytest_cache/
.coverage
htmlcov/

dist/
build/
*.egg-info/
```


# Application Setup

The Flask application is our *instance* of the `Flask` class. We could just use a global `Flask` instance, but instead we should use something that scales with the growth of our application. We call this an *Application Factory*. This way, we set up the app in one location, and return it all at once.

## Application Factory

We're going to change our main Python file, or what would probably be called `app.py` by PyCharm, into `__init__.py`. It will contain our application factory **and** tell Python our app's directory is a package.

Let's go over the parts of our skeleton application factory and what each line does;

1. `app = Flask(__name__, instance_relative_config=True)`
	- Creates the `Flask` instance
	- `__name__` returns the current Python Module (your project)
	- `instance_relative_config=True` tells your application that all configuration files can be found within the `instance` directory
		- The `instance` folder is important to not be committed/packaged with the `flaskr` app, so it can contain things like configuration settings and secret keys
2. `app.config.from_mapping()` helps set up default configuration settings for our app
	- `SECRET_KEY` is exactly what it sounds like; a key meant to keep your app safe. We'll leave it as `'dev'` for now, and change it when we want to deploy our app.
	- `DATABASE` is our path to the SQLite database. We use `OS` to grab our `PATH`, and use our `app` instance to give it the path to the `instance` folder
3. `app.config.from_pyfile()` helps us set up the `config.py` file to override default configuration settings
	- We use an `if` statement to check and see if we're running any tests (`test_config=True`), otherwise use `config.py`
4. `os.makedirs()` makes sure we have an `app.instance_path`
	- One isn't made by default in Flask, so we'll need one for our SQLite database
5. `@app.route()` is our first *route*

We can now run our app. However, if you visit the default location (http://127.0.0.1:5000) you won't see anything. That's because we routed our `Hello, world!` statement to the `/hello` location, so we would need to visit http://127.0.0.1:5000/hello to actually see the results. 
 

# Define and Access the Database

SQLite, a super lightweight database management system, is supported by Python via the `sqlite3` module. This isn't going to go too in depth on how SQLite works, you can visit [SQLite Tutorial]({{< ref "SQLite Tutorial" >}}) for more information on that.

## Connect to the Database

Before we can make edits or add to our database, we first need to create and connect to it. The following code will accomplish this for us:

```python
import sqlite3  
from datetime import datetime  
import click  
from flask import current_app, g  
  
  
def get_db():  
    if 'db' not in g:  
        g.db = sqlite3.connect(  
            current_app.config['DATABASE'],  
            detect_types=sqlite3.PARSE_DECLTYPES  
        )  
    return g.db  
  
  
def close_db(e=None):  
    db = g.pop('db', None)  
  
    if db is not None:  
        db.close()
```

We use something called `g` through Flask; `g` is a Flask object that is unique upon every request and stores important information multiple functions might use. We create and store it for later use.

`current_app` is another Flask object that points to the Flask application. Honestly need this part to be explained like I'm five cause I'm not exactly sure what's going on here. I asked ChatGPT to ELI5;

>[!Help]
>Alright, imagine you're building a big Lego city, but instead of building everything all at once, you have little helpers who only build what you need when you ask them. 
>
>In this Lego city, there’s a special “helper” called `current_app`. This helper knows everything about your city – the roads, buildings, and parks – but only when you’re actually playing with the city. When you’re not playing, `current_app` doesn’t exist yet.
>
>So, when you say `get_db`, it’s like asking for a box of Lego pieces you’ll need later. But `current_app` can only grab that box once the city is ready and you’re actually playing with it. Because you’ve told it to wait until the right time, it knows exactly what you need and where to get it!

