---
aliases: 
draft: false
tags:
  - computerscience
  - project
  - flask
  - python
title: Day 26
date: 2025-01-21
updated: 2025-01-24T15:36
---

-------------------------------------------------------------------------------


# Goal
---



# Accomplishments
---
I was able to get the progress from yesterday into a bit more of a tangible solution. Currently, in order to update the SQL table of when a booking has been confirmed, is when the embedded widget passes an event scheduled action, it will notify the window which will in turn send the scheduled events information to a Flask view. From there, I need to make another call using the events information unique identifier to retrieve the start time.

Not only do I need to format the start time, but it's also in central(?) time, which means I first need to convert to Eastern, then convert to human readable format. 


# Problems or Issues
---

One issue to keep on the forefront of my mind is how the filtering will work in regards to grabbing all the available bookings. I think if I have two checks, one for if the current date is before the date of the booking, and another for the `booked` column set to 1 or true. 



---
Next: 
[Day 27]({{< ref "Day 27" >}}) 
