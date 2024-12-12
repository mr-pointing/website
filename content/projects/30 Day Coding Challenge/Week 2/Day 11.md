---
aliases: 
draft: false
tags:
  - computerscience
  - project
  - flask
  - python
title: Day 11
date: 2024-12-11
updated: 2024-12-11T16:08
---

-------------------------------------------------------------------------------


# Goal
---
From Yesterday:
- [ ] Set up text message for request
	- [ ] Client
	- [ ] Artist
- [ ] Accept Request & Booking Feature
	- [x] "Accept" button HTML site
	- [x] Booking HTML site
	- [ ] Booking Python file (refactor requests to make recs_books?)


# Accomplishments
---
I got a Twilio phone number waiting to be verified, added the booking form and all the logic to get there, as well as fixed a small issue where requests were stuck and would re-send after refreshing the page. 


# Problems or Issues
---
Text Magic kind of sucks. I tried for way too long to try and get it working, but it was stubborn as a bull. The install didn't have any code in it's files, and the docs on their website did not work at all. Not a fun time.

I moved onto Twilio, which takes a whole song and dance to set up. The actual creation of the functions to send the messages is trivial, but this verification process might be a larger hassle than I'd prefer to deal with. For now I'll skip past it and come back later, and focus on the other things I need to get done.

I ran into this issue when trying to set up the `index()` view: I knew I needed to create another form/button combo on each request so that the artist can click whichever one and fill out the appropriate booking form. I made the form and button on my own, but was confused on where to put the logic for it. I originally had this:

```python
@bp.route('/admin/index', methods=('GET', 'POST'))  
def index():  
    if session.get('user_id') == 1:  
          
        current_requests = get_requests()  
        return render_template('auth/index.html', current_requests=current_requests)  
    else:  
        return redirect(url_for('admin.login'))
	
	if request.method == 'POST':  
	    request_id = request.form.get('accept_request')  
	    if request_id:  
	        return redirect(url_for('admin.booking', request_id=request_id)) 
```

My problem was I was using the check for `POST` *after* rendering the form, which was wrong. The correct implementation became:

```python
@bp.route('/admin/index', methods=('GET', 'POST'))  
def index():  
    if session.get('user_id') == 1:  
        if request.method == 'POST':  
            request_id = request.form.get('accept_request')  
            if request_id:  
                return redirect(url_for('admin.booking', request_id=request_id))  
  
        current_requests = get_requests()  
        return render_template('auth/index.html', current_requests=current_requests)  
    else:  
        return redirect(url_for('admin.login'))
```

I also resolved the issue for the `POST` being kept after the user submits a request form, all I had to do was change the `return_template` into a `redirect(url_for())` which stopped that. 

---
Next: 

