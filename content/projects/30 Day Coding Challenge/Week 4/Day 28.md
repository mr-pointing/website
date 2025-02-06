---
aliases: 
draft: false
tags:
  - computerscience
  - project
  - flask
  - python
title: Day 28
date: 2025-01-28
updated: 2025-02-01T16:28
---

-------------------------------------------------------------------------------


# Goal
---
- [x] Work on email formatting
- [x] Finish search for bookings
- [x] Look into pagination


# Accomplishments
---
I finished the searching for the bookings table, and tweaked the functions around a bit. This time, instead of creating a second search function, I made a new parameter `table` that takes in the type of table you want to search from. This way, I can just create a second view for the page to view the bookings. 

I also went over the work I did and noticed that the requests search would return everything even if they were already booked, so I just threw a quick if statement to check for the requests table and chuck a ` AND booked IS 0` at the end.

When looking into pagination, I saw it was actually quite easy to do. I watched a [video](https://www.youtube.com/watch?v=U18hO1ngZEQ) on how to split a list into pages, and it seemed like a good idea. There were more videos on using SQLAlchemy, which to be honest I don't know anything about so I'll have to do some research. I also think I could use SQL's `OFFSET` and get somewhere? I'll have to do more research on that as well. 



# Problems or Issues
---




---
Next: 
[Day 29]({{< ref "Day 29" >}}) 
