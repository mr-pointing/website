---
aliases: 
draft: false
tags:
  - computerscience
  - project
  - flask
  - python
title: Day 12
date: 2024-12-12
updated: 2024-12-14T16:22
---

-------------------------------------------------------------------------------


# Goal
---
From Yesterday:
- [ ] Set up text message for request
	- [ ] Client
	- [ ] Artist

For Today:
- [x] Booking Python file
- [ ] Figure out how Google Calendar works

# Accomplishments
---
Had a good talk with the boss about the structuring of the site so far. I had misunderstood the need for a "fast form", it really should just be a button that sends a booking form that she fills out the request details and customer information for. 

I was able to get the basic page for the booking form back to the user, as well as the email back for the confirmed booking.


# Problems or Issues
---

I feel like I've ran into this issue before, so I better document it. When trying to see if the token was actually made or not, I tried to make a `booking_tokens` variable that was the `fetchall()` of a query to get all bookings. I didn't realize that they were returned as tuples, which was why my logic was failing. What was

```python
booking_tokens = db.execute('SELECT token FROM bookings').fetchall() 
print(booking_tokens) 
if token in booking_tokens: 
	return render_template('client_booking.html', request=client_info) 
else: 
	return redirect(url_for('landing.landing'))
```


---
Next: 
[[Day 13]] 
