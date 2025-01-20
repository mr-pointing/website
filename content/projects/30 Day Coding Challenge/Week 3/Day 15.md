---
aliases: 
draft: false
tags:
  - computerscience
  - project
  - flask
  - python
title: Day 15
date: 2024-12-15
updated: 2025-01-02T09:37
---

-------------------------------------------------------------------------------


# Goal
---

From Yesterday:
- [ ] Set up text message for request
	- [ ] Client
	- [ ] Artist
- [ ] Integrate with Google Calendar 

For Today:
- [ ] Change calendar to full month and change the formatting


Had a talk with the boss, and she wants it to look a little bit different than the week-hour grid I had going on. Instead, I need each date to be clickable when available, and when clicked, needs to open up a little window in front with the available times. I need to account for multiple things;

- How to tell a new user what's available vs. not available
- How to communicate to the function making the above decision that if the hours that add up in the day don't add up to the *consistent* length of their appointment, that day is not available for them
	- Example: On a Monday, the Hours available are from 11am - 6pm. One person books an appointment from 12pm to 2pm, then another person books from 4pm - 5pm. A few questions come from this:
		1. How does the function know that if someone needs a 3-hour tattoo, the day does have 3 hours available, but are not consecutive, so that day is not available? 
		2. More so up to the artist, but could someone book a 3hr tattoo at 6pm? Personal preference perhaps.
	- In the grid view the logic is already accounted for so that this couldn't happen, but now it's possible. 

# Accomplishments
---



# Problems or Issues
---




---
Next: 
[Day 16]({{< ref "Day 16" >}}) 
