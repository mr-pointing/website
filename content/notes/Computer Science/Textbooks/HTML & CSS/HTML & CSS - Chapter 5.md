---
aliases:
draft: false
tags:
  - computerscience
  - textbook
  - html
title: HTML & CSS - Chapter 5
date: 2026-02-02
updated: 2026-02-03T14:53
---

---

# Images

Obviously, there are numerous reasons for why we would want to add images to our web pages. How we integrate and present them well, however, is the most important part, and we're going to learn exactly how to do that in this chapter. The first image you see really sets the tone for the rest of the visit with your sight, so choosing the right type of image is key.

You should be able to use your own images when creating your own site, but there's also nothing wrong with getting _stock images_. These are images that are either free to use or paid for via some distributor. Here's a list of images you can either pay for or use for free;

- www.istockphoto.com
- www.gettyimages.com
- www.veer.com
- www.sxc.hu
- www.fotolia.com

Some of the best images for websites are simple with a good color scheme. The more busy your photo is, the more busy your site looks, which isn't always the best. Like we saw in the last chapter, we had a sub-directory in our project called "images"; this is considered best practice, and sub-dividing your images if you have a lot of them is also heavily encouraged.

## Adding Your First Image

Adding an image requires use of the `img` tag, and requires a few things;

- `src`: where the image is located
- `alt`: Alternative text used as a text-description for the image if not shown
- `title`: Secondary info about the image, usually displayed if hovered over with your mouse cursor
- `height`: Height of the image
- `width`: Width of the image

All of these are optional with the exception of the source, so obviously use them appropriately. Images will appear wherever you place them, so be sure to take caution on how your page will be structured to make sure your images look nice.

If you want to have a caption for your image, you should place your image in a `figure` tag, and your caption inside a `figcaption` tag, like so;

```html
<figure>
  <img
    src="images/otters.jpg"
    alt="Picture of two otters sleeping holding hands"
  />
  <br />
  <figcaption>
    Sea otters hold hands while they sleep so they don't drift away from each
    other while sleeping
  </figcaption>
</figure>
```

## Rules for Images

There are three rules we can use to make sure we use good images;

1. Save all images in the right format
2. Save images in the right size
3. Use the correct resolution

When we say format, it's mostly going to be `.jpeg`, `.png`, or `.gif`. Those are the mostly widely accepted formats, and in general this is good practice for any images in most situations. For the right size, think of how they'll appear on the site. If you want them to appear large, they should be saved as large images. Otherwise, they won't look natural. Pixels are less an issue as the most visible odd looking pixels usually come from the image size these days, if you have a low resolution image your image quality is poor. The best place to edit is going to be software like Photoshop (or the better free-version called GIMP) but Canva is also a free option for basic editing, albeit very basic.

## Basic Photo Editing

Whenever you're beginning to work on editing a photo, first decide on the format. If your picture is colorful, go for a `.jpeg`, otherwise if it's simple or monotone, use a `.png`. `.png` is also a nice format in that you can have transparent backgrounds, to do away with extra space filling up the background. You can sometimes use a `.gif`, but most of the time I see those are when they are moving images made up of many frames.

It should be known that when you're putting your images through size changes, it can affect the quality in different ways. Making an image smaller will decrease the size of the actual photo file while still retaining decent picture quality; increasing the size will greatly decrease the picture quality as it now has to account for pixels that were never there in the original image. _Cropping_ is when you keep the resolution of the image but remove portions of it for specific style choices.

The above formats mentioned belong to the _bitmap_ family, which means each image is made up of tiny boxes containing a color. Since computer's screens are made up of pixels, it makes sense how the two go hand in hand. However, a different format makes the other types cower in fear; the `.SVG`, or _Vector Image_. Vector images are created in programs like Adobe Illustrator, and instead of being made up of boxes like the other, this image type uses points on a plane with lines connecting them to create highly-scalable images that look good no matter how you manipulate them. These are obviously harder to make, but are worth the time investment in learning.

---

Next:
