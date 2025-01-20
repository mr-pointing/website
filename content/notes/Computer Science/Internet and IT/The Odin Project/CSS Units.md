---
aliases: 
draft: false
tags:
  - computerscience
  - html
  - css
title: CSS Units
date: 2025-01-11
updated: 2025-01-11T11:25
---

-------------------------------------------------------------------------------

There are mainly two types of ways to define sizes in CSS; *absolute* and *relative*. Absolute units are any measurement where the size will retain the same size no matter what; regardless of the other elements on screen, and screen size. The only absolute unit that should be in use is pixels, or `px`.

The other, relative, change based on a few factors. When using text, you'll want to use `rem` or `em`, but most likely just `rem`. When using `rem` for font size, you're setting the font size of the root element, which means as scale increases so does your text.

Viewports also receive a unit of relative measurement, `vh` and `vw`, for viewport height and width respectively.

[Link](https://developer.mozilla.org/en-US/docs/Learn_web_development/Core/Styling_basics/Values_and_units) for all CSS units.
[Link](https://codyloyd.com/2021/css-units/) for overview on units.
[Link](https://css-tricks.com/fun-viewport-units/) for more info on viewports.
