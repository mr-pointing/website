---
aliases: 
draft: false
tags:
  - computerscience
  - project
  - python
  - flask
title: Day 14
date: 2024-12-14
updated: 2024-12-14T19:01
---

-------------------------------------------------------------------------------


# Goal
---
From Yesterday:
- [ ] Set up text message for request
	- [ ] Client
	- [ ] Artist

For Today:
- [x] Refactor for Yagmail instead of Gmail's Oauth2 set up
- [x] Refactor requests for asking for consent for text messages
- [x] Create JSON file for artist schedule
	- [ ] Integrate with Google Calendar? (maybe way down the line)
- [x] Make a confirm booking button that checks to make sure there is no issue with timing

# Accomplishments
---
Getting a lot done today; more so with understanding how the calendar features work for Fullcalendar. So far, I know I'm going to use a Grid view, and I'm currently able to place events anywhere with the limit set by the artist. 

Some things I got done were the ability to only show times from 11am to 11pm to avoid crazy time placements, I was able to work on the request page to include an easy consent button, and moved the artist's temporary schedule into a JSON file. 

I also moved the dummy email and password in after switching to an app password (see below) and started using Yagmail. Not only is my code a little cleaner, but I also understand a lot more of it since I'm the one who wrote it. Not very complex, but I understand what's happening a little clearer and I don't have to deal with forgetting to renew my credentials.

# Problems or Issues
---
I ran into the issue where since the Oauth2 consent is only available for a limited time, I was up against a wall for almost a half hour trying to figure out why my email features weren't working. Because of that, I just said screw it, used two-factor authorization for my test Gmail, and made an app password. With that, I can keep that in the `artist_info.json` file so I don't commit any passwords. This way, there is no pesky expiration date.

I ran into an issue where I thought I could nicely use Jinja to insert the client information and use it for making events in the calendar. I could, I just didn't realize I needed to add `| tojson` in order for it to work. 

An issue currently with the calendar is that a client can potentially make the booking on an unavailable day, or a day where the entire time slot is taken.

A huge issue I realized with this calendar feature is that I don't know JavaScript at all. The process for this project has been usually me going as far as I can, run into a wall, see if I can fix it (have been able to fix a decent amount by myself actually), and if not run it through Google then AI. Google has been able to give me some help, but for the JavaScript AI has been a big help. After this project I think I'm going to have to spend some more time learning basic JavaScript.


---
Next: 
[Day 15]({{< ref "Day 15" >}})

