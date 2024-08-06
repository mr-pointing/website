---
aliases:
  - templater
draft: false
tags:
  - obsidian
  - formatting
title: Templater Formatting Notes
date: 2024-07-18
---
Modified: July 26 2024 

-------------------------------------------------------------------------------


{{ $image := .Resources.GetMatch "Date Formatting.png" }}
{{ with $image }}
  <img src="{{ .RelPermalink }}" width="{{ .Width }}" height="{{ .Height }}">
{{ end }}   


{{ $image := .Resources.GetMatch "Time Formatting.png" }} 
{{ with $image }} 
	<img src="{{ .RelPermalink }}" width="{{ .Width }}" height="{{ .Height }}"> 
{{ end }}

[Link](https://silentvoid13.github.io/Templater/introduction.html) to Templater Documentation.
