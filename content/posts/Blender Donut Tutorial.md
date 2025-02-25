---
aliases: 
draft: false
tags:
  - computerscience
  - blender
  - graphic_design
title: Blender Donut Tutorial
date: 2025-02-16
updated: 2025-02-23T14:56
---
[Link](https://www.youtube.com/watch?v=B0J27sf9N1Y) to video series

-------------------------------------------------------------------------------

# Why Do I Want to Learn Blender?

My uncle is a huge inspiration in my life and career. I always admired his artistic ability, always drawing my favorite super heroes and other cool pieces. He ended working full time as a graphic design artist, and has been making killer 3D animations for years. 

This is another way of integrating what things I love, and also possibly picking up a new hobby. Let's see how this goes.

## Part 1: Introduction


Basic installation and walkthrough of getting started. Most importantly, how to add things into your scene, `Ctrl+A`. Super useful shortcut, and for the most part we are going to work with **meshes.**

**Render View Mode** can be toggled on to include directional lighting, which can be set by the position of the camera. More details on moving around and moving the camera are in the video.

**Renders**, or detailed stills of your camera view, can be made with `F12`.

A good cheat to move the camera with camera view enabled (`Numpad 0`) is to use `n` to open properties, select the `View` tab, then choose the `Lock Camera to View` option. This will move your camera to where your view is. 

To change the color of meshes, you should add a **material** to it, on the right side bar with the object selected. From there, you can select a color from the scale.

Hitting `s` on an object will activate the *Scale* property, allowing you to quickly alter the objects shape along the axis.

You also, when viewing through your camera lens, might want to quickly move something around, or rotate it. You can hit `r` to activate the *Rotate* tool, which will let you rotate your object around in place.

## Part 2: Basic Modeling

To make our donut, we should use the most donut-like starting object; the Torus. From there, we should edit the properties using `F9` to scale it accordingly. We could use a high major and minor segment count, but doing so will actually make our life harder down the road. It is easier to scale up than it is to scale down, and there are some neat tools that we can use to make it look like our low poly object is a higher resolution. For now, we can se our major to 32, and minor to 12.

To start with those tools to help us fake it till we make it, we can right click and hit **Shade Smooth**, which will make our object look a lot nicer. We should also add a *Modifier*, which will help our object smooth out even more. The little wrench icon in the bottom right after clicking on an object will allow you to add a **Subdivision Surface**, which essentially exponentially add details. 

Now that our object has the shape we like, we can deform it a bit to make it more realistic by hitting `Tab` to open up the vertex viewer, then click on a vertex to move it around. Moving one by itself though doesn't look great; you should use **Proportional Editing**, which can be turned on with the tiny circles button, and move multiple parts of your object in unison to get a more natural looking movement. If you want to select an entire edge, `Alt+Left Click` to select.

## Part 3: Modeling the Icing

Lots going on in this one, so be prepared for definitions. Without doing this as a frame of reference, none of this makes any sense.

Instead of creating a whole new shape, we know we just the top part of a donut, and that can become our icing texture. You can duplicate any object with `Shift+D`.

Now, you clearly don't want the icing covering the entire thing, or you might as well not include it at all. You'll have to select the entire bottom of the object and delete it. An easy way to do this is by using the toggle x-ray tool `Alt+z` to see through and select all the vertices at a time instead of just the one side your camera is looking at. Then, delete all vertices.

The icing looks pretty bad, since Blender is trying to render two faces on top of one another. To avoid this, we should try to keep them as close together as we can allow. To start, we should add a *solidify* modifier, and set the *offset* and *inner crease* to 1, and the thickness to something like 0.025. The inner crease will help later by making your icing look like it's more attached to the donut.

Sometimes your modifier will hide your mesh from view, in which case you need to toggle the view in the right side next to the modifier's name.

To actually drag out the icing and have it not clip into the donut, you need to do a few things. First thing, with the icing selected, you need to **snap** it (`Shift+Tab`) using *face project*, but that's not all. You'll also have to apply a subdivision modifier. It should already have one, so click the down arrow next the named subdivision modifier and click apply. This should make more faces appear in edit mode.

Sometimes you want to make part of your mesh unedited, or left alone. In our case, we don't want to affect the icing in the middle of our donut. We should select all of the vertices (`Alt-Click` them) and hide them with `h`. Now, you should be able to drag the icing around and make it more icing like.

To make specific portions droop down more without making the faces clip, you could elongate it with `e` and `click` for each new portion.

## Part 4: Sculpting

Now is a good time to check your icing to look for any issues. You could move each vertex individually if you have any clipping, or you could use a modifier. This time, we have the **shrink-wrap** modifier, used to attach one object to another and smooth out the connection. If you apply it *after* the subdivision it'll give you issues, so make sure to drag it to the top then hit `Apply`.

Now, if we wanted to add in detail that comes along with icing like the ability for icing to pile at the ends/bottom of the donut, currently we couldn't grab any vertex and change it to look nice at all. First, we have to *apply* our **solidify** modifier, so we can actually get the 3D mesh. Then, *apply* our **subdivision** modifier with a viewport resolution of 2. This will actually let us edit in the version it's going to look like. 

Now that we're set up, we can use the ***Sculpt*** tool, which acts like a brush to do certain elements faster than individually clicking each vertex.

Technically these next few including Sculpt are brushes, so that's how I'll be referring to them. The next useful one is **Grab**, that works like a finger to push your objects as if they were clay.

Making a **Mask** is telling Blender an area you *don't* want to affect; by default, when doing something like **Inflating** (or making objects larger) you would inflate everything except what's chosen in the mask. If you want to select the mask, you would need to invert it.

The **Smooth** brush allows you to easily smooth out textures. You should do this anytime you have any *artifacting*.


## Part 5: Shading

Time to add some colors to things. I noticed that in my process of creating the donut, I have a few more vertices than him in the viewport, so I might have added another layer of complexity. I'm also getting some jagged edges in rendering, which I might have to add another layer for just that later.

For now, add the *material* for color to the icing and the donut. We're going to have to make a table for our donut to sit on, so we should use the **plane** mesh that will act as our table. Scale it out to an appropriate size. The problem now is that if we move our donut, the icing won't follow. To avoid this, make the icing a child of the donut. Click the icing, then `Ctrl` click the donut, and hit `Ctrl+P`.

This part is pretty complicated so strap in. We want to add a texture to the plane. Let's do a Marble countertop as our goal. We can go grab a random marble from this guy's website (have to pay for most but a good amount are free) and we can apply it to the plane, by clicking the yellow circle next to the material's color and choosing Image. 

To me it looked great, but he pointed out that the marble was really flat, so we're going to have to modify a little more. Instead of using the tool bar on the right, we're going to go to an entirely different area called ***Shading***.  This will give us more direct control over our elements via the Node system, which shows a workflow our how our object is modified from start to finish (left to right).

Refer to the video for this part because it is hard to explain writing it out, but you need to create two more nodes, one for the Roughness and one for Normal (which will actually provide more textures). There's some funny stuff with colors going on that he doesn't outright explain, so I'd rather not butcher it. Essentially there are some settings that have to be changed around color for Blender to display the textures correctly. 

After those are done, there's one filter we have to add before we attach the normal mapping to the plane. We need a **Normal Map**, which will provide those bumps, scratches, and smudges on the countertop.

To get an even more realistic feel for our donut, we can isolate it (click it and hit `/`) and notice there is no whiter ring along the outside of our donut. Real donuts have this because they're cooked less on the outer-most rim.

We can add that by clicking on our donut and creating an *Image Texture*. First go to the **Texture Paint** tab and go to materials. Click the yellow circle next to color to select image texture, then select `New`. Call it `donut_base.png` or something, and set some default colors with the default resolution. On the left side of the screen, on the photo icon, click the `donut_base` image. Now, we can paint directly onto our mesh. Mess around with the colors and the brush levels to get the type of look you desire.

