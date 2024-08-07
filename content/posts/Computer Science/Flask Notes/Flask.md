---
aliases:
  - flask
draft: false
tags:
  - computerscience
  - flask
  - python
title: Flask
date: 2024-06-25
---
Modified: August 02 2024

[Link](https://flask.palletsprojects.com/en/3.0.x/) to documentation.

-------------------------------------------------------------------------------

Flask is a framework to create applications via Python. It makes web based applications rather simple.

Starting from the [here](https://flask.palletsprojects.com/en/3.0.x/installation/#python-version), the installation page.

## Installation

### Python Version

Python version should be up to date. Flask supports 3.8 and newer.

### Dependencies

The following are installed automatically when installing Flask:

 - [Werkzeug]({{< ref "Werkzeug" >}}) uses WSGI, the standard Python interface between applications and servers.
 - [Jinja]({{< ref "Jinja" >}}) is a template language that renders the pages your application serves.
 - [MarkupSafe](https://palletsprojects.com/p/markupsafe/) comes packaged with Jinja, and is used to avoid injection attacks. 
 - [ItsDangerous](https://palletsprojects.com/p/itsdangerous/) signs data securely to ensure integrity to protect Flask's session cookie
 - [Click]({{< ref "Click" >}}) is a framework that you use for writing command line applications. It allows the `flask` command and custom commands
 - [Blinker]({{< ref "Blinker" >}}) provides support for Signals

### Virtual Environments

Flask promotes the use of a virtual environment to manage the dependencies of the project. 

```shell
# windows
>>> mkdir myproject
>>> cd myproject
>>> python3 -m venv .venv

# linux/macOS
$ mkdir myproject
$ cd myproject
$ python3 -m venv .venv
```

Active the environment:

```bash
# windows
> .venv\Scripts\activate

# linux/macOS
$ . .venv/bin/activate
```

You can install Flash easily using:

```bash
$ pip install Flask
```
## Quickstart

This will be a good intro to Flask.

### A Minimal Application

Super basic app is as simple as this:

```python
from flask import Flask

app = Flask(__name__)

@app.route("/")
def hello_world():
	return "<p>Hello, World!</p>"
```

Let's break this down:

1. We import Flask. 
2. We create an instance of the Flask class. This instance is our WSGI application. The first argument is the name of the application's module or package. We use `__name__` as a convenient shortcut. We need to specify this so Flask understands where to look for templates and static files.
3. `route()` is a decorator to tell Flask what URL should trigger said function.
4. The function we define, `hello_world()`, returns the message we want to display in the user's browser. Default content type is HTML.

We can save as script as `hello.py` or anything other than `flask.py` in order to avoid conflicts. 

To actually run the application, we use the `flask` command in our virtual environment by combing it with the following:

```sh
$ flask --app hello run
* Server Flask app 'hello'
* Running on http://127.0.0.1:5000 (Press CTRL+C to quit)
```

To make your life a little easier, you can name your application `app.py` or `wsgi.py`, you can avoid using the `--app` portion.

This works for testing and proof of concept, but isn't ideal for [production](https://flask.palletsprojects.com/en/3.0.x/deploying/). I need to follow a video on this, since I have yet to bring a project to production stage yet.

The server is only accessible via the device you are running it from. If you trust the users on your network, you can make the server publicly available by simply adding `--host=0.0.0.0` to the command line like so:

```sh
$ flask run --host=0.0.0.0
```


### Debug Mode

Using `flask run` is more capable than just allowing the start of the development server; you can enable debug mode, which will automatically reload if code is changed. It will also show an interactive debugger in the browser if an error occurs during a request.

Obviously, never run debug mode on production, to avoid tampering with code. 

In order to enable debug mode, just add it to your initial `run` command:

```sh
$ flask --app hello run --debug
* Serving Flask app 'hello'
* Debug mode: on
* Running on http://127.0.0.1:5000 (Press CTRL+C to quit)
* Restarting with stat
* Debugger is active!
* Debugger PIN: nnn-nnn-nnn
```


### HTML Escaping

Whenever you are returning HTML, which is the default response type in Flask, any user-provided values rendered in output must be escaped in order to prevent injection attacks. Thankfully, templates rendered with Jinja will do this for us automatically. 

If you want to achieve this manually however, it is possible. You can use the `escape()` command, show below:

```python
from markupsafe import escape

@app.route('/<name>')
def hello(name):
	return f"Hello, {escape(name)}!"
```

If we didn't use escape, and let's say someone wanted to attack us using the command `<script>alert('bad!')</script>`, the text would be rendered as HTML and not plain text, running said script.


### Routing

Everyday web apps use meaningful URLS to help users navigate them easier. We can make our URLS meaningful using routing.

We use the `route()` decorator to bind a function to a URL:

```python
@app.route('/')
def index():
	return 'Index Page'

@app.route('/hello')
def hello():
	return 'Hello world!'
```


7/20/2024
### Variable Rules

Using the following syntax, `<variable_name>`, we can add any passed variable into apart of our URL.

The function you use to get said variable should receive that variable via keyword argument. Or, you can specify further, with a converter to specify the type of argument:

```python
from markupsafe import escape

@app.route('/user/<username>')
def show_user_profile(username):
	# show the user profile for that user
	return f'User {escape(username)}'

@app.route('/post/<int:post_id>')
def show_post(post_id):
	# show the post with the given id, the id being an int
	return f'Post {post_id}'

@app.route('/path/<path:subpath>')
def show_subpath(subpath):
	# show the subpath after /path/
	return f'Subpath {escape(subpath)}'
```

A list of converter types:
 - `string`: (default) accepts any text without a slash
 - `int`: accepts positive integers
 - `float`: accepts positive floating point values
 - `path`: like `string` but also accepts slashes
 - `uuid`: accepts UUID strings


### Unique URLS / Redirection Behavior

There are two rules for trailing slashes:

```python
@app.route('/projects/')
def projects():
	return 'The project page'

@app.route('/about')
def about():
	return 'The about page'
```

For the first example, we have a trailing `/`. This will allow you to request the page with or without the trailing slash; the non-trailing slash will just redirect to the canonical URL with the trailing slash.

For our second example, we have no trailing slash. In this example if we were to call the `about` page with a trailing slash, we would get a 404 not found error. The difference between the two allows for unique pages.


### URL Building

To build out URL's for specific functions, we can use the `url_for()` function. It accepts the name of a function for it's first argument, and any number of keyword arguments afterword's (each one will correspond to a variable part of the URL rule). Any unknown variable parts are just appended to the URL as query parameters.

Why use `url_for()` instead of hard-coding the path?

1. Reversing is more descriptive than hard-coding
2. Easier modification of the URLs
3. URL building handles escaping of special characters
4. Generated paths are always absolute, avoiding unexpected behavior

In my project, [Lython]({{< ref "Lython" >}}), I would often use `url_for()` in order to redirect after authorization or moving pages. 

Below, we can see an example:

```python
from flask import url_for

@app.route('/')
def index():
	return 'index'

@app.route('/login')
def login():
	return 'login'

@app.route('/user/<username>')
def profile(username):
	return f'{username}\'s profile'

with app.test_request_context():
	print(url_for('index'))
	print(url_for('login'))
	print(url_for('login', next='/'))
	print(url_for('profile', username='John Doe'))
```

```python
/
/login
/login?next=/
/user/John%Doe
```


### HTTP Methods

Web apps use numerous HTTP methods when accessing URLs. By default, routes only handle `GET` requests. Using the `methods` argument, you can use additional HTTP methods.

```python
from flask import request

@app.route('/login', methods=['GET', 'POST'])
def login():
	if request.method == 'POST':
		return do_the_login()
	else:
		return show_the_login_form()
```

You're always able to separate views for different methods into different functions:

```python
@app.get('/login')
def login_get():
	return show_the_login_form()

@app.post('/login')
def login_post():
	return do_the_login()
```


### Static Files

Static files are the CSS and JavaScript files that need to be included as a part of your site/application. Not much of note here, other than you have the option to generate URLs for your static files as well, using:

```python
url_for('static', filename='style.css')
```


7/28/24
### Rendering Templates

The process of generating HTML from Python is a task that takes time, due to having to manually escape all of the HTML yourself. Flask uses [Jinja]({{< ref "Jinja" >}}) to make that happen automatically. 

Templates aren't just HTML files; they can also be markdown or plain text. Flask will access all templates in it's own separate `templates` directory.

Thankfully the syntax is simple:

```python
from flask import render_template

@app.route('/hello/')
@app.route('/hello/<name>')
def hello(name=None):
	return render_tempalte('hello.html', person=name)
```

And this is what the Template usually looks like:

```html
<!doctype html>
<title>Hello from Mr. Pointing!</title>
{% if person %}
	<h1>Hello {{ person }}!</h1>
{% else %}
	<h1>Hello, world!</h1>
{% endif %}
```

 Template inheritance is also possible, where a single template will feed itself into another. This is especially helpful when designing consistent looking pages. See [Lython]({{< ref "Lython" >}}) for example on how that ends up looking.


### Accessing Request Data

Its extremely important that your application responds/reacts to whenever a client sends something to a server. The `request` object from Flask handles this task for us.

#### Context Locals

There's a quick concept I want to illuminate, and that's the idea of safety. The `request` object is `global`, which could make the application unsafe. Flasks workaround for this is context locals.

The `global` object is actually just a proxy to actual objects that are local to some specific context. Flask sets this up with a pretty high level of abstraction, so it's not super important. 

The only thing I'd like to note is that this is a specific item for unit testing. So for the sake of moving on, I'll come back to this If I need help.

#### The Request Object

`request` is gone over in the API section so it's not gone over too in-depth here, but we can look at a quick example:

```python
from flask import request

@app.route('/login', methods=['POST', 'GET'])
def login():
	error = None
	if request.method == 'POST':
		if valid_login(request.form['username'],
		request.form['password']):
			return log_the_user_in(request.form['username'])
		else:
			error = 'Invalid username/password'
	# The next return only runs if the username/password was invalid or if the request method was GET
	return render_template('login.html', error=error)
```

Two uses of `request` here:

1. We use `request.method` to grab the type of request (GET, POST, etc.)
2. We use `request.form` to access form data (data sent from a POST or PUT request)

We can also grab parameters sent via URL (the value in `?key=value`) using the `args` attribute:

```python
searchword = request.args.get('key', '')
```


#### File Uploads

Handling uploaded files with Flask is pretty simple. 

You have to enable `enctype="multipart/form-data"` on your HTML form.

The files uploaded exist in the `files` attribute of your `request` object, and each file exists within a dictionary.

It works similarly to the `file` object built-into Python, but also has a `save()` method that directly stores the file on the filesystem of the server.

```python
from flask import request

@app.route('/upload', methods=["GET", "POST"])
def upload_file():
	if request.method == 'POST':
		f = request.files['the_file']
		f.save('/var/www/uploads/uploaded_file.txt')
```

[Uploading Files](https://flask.palletsprojects.com/en/3.0.x/patterns/fileuploads/) goes a bit more in-depth than this.


7/31/24

#### Cookies

I needed a refresher on what a cookie was honestly, so see [Cookies]({{< ref "Cookies" >}}) for that.

Through `request`, we can access the `cookies` attribute. Within Flask, the `cookies` attribute exists as a dictionary, containing all of the cookies the client transmitted. 

For Session cookies, you can use Flask's built-in Session area below.

Below are two examples on how to read in and store cookies:

```python
from flask import request

@app.route('/')
def index():
	username = request.cookies.get('username')
```

```python
from flask import make_response

@app.route('/')
def index():
	resp = make_response(render_template(...))
	resp.set_cookie('username', 'the username')
	return resp
```


### Redirects and Errors

If you want to send your user to another page, or provide context for any caught errors, you can use `redirect()` and `abort()` respectively. 

```python
from flask import abort, redirect, url_for

@app.route('/')
def index():
	return redirect(url_for('login'))

@app.route('/login')
def login():
	abort(401)
	this_is_never_executed()
```

Flask has a default error page for any unexpected exits. However, if you want to change this to something of your own design, you can use the `errorhandler()` decorator like so:

```python
from flask import render_template

@app.errorhandler(404)
def page_not_found(error):
	return render_template('page_not_found.html'), 404
```

In the above example, we write over the error page for any 404 errors, or when a page is not found.


### About Responses

Anytime anything is returned from a view function, it is converted into a response object. The logic behind what type that object becomes is up to Flask, and it has a specific order it follows:

1. If a response object of the correct type (meaning the return type is the same as the expected) is returned, it's just returned directly.
2. If it's a string, object is created with said string data and default HTTP parameters (`200 OK` status code and text/html mimetype).
3. If it's an iterator or generator returning strings or bytes, it is a streaming response.
4. If it's a dictionary or a list, the response object is called using `jsonify()`.
5. If it's a tuple, the items in the tuple usually provide extra info. They take a few basic forms, `(response, status)`, `(response, headers)` or `(response, status, headers)` are the most common. `status` will override any status code, and `headers` will take a list or dictionary to append any header values.
6. If all else fails, Flask assumes the object is a WSGI application and convert it into a response object. 

You can naturally modify your resulting response object inside your view using `make_response()`.

Let's grab our `page_not_found()` function from the section just above, and wrap it in a `make_response()` object type, add in new headers, then return it:

```python
from flask import render_template, make_response

@app.errorhandler(404)
def page_not_found(error):
	resp = make_response(render_template('page_not_found.html'), 404)
	resp.headers['Some heading'] = 'Some value'
	return resp
```


### APIs with JSON

Whenever you're writing API's, you'll likely encounter responses sent back in JSON. Flask conveniently converts any dictionary or list returned from a view into JSON.

```python
@app.route('/me')
def me_api():
	user = get_current_user()
	return {
		"username": user.username,
		"theme": user.theme,
		"image": url_for('user_image', filename=user.image),
	}

@app.route('/users')
def users_api():
	users = get_all_users()
	return [user.to_json() for user in users]
```