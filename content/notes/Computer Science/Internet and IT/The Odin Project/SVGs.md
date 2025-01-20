---
aliases: 
draft: false
tags:
  - computerscience
  - html
title: SVGs
date: 2025-01-09
updated: 2025-01-09T17:16
---

-------------------------------------------------------------------------------


SVGs is an image formatting type, known for its use in web design. It is used so commonly due to it being scalable (part of the name, *Scalable Vector Graphics*) and compatibility with CSS and JavaScript. Use cases range from icons to simple graphs and images, even backgrounds.

The main reason to use an SVG instead of a pixel based format would be the resolution not being so limiting. To increase the size of an image using what we call *raster graphics* would be stuck having to adjust for pixels not originally intended to be concerned with. SVGs on the other hand use mathematical formulas, which can scale up and down easily without issue.

SVGs are actually defined using *XML*, or Extensible Markup Language. If you open an SVG, it will look extremely similar to HTML. Because of this, photorealistic detail is hard to create with SVGs, so if that's what you're looking for you're better off going with something else.

Below is an example of XML;

```xml
<div class="container">
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 100 100">
    <rect x=0 y=0 width=100 height=100 fill="burlywood"/>
    <path d="M 10 10 H 90 V 90 L 10 60" fill="transparent" stroke="black" stroke-width="3"/>
  <circle cx=50 cy=50 r=20 class="svg-circle"/>
    <g class="svg-text-group">
      <text x="20" y="25" rotate="10" id="hello-text">Ayo</text>
      <use href="#hello-text" x="-10" y="65" fill="white"/>
    </g>
</svg>
</div>
```

along with corresponding CSS;

```css
.container {
  max-width: 200px;
  margin: auto;
}

.svg-circle:hover + .svg-text-group {
  opacity: 0;
}
```

You'll find the elements slightly familiar. Tags like `class` and `div` work the same they do in HTML. `svg` is an important tag, telling the browser what format to generate the image in (SVG) as well as the `viewBox`, which alters the borders/view of the image. Playing with the numbers proves to be interesting, as nothing I thought would work made much sense. 

For now, the best way to go about using an SVG seems to be inline, which is pasting the code directly into your web page. You get full access to the content and can use CSS with it, and have overall more control. The only downside being more complicated SVGs become hard to read, but apparently things like **React** fix that.

[Link](https://developer.mozilla.org/en-US/docs/Web/SVG/Element) for SVG elements.
[Link](https://feathericons.com/) for open source basic SVGs.
[Link](https://yqnn.github.io/svg-path-editor/) to create your own SVGs.