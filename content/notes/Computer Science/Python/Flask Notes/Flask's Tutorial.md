---
aliases: 
draft: false
tags:
  - computerscience
  - flask
  - python
title: Flask's Tutorial
date: 2024-11-06
updated: 2025-04-29T12:06
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

`flaskr/__init__.py`

```python
from flask import Flask  
import os  
  
  
def create_app(test_config=None):  
    # Create and configure app  
    app = Flask(__name__, instance_relative_config=True)  
    app.config.from_mapping(  
        SECRET_KEY='dev',  
        DATABASE=os.path.join(app.instance_path, 'flaskr.sqlite'),  
    )  
    if test_config is None:  
        app.config.from_pyfile('config.py', silent=True)  
    else:  
        app.config.from_mapping(test_config)  
  
    try:  
        os.makedirs(app.instance_path)  
    except OSError:  
        pass  
  
    @app.route('/hello')  
    def hello():  
        return '<b>Hello, world!</b>'  
  
  
    return app
```

# Define and Access the Database

SQLite, a super lightweight database management system, is supported by Python via the `sqlite3` module. This isn't going to go too in depth on how SQLite works, you can visit [SQLite Tutorial]({{< ref "SQLite Tutorial" >}}) for more information on that.

## Connect to the Database

Before we can make edits or add to our database, we first need to create and connect to it. The following code will accomplish this for us:

`flaskr/db.py`

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
        g.db.row_factory = sqlite3.Row  
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

`flaskr/schema.sql`

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

`flaskr/db.py`

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

`flaskr/db.py`

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

`flaskr/auth.py`

```python
import functools

from flask import (
	Blueprint, flash, g, redirect, render_template, request, session, url_for
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

`flaskr/auth.py`

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
8. Since there has to be somewhere to actually allow the user to request anything, the `return render_template()` call will display `auth/register.html` by default or when there is a validation error.

## Login

Our login view is going to work incredibly similarly to our register view, except instead of inserting into our database, we'll be retrieving. 

`flaskr/auth.py`

```python
@bp.route('login', methods=('GET', 'POST'))  
def login():  
    if request.method == 'POST':  
        username = request.form['username']  
        password = request.form['password']  
        db = get_db()  
        error = None  
        user = db.execute(  
            "SELECT * FROM user WHERE username = ?", (username,)  
        ).fetchone()  
  
        if user is None:  
            error = "Incorrect username."  
        elif not check_password_hash(user['password'], password):  
            error = "Incorrect password."  
  
        if error is None:  
            session.clear()  
            session['user_id'] = user['id']  
            return redirect(url_for('index'))  
  
        flash(error)  
  
    return render_template('auth/login.html')
```

Let's walk through this;

1. Our routine of grabbing username and password remains the same, and we again create an `error` variable for validation, and create a `db` connection.
2. We retrieve the user's information based on the username given on the login form, and use `.fetchone()` at the end to only get one row from our database. Later, we'll see how we can use `.fetchall()` to do the opposite.
3. After retrieval, first check to see if we got anything with a `None` check; `user` will give back `None` if there isn't a return from the query (no usernames in the database). Then, if we did get a user, check and see if the password they gave in the form is the same as the hashed password stored in the database. If either fail, we store a result inside of `error`.
4. If `error`  is still `None` by the time it reaches the if statement for it, we clear the `session`, set the key `user_id` to the requested user's `id`, and redirect them to the index page.

A crucial object to understand about what we just did, is that `session` is actually a dictionary, since we could access certain key's like `user_id`. Since we stored it here, it will be usable upon page refreshes or navigations, as long as the *session* is still active. We can write a function that will run before any view is ran, that will actually store all of the information about our user into that `g` object we saw before when creating our database functions. The code is below and we'll implement it later.

`flaskr/auth.py`

```python
@bp.before_app_request  
def load_logged_in_user():  
    user_id = session.get('user_id')  
  
    if user_id is None:  
        g.user = None  
    else:  
        g.user = get_db().execute(  
            'SELECT * FROM user WHERE id = ?', (user_id,)  
        ).fetchone()
```

## Logout

Logging out is relatively simple; just clear the session.

`flaskr/auth.py`

```python
@bp.route('/logout')
def logout():
	session.clear()
	return redirect(url_for('index'))
```

## Requiring Authentication

Since we only want certain features to be able to be used by a logged in user, we are going to have to let those functions know they should only activate if it's a legit, logged in user trying to use them. We could check this individually every time we write a function, or we could just write what we call a *decorator* that we can put before each function to let our app know a user must be logged in to be using these features;

`flaskr/auth.py`

```python
def login_required(view):
	@functools.wraps(view)
	def wrapped_view(**kwargs):
		if g.user is None:
			return redirect(url_for('auth.login'))

		return view(**kwargs)
	return wrapped_view
```

# Templates

If you attempted to run any of the previous routes we just defined, you'd notice they don't work. Not only that, but we've been sending our users to pages we haven't even written yet. We're going to mostly take care of that in this section, on templates. Since, again, HTML and CSS deserves it's own unit, you can learn more from many different resources (including some [notes of my own]({{< ref "Fundamental CSS Properties" >}})). Otherwise, let's use the tutorial's basic skeleton and you can explore and make some changes in your free time.

We store templates, or HTML files, in the template directory. Templates specifically house the sites static information, and contain placeholders for any dynamically collected data through use. The way it accomplishes all of this is with the help of a template language, Jinja. It is denoted with `{{` and `}}`, works similarly to Python, and is generally easy to use.

## The Base

Let's build a base page, or what every page will be built on top of;

`flaskr/templates/base.html`

```HTML
<!doctype html>
<title>{% block title %}{% endblock %} - Flaskr</title>
<link rel="stylesheet" href="{{ url_for('static', filename='style.css') }}">
<nav>
  <h1>Flaskr</h1>
  <ul>
    {% if g.user %}
      <li><span>{{ g.user['username'] }}</span>
      <li><a href="{{ url_for('auth.logout') }}">Log Out</a>
    {% else %}
      <li><a href="{{ url_for('auth.register') }}">Register</a>
      <li><a href="{{ url_for('auth.login') }}">Log In</a>
    {% endif %}
  </ul>
</nav>
<section class="content">
  <header>
    {% block header %}{% endblock %}
  </header>
  {% for message in get_flashed_messages() %}
    <div class="flash">{{ message }}</div>
  {% endfor %}
  {% block content %}{% endblock %}
</section>
```

Right of the bat, we've got some Jinja helping us create a nice dynamic nav bar. If we happened to be logged in, it will understand that and provide a logout feature. Otherwise, it will provide a register and login feature. Pretty neat.

We also created the `section` that will house all of our information. We can see the `block title`, `block content`  and `block header` on the bottom? Those are areas we'll populate in the remaining template pages. 

## Register

Making a register feature is crucial to the design of our application. Otherwise, we have no users. Making the sign up form is actually the easiest part; we did the hard part a little earlier when we created the `register` function. 

All we need is a form we can access through HTTP, and the correct variable names for them;

`flaskr/templates/auth/register.html`

```html
{% extends 'base.html' %}

{% block header %}
  <h1>{% block title %}Register{% endblock %}</h1>
{% endblock %}

{% block content %}
  <form method="post">
    <label for="username">Username</label>
    <input name="username" id="username" required>
    <label for="password">Password</label>
    <input type="password" name="password" id="password" required>
    <input type="submit" value="Register">
  </form>
{% endblock %}
```

A neat little trick we do here is give the H1 heading inside the header the `block title` tag, so we set the display title of the page and the meta data title at the same time. Flask is smooth like that.

## Login

Extremely similar to the register template;

`flaskr/templates/auth/login.html`

```html
{% extends 'base.html' %}

{% block header %}
  <h1>{% block title %}Log In{% endblock %}</h1>
{% endblock %}

{% block content %}
  <form method="post">
    <label for="username">Username</label>
    <input name="username" id="username" required>
    <label for="password">Password</label>
    <input type="password" name="password" id="password" required>
    <input type="submit" value="Log In">
  </form>
{% endblock %}
```

Now, try to register and see if it works. Also, try removing the `required` part of the username and password to see what exactly Flask's error messaging looks like. 

# Static Files

Something we've actually already implemented, the use of static files are the opposite of our Templates; while our templates will be filled and changed depending on their content, the information inside our static directory does not change throughout the runtime of our application. This is where we are going to put our stylesheet, seeing as we want it to be consistent from the moment we launch our app till the moment we close it.

Here's is the CSS file we're going to use; it's not entirely necessary to understand every part of this just yet, but it doesn't hurt to brush through it to find the parts you do know/understand so you can more easily come back later and make adjustments:

`flaskr/static/styles.css`

```css
html {
  font-family: sans-serif;
  background: #eee;
  padding: 1rem;
}

body {
  max-width: 960px;
  margin: 0 auto;
  background: white;
}

h1, h2, h3, h4, h5, h6 {
  font-family: serif;
  color: #377ba8;
  margin: 1rem 0;
}

a {
  color: #377ba8;
}

hr {
  border: none;
  border-top: 1px solid lightgray;
}

nav {
  background: lightgray;
  display: flex;
  align-items: center;
  padding: 0 0.5rem;
}

nav h1 {
  flex: auto;
  margin: 0;
}

nav h1 a {
  text-decoration: none;
  padding: 0.25rem 0.5rem;
}

nav ul  {
  display: flex;
  list-style: none;
  margin: 0;
  padding: 0;
}

nav ul li a, nav ul li span, header .action {
  display: block;
  padding: 0.5rem;
}

.content {
  padding: 0 1rem 1rem;
}

.content > header {
  border-bottom: 1px solid lightgray;
  display: flex;
  align-items: flex-end;
}

.content > header h1 {
  flex: auto;
  margin: 1rem 0 0.25rem 0;
}

.flash {
  margin: 1em 0;
  padding: 1em;
  background: #cae6f6;
  border: 1px solid #377ba8;
}

.post > header {
  display: flex;
  align-items: flex-end;
  font-size: 0.85em;
}

.post > header > div:first-of-type {
  flex: auto;
}

.post > header h1 {
  font-size: 1.5em;
  margin-bottom: 0;
}

.post .about {
  color: slategray;
  font-style: italic;
}

.post .body {
  white-space: pre-line;
}

.content:last-child {
  margin-bottom: 0;
}

.content form {
  margin: 1em 0;
  display: flex;
  flex-direction: column;
}

.content label {
  font-weight: bold;
  margin-bottom: 0.5em;
}

.content input, .content textarea {
  margin-bottom: 1em;
}

.content textarea {
  min-height: 12em;
  resize: vertical;
}

input.danger {
  color: #cc2f2e;
}

input[type=submit] {
  align-self: start;
  min-width: 10em;
}
```

[Here](https://developer.mozilla.org/en-US/docs/Web/CSS) is a great resource for learning more about CSS. For now, after you've copy and pasted this into the correct project directory, you should be able to run your app with some new very basic styling. Remember, because we set up a rule inside of the `auth.py` file that sets the `url_prefix='/auth'`, this means that going to [http://127.0.0.1:5000/login](http://127.0.0.1:5000/login) is not going to work. Instead, you'll need to visit [http://127.0.0.1:5000/auth/login](http://127.0.0.1:5000/auth/login).

# Remaining Blueprints

We are on the final stretch! This is the final implementation of our project; after this is testing (which technically should be done alongside development but not important for this lesson) and production. Both are out of the scope for this class, so let's just focus on the most important parts; the underlying Python code that helps our blog function properly.

## Blog Blueprint

First up, the blog's blueprint. Nothing too wild to start with;

`flaskr/blog.py`

```python
from flask import (
	Blueprint, flash, g, redirect, render_template, request, url_for
)
from werkzeug.exceptions import abort
from flaskr.auth import login_required
from flaskr.db import get_db

bp = Blueprint('blog', __name__)
```

Before continuing, let's tell our application factory we've created a new Blueprint we want it to serve;

`flaskr/__init__.py`

```python
def create_app():
	app = ...
	# Above is code you already wrote!

	from . import blog
	app.register_blueprint(blog.bp)
	app.add_url_rule('/', endpoint='index')

	return app
```

This is exactly the same process as the last few blueprints we added, except this time we are including a URL rule that associates the route to `index` the same as `blog.index`.

## Index

Since our application is a blog, it makes sense the blogs main features will take up most of the main page. We shoould start by showing all of the created posts so far, most recent at the top, by using a quick SQL query;

`flaskr/blog.py`

```python
@bp.route('/')
def index():
	db = get_db()
	posts = db.execute(
		'SELECT p.id, title, body, created, author_id, username'
		' FROM post p JOIN user u ON p.author_id = u.id'
		' ORDER BY created DESC'
	).fetchall()
	return render_template('blog/index.html', posts=posts)
```

Then, we should obviously create the visual side of this with the corresponding HTML page;

`flaskr/templates/blog/index.html`

```html
{% extends 'base.html' %}

{% block header %}
  <h1>{% block title %}Posts{% endblock %}</h1>
  {% if g.user %}
    <a class="action" href="{{ url_for('blog.create') }}">New</a>
  {% endif %}
{% endblock %}

{% block content %}
  {% for post in posts %}
    <article class="post">
      <header>
        <div>
          <h1>{{ post['title'] }}</h1>
          <div class="about">by {{ post['username'] }} on {{ post['created'].strftime('%Y-%m-%d') }}</div>
        </div>
        {% if g.user['id'] == post['author_id'] %}
          <a class="action" href="{{ url_for('blog.update', id=post['id']) }}">Edit</a>
        {% endif %}
      </header>
      <p class="body">{{ post['body'] }}</p>
    </article>
    {% if not loop.last %}
      <hr>
    {% endif %}
  {% endfor %}
{% endblock %}
```

There is a lot going on here, and again a lot of it is happening thanks in large part to Jinja's flexibility. Before letting me explain what's happening, try following the code down line by line and try on your own to figure out what's going on. 

## Create Posts

Creating a new post is going to work similarly to how our `register` view works, with some obvious changes. We are going to check and make sure the post is valid, then if there are no issues, create the post and send the user back to the main index. We also don't want anyone who is not a user to try and make their own posts, so we should make use of that `@login_required` wrapper we made a while ago.

`flaskr/blog.py`

```python
@bp.route('/create', methods=('GET', 'POST'))
@login_required
def create():
	if request.method == 'POST':
		title = request.form['title']
		body = request.form['body']
		error = None
		
		if not title:
			error = 'Title is required.'
			
		if error is not None:
			flash(error)
		else:
			db = get_db()
			db.execute(
				'INSERT INTO post (title, body, author_id)'
				' VALUES (?, ?, ?)',
				(title, body, g.user['id'])
			)
			db.commit()
			return redirect(url_for('blog.index'))
	return render_template('blog/create.html')
```

And let's make the HTML page;

`flaskr/templates/blog/create.html`

```html
{% extends 'base.html' %}

{% block header %}
  <h1>{% block title %}New Post{% endblock %}</h1>
{% endblock %}

{% block content %}
  <form method="post">
    <label for="title">Title</label>
    <input name="title" id="title" value="{{ request.form['title'] }}" required>
    <label for="body">Body</label>
    <textarea name="body" id="body">{{ request.form['body'] }}</textarea>
    <input type="submit" value="Save">
  </form>
{% endblock %}
```

## Update and Delete

Both the updating and deleting of a post feature is going to use a similar concept; they are both going to have to retrieve the information on a specific post made by the user that's currently logged in, otherwise the user shouldn't have access to edit anyone else's posts. Let's write a small function that can help us retrieve that post;

`flaskr/blog.py`

```python
def get_post(id, check_author=True):
	post = get_db().execute(
		'SELECT p.id, title, body, created, author_id, username'
		' FROM post p JOIN user u ON p.author_id = u.id'
		' WHERE p.id = ?',
		(id,)
	).fetchone()

	if post is None:
		abort(404, f"Post id {id} doesn't exist.")
	if check_author and post['author_id'] != g.user['id']:
		abort(403)

	return post
```

The only new thing we're doing above is carrying out a new function called `abort`. This new function raises an exception using HTTP status codes; we pass in a 404 error for not found, and a 403 error for a "Forbidden" edit, say if another user tried to edit a different user's post. 

Now that we have all of the posts information stored and returned, we can actually write the rest of the update function;

`flaskr/blog.py`

```python
@bp.route('/<int:id>/update', methods=('GET', 'POST'))
@login_required
def update(id):
	post = get_post(id)
	
	if request.method == 'POST':
		title = request.form['title']
		body = request.form['body']
		error = None
		
		if not title:
			error = 'Title is required.'
		
		if error is not None:
			flash(error)
		else:
			db = get_db()
			db.execute(
				'UPDATE post SET title = ?, body = ?'
				' WHERE id = ?',
				(title, body, id)
			)
			db.commit()
			return redirect(url_for('blog.index'))
	
	return render_template('blog/update.html', post=post)
```

And again, we should start to see a pattern here, after we write out the logic for how our feetures should work, we implement them using HTML;

`flaskr/templates/blog/update.html`

```html
{% extends 'base.html' %}

{% block header %}
  <h1>{% block title %}Edit "{{ post['title'] }}"{% endblock %}</h1>
{% endblock %}

{% block content %}
  <form method="post">
    <label for="title">Title</label>
    <input name="title" id="title"
      value="{{ request.form['title'] or post['title'] }}" required>
    <label for="body">Body</label>
    <textarea name="body" id="body">{{ request.form['body'] or post['body'] }}</textarea>
    <input type="submit" value="Save">
  </form>
  <hr>
  <form action="{{ url_for('blog.delete', id=post['id']) }}" method="post">
    <input class="danger" type="submit" value="Delete" onclick="return confirm('Are you sure?');">
  </form>
{% endblock %}
```

The deletion is only slightly working now; you can see we have a `form` element with an `action` attribute calling some function we haven't written yet, `blog.delete`. We actually don't need a whole separate page and visualization for the deleting of a post; since it's a super simple concept, we can just write out the function and pass one of the forms buttons to activate our delete function upon press (and an additional check with an "Are you sure?" dialogue box);

`flaskr/blog.py`

```python
@bp.route('/<int:id>/delete', methods=('POST',))
@login_required
def delete(id):
	get_post(id)
	db = get_db()
	db.execute("DELETE FROM post WHERE id = ?", (id,))
	db.commit()
	return redirect(url_for('blog.index'))
```