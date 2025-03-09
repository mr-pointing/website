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

## Part 6: Geometry Nodes

We're going to start creating our sprinkles by creating new *Geometry Nodes*. There is a heading tab we have to switch too, and we can generally get rid of the spreadsheet on the top left. Now with our icing selected, click "New". Geometry Nodes are actually modifiers, so you should also see a new modifier on the bottom right.

Now, what we're actually doing here is giving our mesh objects more options by choosing different ways of manipulating our mesh, then passing them into our node system. Once there, anywhere in Blender I can now easily access whatever changes I set up to make. For the sprinkles, we want random points across our mesh, so use `Shift+A` to go to `Point`, then `Distribute Points on Face`. This node should go between the connection of input and output (into mesh). 

This is only halfway there, however. What actually happened here was that it took the icing mesh, made it these points, and fed it back to us. This *isn't* what we want, since we want both the mesh and these new points. This is where we use `Shift+A` to `Geometry`, then use the `Join Geometry` features to connect the distribution node we just made to the output. We will also have to drag a line from the input into the join node to actually create that join.

Making the sprinkle is really easy, just use `Shift+A` to create a UV Sphere Mesh. Since it will be used many times over and will be small, we can make it low resolution at 12 segments and 8 rings, and a size of `0.01 meters` . Since we've created our sphere, we can easily use the top right menu to drag it into our Geometry Nodes work area for our icing.

To get this sphere to be represented by the node we have creating points on our icing, we can use another node called `Instance on Points`. This should go between your distribution node and join node. This instance node replaces the nodes with whatever is passed into it. So, we know we just dragged in our sphere mesh, drag from the geometry out on the sphere node to the instance input on the instance node.

If you increase the density, you'll notice quickly the sprinkles are so random they're inside of one another. This can be avoided by using *Poisson Disk* distribution, which gives you the ability to change the distance minimum between points. Set to a value of 0.012 is a good start, as going too far apart will look a little unrealistic.

We also have a ton of sprinkles everywhere, any I mean everywhere. Even on the inside of our mesh. This is going to cause our machine to work harder to render it, even though there are things we're not even seeing. To avoid this we use **Weight Painting**. On the top left, hit the Object View drop down and choose Weight Paint. Your donut should turn blue; just for the sake of starting, draw a circle on top of your icing.

You should notice the circle you painted is a bright red, with other green and yellow around the edges. This is going to act as our area of effect for our distribution of sprinkles. Donuts naturally have more sprinkles in the part dipped into the sprinkle tray, which is more often than not a perfect circle on the top most part of the donut. Creating a thick ring with some imperfect spots here and there will do us justice, but we have to call it into action.

First up, make sure the paint brush stroke you made was only on the front of your mesh by using the `front faces only` option under the advanced drop down on your object view tool bar. Your new brushed circle exists as a data object, and we should name it something useful (we're about to use it). Then, from your density factor input option on your distribution node, drag out and select named attribute. Then, you're going to choose the name you just made for your sprinkles.

If we made a duplicate of our donut and changed the Geometry Nodes values directly from the menu nodes, it'll change both. However, if you want some option to be specific to each object, you can drag any input out into the origin input node, so each will have it in their properties.

If you look at the properties of our donut, you'll notice it's around 1.2 meters across. That's about 4 feet long in America, which is huge for a donut. To fix this, we have to scale it down. Select everything and hit `s` and use `Ctrl` to go down by constant values. if we're at 1.2 meters, 0.12 would be more accurate.

The scale isn't applied yet though. Select everything, `Ctrl+A`, and hit `Apply Scale`. You'll notice it works if your sprinkles look messed up. You'll have to massively increase your density for sprinkles. You can either increase it by around x10,000 or use a math multiplier node between.

## Part 7: Long Sprinkles

Right off the bat, we have our first conversation about the 3D cursor. The 3D cursor is where any newly created object will be placed. We want to see our sprinkle so we should probably move it to the plane (`Alt+Right Click`).

The long sprinkle is a cylinder. Bring it down to the smallest size, then just 12 vertices. I had some trouble moving the sprinkles around, for whatever reason the mesh would zoom into the plane if my cursor was over the plane. In his video it worked fine, not sure what setting I had on that made that happen.

We'll need to round out the ends of the sprinkle, so hit `Tab` and *face select* (3) to select the top and bottom face, and use `Ctrl+B` to apply a bevel. Scroll up on the mouse wheel a bit to apply more geometry, but not too much. Then You have a nice rounder edge. Don't forget to apply smooth shading. 

Use duplicate to make another sprinkle, and we'll create our medium size. Hit `Tab` and enter vertex select. Select the top vertices, then `G`, and `X` to move along the X axes. Do this again for your large sprinkle. We also want one more of the large sprinkle so we can bend it.

To create more geometry to enable a bend, we'll need a loop cut. Hit `Ctrl+R` and scroll up to use about 8 cuts. We could bend it now, but there's actually a nice modifier that will accomplish that for us. Hit modifier and search for a *Simple Deform* modifier. Select `Bend` and it'll create really easily maneuverable bending motions in whatever angle you'd like. 

You'll notice the bend is centered at the bottom of the sprinkle. That's because that's where our origin point is, the little yellow/orange circle that's on every mesh object. We should move this to the center of all of our sprinkles. Use `Ctrl` to select all your sprinkles, then use `Right Click` to select `Set Origin`, then select `Origin to Geometry`.

Now to help for getting the sprinkles onto the icing, we need to put them in a collection in the top right. Once in a folder, duplicate the donut and make sure to click the two next to the icings geometry nodes modifier, so each donut is separate.

Then, hop on over to Geometry Nodes. Take out the current node attached to the `instance` path on the `Instance on Points` node. That was our round sprinkles, now we need our long ones. Take the collection we made and drag it into the Geometry Nodes environment. Then attach that to where the round sprinkles were. Hit Reset Children, Separate Children, and Pick Instance.
