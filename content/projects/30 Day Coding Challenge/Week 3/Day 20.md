---
aliases: 
draft: false
tags:
  - computerscience
  - project
  - flask
  - python
title: Day 20
date: 2025-01-06
updated: 2025-01-07T19:04
---

-------------------------------------------------------------------------------


# Goal
---
- [x] Correctly sync the booking form to choose which type of session
	- [x] Caret drop down menu & link to appropriate function
		- [x] Small Tattoo Session
		- [x] Medium Tattoo Session
		- [x] Large Tattoo Session
		- [x] Small Tattoo Reschedule
		- [x] Medium Tattoo Reschedule
		- [x] Tattoo Touchup


# Accomplishments
---
Got a ton done today; walked through the Figma with Big Boss and was able to get going on the layout. Promising results on that front shortly.

I was able to get the quick note I made down below finished pretty quick, and glad I did since that will help out immensely when I start building out the search/filter feature. 

I also completely finished the Calendly connection I needed to make; when the artist fills out the booking info, they just choose the type, which value gets saved and used with the URL for the Calendly without having to write any crazy 5 condition if statement. Pretty proud of that one. 


# Problems or Issues
---
Quick thought: once accepted, the requests should not appear. A few ways I think this could be done:
- Make a column in the request database a Boolean for confirmed. If confirmed, should not appear in the requests side (just have to change the SQL command to grab only requests where the flag is 0)



---
Next: 
[Day 21]({{< ref "Day 21" >}}) 
