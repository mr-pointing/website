---
aliases: 
draft: false
tags:
  - computerscience
  - flask
  - python
title: Flask's Tutorial
date: 2024-11-06
updated: 2024-11-30T12:20
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

`sqlite3.connect()` is the command used to make the connection between your app and your SQLite database. It uses `current_app` to point at the database configuration file we'll create later. `sqlite3.Row` is another SQLite configuration that sets up returned rows as dictionaries, which gives you the ability to call columns by the key.

Finally, the `close_db` function checks if `g.db` was initialized, and closes the connection if it exists. We'll use this within our app factory to allow to database to be open and closed with each request.

## Create the Tables

We nee to create the schema that will allow for your tables to be created. For this project, we're building a site users can both log into and make posts on, so we'll make two tables; `user` and `post`.

```sql
DROP TABLE IF EXISTS user;
DROP TABLE IF EXISTS post;

CREATE TABLE user (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  username TEXT UNIQUE NOT NULL,
  password TEXT NOT NULL
);

CREATE TABLE post (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  author_id INTEGER NOT NULL,
  created TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  title TEXT NOT NULL,
  body TEXT NOT NULL,
  FOREIGN KEY (author_id) REFERENCES user (id)
);
```

We also have to make the Python code that will run these SQL queries;

```python
def init_db():  
    db = get_db()  
  
    with current_app.open_resource('schema.sql') as f:  
        db.executescript(f.read().decode('utf-8'))  
  
  
@click.command('init-db')  
def init_db_command():  
    """Clears existing tables/data and creates new tables"""  
    init_db()  
    click.echo("Database initialized!")  
  
  
sqlite3.register_converter(  
    "timestamp", lambda v: datetime.fromisoformat(v.decode())  
)
```

We use `current_app` again here, since our location isn't always the same. From what I understand, `current_app` will always have the path back to our app's directory, or the `flaskr` folder. This way, we can use `.open_resource()` and pass in the schema file, and it'll be able to access it no problem.

The `@click.command` wrapper allows us to run the `init_db()` command via the command line, which is extra convenient. Finally, the `sqlite.register_converter()` command lets Python know how to put timestamp values into the database. 

Now that these commands are made, they have to be registered with the application so they can get recognized and used. We can do this with a function in our database file telling Flask where to get those commands;

```python
def init_app(app):
	app.teardown_appcontext(close_db)
	app.cli.add_command(init_db_command)
```

Our `.teardown_appcontext()` method will let Flask know to call that specific function when performing clean up, or after a returned response. We also use `.cli.add_command()` to register our new command line interface command.

Now that our `db.py` file is all set up, we need to tell our application factory to call and use the database; add the following to the end of your app factory *before* returning the app.

```python
def create_app():
	app = ...
	# existing code up above

	from . import db
	db.init_app(app)

	return app
```

Once done, we can now use the follow command in the terminal to initialize our new database;

```bash
flask --app flaskr init-db
```

After, you should see your message appear telling you the database was initialized, and there should now be a `flaskr.sqlite` file within your instance directory.

# Blueprints and Views

When using our application, we're going to perform multiple requests for information. A *view* is a function in Flask written to deal with these requests. They work in both ways; they can help generate responses and URLs.

A *blueprint* is a way to organize groups of related views and any other pieces of code you might need. For our `Flaskr` app, we have two blueprints; authentication and blog posts. First we'll define the authorization blueprint, then add in the blogs later.

We'll start our `auth.py` with some imports and create a Blueprint object;

```python
import functools

from flask import (
	Blueprint, flash, g, redirect, render_tempalte, request, session, url_for
)
from werkzeug.security import check_password_hash, generate_password_hash

from flaskr.db import get_db

bp = Blueprint('auth', __name__, url_prefix='/auth')
```

Our blueprint object takes in the name of it, `auth`, where it's defined, `__name__`, and what to append to all URL's using the blueprint. Before we actually define any functions, we have to register our blueprint in our `__init__.py` file.

```python
def create_app():
	app = ...
	# Exisiting code should be here

	from . import auth
	app.register_blueprint(auth.bp)

	return app
```


## Making the First View: Register

Our first view is going to let our user be able to create an account on our app, or a register page. It will give the user a form to submit, and after it'll validate the input, ensuring it's a valid username/password. If not, it'll error out and ask the user to try again.

An important note is that the view itself is *not* creating the HTML, we're going to come back and write the actual HTML in a second. Instead, what we'll do is write the Python logic for what needs to be done in order to allow the user to make an account.

```python
@bp.route('/register', methods=('GET', 'POST'))
def register():
	if request.method == 'POST':
		username = request.form['username']
		password = request.form['password']
		db = get_db()
		error = None

		if not username:
			error = "Username is required."
		elif not password:
			error = "Password is required."

		if error is None:
			try:
				db.execute(
					"INSERT INTO user (username, password) VALUES (?, ?)",
					(username, generate_password_hash(password)),
				)
				db.commit()
			except db.IntegrityError:
				error = f"User {username} is already registered."
			else:
				return redirect(url_for("auth.login"))
		
		flash(error)
	return render_template('auth/register.html')
```

We can walk through each part to gain a better understanding of each part. We are going to use a similar structure for a lot of our functions;

1. `@bp.route` is again a wrapper to tell Flask this view should be able to be seen at the `/register` URL. We also give it two methods that we'll use together, `GET` and `POST`. These are REST methods we're looking for. 
2. We start the function by checking for a `POST`. If we have one, we're going to evaluate the information passed from a HTML form. We use `request.form` which is actually a dictionary object, returning the submitted username and password.
3. We initialize our database connection with our `get_db()` function, and set up an error variable which will keep track in case we have an error statement.
4. We check for two things before checking against the database, and that's to ensure we have a value for both before checking. If we don't, we assign a value to error which will fail our next check. 
5. We create another check, making sure we don't have an error. If we do, we send it out, otherwise we keep going.
6. A `try` statement is used to attempt the user entry, but an `IntegrityError` flag is used as an exception to assign a value to error that tells you the username is already taken. This will prevent duplicate users. 
7. If there are no errors, we return a redirect to send the user to the login page, `auth.login`.