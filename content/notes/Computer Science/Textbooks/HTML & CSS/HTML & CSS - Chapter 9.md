---
aliases:
draft: false
tags:
  - computerscience
  - html
  - textbook
title: HTML & CSS - Chapter 9
date: 2026-02-23
updated: 2026-03-04T10:46
---

-------------------------------------------------------------------------------

# Video & Audio

 A large portion of this chapter focuses on older version of browsers and their support/lack-of for *Flash*, a type of video format to display media on web pages. HTML5 helps us out a lot by providing a `video` tag, which we'll go over in a second. Just wanted to point out again just how fast technology is moving. 

One thing that hasn't changed is the support for video playback formats. Depending on which you are using, formats like HEVC or WebM could not be supported. It's best to use MP4 formatting, as it is the most widely accepted.

## Video

HTML again provides a logical name for the `video` tag, our main method of providing local videos. It's technically a container but we should write out the way the next example shows, so we can get a clearer picture of all of the attributes in play here;

```html
<body>
	<h1>Catjam</h1>
	<video src="videos/cat.mp4"
		poster="images/cat.jpg"
		width="400" 
		height="300"
		preload="auto"
		loop="true"
		controls
		muted
	>
	<p>Cat jamming</p>
	</video>
</body>
```

The reason for the `p` tag is for having content appear if video format is not supported in their browser.

## Audio

Same as video content, we can use the `audio` tag to accomplish our audio goals.

```html
<body>
	<audio src="audio/cat-audio.mp3"
		controls auto-play>
	<p>This browser does not support our audio content</p>
	</audio>
</body>
```


---
Next: 
[Chapter 10]({{< ref "HTML & CSS - Chapter 10" >}}) 

