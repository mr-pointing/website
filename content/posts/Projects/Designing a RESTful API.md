---
aliases:
  - REST
  - RESTful
draft: false
tags:
  - computerscience
  - api
  - project
  - python
  - tutorialnotes
  - internet
  - flask
title: Designing a RESTful API
---
Created: June 20 2024
Modified: August 02 2024

-------------------------------------------------------------------------------

Watched [this](https://www.youtube.com/watch?v=-mN3VyJuCjM) video to take some notes on what REST is.

API: Application Programming Interface, is how to computers can communicate with each other.

Client sends a Request to the server, server sends a response back to the client.

REST, or Representational State Transfer, is the most popular way to communicate with these web servers.

REST is actually a set of rules and standards. Any API that follows the REST rules is known as a RESTful API.

Stripe and Google Maps are two examples. 

RESTful API organizes resources into a set of unique URI's (uniform resource identifiers):

```
https://example.com/api/v3/products
https://example.com/api/v3/users
```

The URI's differentiate different types of resources on the sever.


{{ $image := .Resources.GetMatch "Pasted image 20240620090314.png" }} 
{{ with $image }} 
	<img src="{{ .RelPermalink }}" width="{{ .Width }}" height="{{ .Height }}"> 
{{ end }}

When requesting, the format has to be specific. Since the client is communicating with the server over HTTP, the request often looks something like this: `POST /products HTTP/1.1`. The URI is preceded by an HTTP verb, POST, that tells the server what we want to do with the URI resource.

POST is to create a new resource.
GET means we want to read data about an existing resource.
PUT is for when you want update an existing resource.
DELETE is for removing an existing resource.

In the body of any of the previous requests, there can exist an additional HTTP request body that contains a custom payload of data, usually in JSON. Server receives request, processes it, then formats the result into a response.

The first line of the response has a HTTP status code to let the client know what happened.

200 means the request was successful. 
400 means something was wrong with the request.
500 means something was wrong with the server. 

Idempotent refers to an action, that when performed multiple times on the same subject, it has no further effect on it's subject after the first time it's performed. 


{{ $image := .Resources.GetMatch "Pasted image 20240620091713.png" }} 
{{ with $image }} 
	<img src="{{ .RelPermalink }}" width="{{ .Width }}" height="{{ .Height }}"> 
{{ end }}

A RESTful API should be stateless; the client and server should not store any information about one another, and every request and response (cycle) is independent from all others.

-------------------------------------------------------------------------------

Taking notes from [this](https://blog.luisrei.com/articles/rest.html) article on more REST

**How to design a RESTful Web API**

Everything is a resource; every interaction is an interaction with a resource. We can simplify all REST calls as mapping and endpoint to a resource, which becomes our URL.

This article uses URL, while the previous uses URI. For simplicities sake, I'll use URL for the rest of the notes on this article.

An example of a resource: a user can be a resource, and would have the following URL:

```
https://api.github.com/users/rpointing
```

Resources have different representations. The example above might have some JSON representation:

```
{
	"login": "rpointing",
	"created_at": "1997-05-01T21:00:00",
	"name": "Richard Pointing",
	"email": "rpointing@gmail.com",
	"id": 58632,
	"blog": "https://jobanyrosario.com"
}
```


Resources are nouns, and actions are verbs. Actions are HTTP verbs, aka request methods.

- GET: Retrieves a representation of a resource without side-effects (no changes to the server)
- HEAD: retrieves just the resource meta-information (headers) i.e. same as GET without the response body or side effects
- OPTIONS: Returns the actions supported by the specified resource
- POST: Creates a resource
- PUT: (completely) replaces an existing resource
- PATCH: Partial modification of a resource
- DELETE: Deletes a resource

We attach information after the URL:

```
POST https://api.github.com/gists/gists
{
	"description": "The description for this gist",
	"public": true,
	"files": {
		"file1.txt": {
			"content": "String file contents"
		}
	}
}
```

If its not a resource or an action, the rest goes in the header.

**Content Negotiation** is how we chose between different representations of the same resource.

```
GET https://api.github.com/gists/1
Accept: application/json

# or

GET https://api.github.com/gists/1
Accept: application/xml
```

One will retrieve the JSON representation of the resource, the other will get the XML version. You can even specify compression or language.

**Caching** is the process of storing responses from API requests. The two main response headers they go over here are *Expires* which specifies an absolute expiry time for cached representations, and *Cache-control* which specifies a relative expiry time using max-age directive.

Both work with *ETag*, which is an identifier, commonly stored as a hash, meant to change when the resource changes, invalidating cached versions of the object.

**Authorization** is what keeps anyone from making POST requests to any server at any given time. Basic HTTP authentication should be used with HTTPs to ensure safety.

**Rate Limiting** allows you to set the amount of calls a client can make to the server. 

```
>>> GET https://api.github.com/gists/1
200 OK
X-RateLimit-Limit: 5000
X-RateLimit-Remaining: 4966
```

The Limit is the total amount allowed (per hour), and the remaining is the amount left to make before the limit is reached. 

6/25/2024

**HATEOAS, Options, and Error Handling**

"A REST API must not define fixed resource names or hierarchies (a coupling of client and server). Servers must have the freedom to control their own namespace...A REST API should be entered with no prior knowledge beyond the initial URI" - Roy Thomas

Basically in a REST based architecture, any URL besides the initial URL can be changed, even to other servers without worrying about the client.

HATEOAS stands for Hypermedia As The Engine Of Application State, and is the thinking of the API as a state machine where resources are thought of as states and the transitions between states are links between resources. 

```
GET https://api.spire.io

# results in 

200 OK
{
	"url": "https://api.spire.io/",
	"resources": {
		"sessions": {
			"url": "https://api.spire.io/sessions"
		},
		"accounts": {
			"url": "https://api.spire.io/accounts"
		},
		"billing": {
			"url": "https://api.spire.io/billing"
		}
	}
}
```

In the above example, the root resource, or what we call the *initial state* contains the transitions to the other resources (states) reachable from it: "sessions", "accounts", "billing".

Like we saw in the list above, OPTION will return the actions that can be performed on any given resource.

```
OPTIONS https://api.spire.io/accounts

# results in

Status Code: 200
access-control-allow-methods: GET,POST
access-control-allow-origin: *
```


Error responses should consist of:
 - The appropriate HTTP error status code with relevant headers
 - A human readable message in the appropriate format
 - A *Link* header to a meaningful state transition if appropriate

```
GET https://api.twilio.com/2010-04-01/Accounts.json

# results in

401 Unauthorized
WWW-Authenticate: Basic realm="Twilio API"
{
	"status": 401,
	"message": "Authenticate",
	"code": 20003,
	"more_info": "http:\/\/www.twilio.com\/docs\/errors\/20003"
}
```


-------------------------------------------------------------------------------

Starting [this](https://blog.luisrei.com/articles/flaskrest.html) project.



We're going to use Flask for this for a few reasons: 
 - Flask is written in Python
 - Simple to use
 - Flexible
 - Many different deployment options
 - RESTful request dispatching

**Resources**

We can start the app by implementing a response for the root, an articles page, and accessing a specific article:

```python
from flask import Flask, url_for
app = Flask(__name__)

@app.route('/')
def api_root():
	return 'Welcome'

@app.route('/articles')
def api_articles():
	return 'List of ' + url_for('api_articles')

@app.route('/articles/<articleid>')
def api_article(articleid):
	return 'You are reading ' + articleid

if __name__ == '__main__':
	app.run()
```

In order to actually run these events, you can run the code and use the following prompts to start getting responses:

```
>>> GET /
Welcome

>>> GET /articles
List of /articles

>>> GET /articles/123
You are reading 123
```

Special note about using variables in the example above: if you want to specify exactly what data type the variable should be, use it like so:

```python
@app.route('/articles/<int:articleid>')
@app.route('/articles/<float:articleid>')
@app.route('/articles/<path:articleid>')
```

6/27/2024

**Requests**

The following code works with GET requests as well, and is a bit more complex than the above examples:

```python
from flask import request

@app.route('/hello')
def api_hello():
	if 'name' in request.args:
		return 'Hello ' + request.args['name']
	else:
		return 'Hello stranga!'
```

We can use the following calls on the above (going forward I'll use the convention of using RESTED Chrome application):

```
>>> GET http://127.0.0.1:5000/hello
Hello stranga!

>>> GET http://127.0.0.1:5000/hello?name=clifford%20the%20big%20red%20dog
Hello clifford the big red dog
```

We can specify the request methods that can be called on a resource by specifying the methods in the app route:

```python
@app.route('/echo', methods = ['GET', 'POST', 'PATCH', 'PUT', 'DELETE'])
def api_echo():
	if request.method == 'GET':
		return "ECHO: GET\n"
	elif request.method == 'POST':
		return "ECHO: POST\n"
	elif request.method == 'PATCH':
		return "ECHO: PATCH\n"
	elif request.method == 'PUT':
		return "ECHO: PUT\n"
	elif request.method == 'DELETE':
		return "ECHO: DELETE"
```

6/29/2024

We can specify further what type of data can be requested and what to do when certain types are requested:

```python
@app.route('/messages', methods = ['POST'])  
def api_message():  
    if request.headers['Content-Type'] == 'text/plain':  
       return "Text Message: " + request.data  
    elif request.headers['Content-Type'] == 'application/json':  
       return "JSON Message: " + json.dumps(request.json)  
    elif request.headers['Content-Type'] == 'application/octet-stream':  
       f = open('./binary', 'wb')  
       f.write(request.data)  
       f.close()  
       return 'Binary message written!'  
    else:  
       return "415 Unsupported Media Type! ;)"
```


**Responses**

Flask has  built in Response class to handle responses:

```python
@app.route('/hello', methods = ['GET'])  
def api_hello():  
    data = {  
       'hello': 'world',  
       'number': 3  
    }  
    js = json.dumps(data)  
  
    resp = Response(js, status=200, mimetype='application/json')  
    resp.headers['Link'] = 'https://jobanyrosario.com'  
  
    return resp
```

will return the following:

```
# header
Server: Werkzeug/3.0.3 Python/3.9.13 Date: Sat, 29 Jun 2024 16:35:18 GMT Content-Type: application/json Content-Length: 31 Link: https://jobanyrosario.com Connection: close

# output
{ 
	"hello": "world",
	"number": 3 
}
```

*Mimetype* acts as the content's type without including additional information (like charset, encoding, etc.). Flask also has a built-in method that makes generating JSON responses easier. By including the header `jsonify`, you can replace the `Response` initialization with the following:

```python
resp = jsonify(data)
resp.status_code = 200
```

This will generate the same response as before.  I took out the second line (specifying the status code) and it still gave me a response code of 200, so that second line might be optional (making it even more useful).


**Status Codes & Errors**

Even if there aren't many circumstances where handling a 200 status code is necessary, it can be for error handling. In the following example, we create a handler that can deal with any 404 error the API receives, as well as an example of how it can be used usefully:

```python
@app.errorhandler(404)  
def not_found(error=None):  
    message = {  
       'status': 404,  
       'message': 'Not Found ' + request.url  
    }  
    resp = jsonify(message)  
    resp.status_code = 404  
  
    return resp  
  
@app.route('/users/<userid>', methods = ['GET'])  
def api_users(userid):  
    users = {'1': 'Alex', '2': 'Jaime', '3': 'Akuma'}  
  
    if userid in users:  
       return jsonify({userid:users[userid]})  
    else:  
       return not_found()
```

You could also overwrite error messages using the `@error_handler` decorator above, or in the following way:

```python
app.error_handler_spec[None][404] = not_found
```


**Authorization**

In the below code, we begin handling HTTP Basic Authentication:

```python
from functools import wraps

def check_auth(username, password):  
    return username <mark> 'admin' and password </mark> 'secret'  
  
def authenticate():  
    message = {'message': 'Authenticate.'}  
    resp = jsonify(message)  
      
    resp.status_code = 401  
    resp.headers['WWW-Authenticate'] = 'Basic realm="Example"'  
    return resp  
  
def requires_auth(f):  
    @wraps(f)  
    def decorated(*args, **kwargs):  
       auth = request.authorization  
       if not auth:  
          return authenticate()  
       elif not check_auth(auth.username, auth.password):  
          return authenticate()  
       return f(*args, **kwargs)  
      
    return decorated
```

In the above example, to reiterate, `*args` takes in any *positional* arguments passed and keeps them as a tuple, and `**kwargs` allows the function to take in any number of *keyword* arguments, stored as a dictionary. These are helpful to keep the function flexible, and able to take in any function with any amount of parameters. 


**Simple Debug & Logging**

In order to debug while developing, you can easily set `debug=True` when calling the app to start running:

```python
app.run(debug=True)
```

Flask uses python logging off the rip:

```python
import logging
file_handler = logging.FileHandler('app.log')
app.logger.addHandler(file_handler)
app.logger.setLevel(logging.INFO)

@app.route('/hello', methods=['GET'])
def api_hello():
	app.logger.info('informing')
	app.logger.warning('warning')
	app.logger.error('screaming bloody murder!')

	return 'Check your logs!\n'
```


