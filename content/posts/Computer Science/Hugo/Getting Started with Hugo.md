---
aliases:
  - hugo
draft: false
tags:
  - computerscience
  - website
  - documentation
title: Getting Started with Hugo
date: 2024-07-26
---
Last Modified: August 01 2024 

-------------------------------------------------------------------------------

## Quick Start

It's remarkably easy to start using Hugo. So much so it makes me want to start working on my portfolio immediately. 

To start, we need to use [PowerShell](https://learn.microsoft.com/en-us/powershell/scripting/install/installing-powershell-on-windows?view=powershell-7.4) instead of Windows PowerShell. Apparently, they are different.

You also need to have Git installed. 

Once both are done, you can run the following commands:

1. `hugo new site quicksite`
	- This creates a new directory that will become our new website. `quicksite` is the name of your directory.
2. `cd quicksite`
	- Change directory to our new website
3. `git init`
	- Initialize a new git repository 
4. `git submodule add https://github.com/rhazdon/hugo-theme-hello-friend-ng.git themes/hello-friend-ng`
	- Adds a new submodule, for a theme called Hello Friend, cloning the GitHub page into a new directory called `themes`
5. `echo "theme = 'hello-friend-ng'" >> hugo.toml`
	- Appends the phrase `theme = 'hello-friend-ng'` into the `hugo.toml` file, which allows for the theme to be applied.
6. `hugo server`
	- Starts running the server for our new website!

We can set up our content, or the pages for our site, by creating it directly on the command line.

```cmd
hugo new content content.posts/first-time-post.md
```

This alone will just create the page. When opened, you'll just see the following:

```cmd
+++
title = 'First Time Post'
date = 'somedate'
draft = 'True'
+++
```

`date` will obviously be filled in and `draft` is set to `True`, in order to prevent anything from being published without your saying so. If you want to view it while still in draft mode, you can just add `-D` to the server run command.

You can start editing your file with whatever text editor you'd like, and see it change as the file is saved in real-time without having to restart the server constantly. Pretty cool.

## Configuring the Site

You can edit your sites configuration through the site's `hugo.toml` file. By default It should have three, `baseURL`, `languageCode`, and `title`. If you're following this exactly, you'll also have a `theme` from the command ran before.

To get the site running, you'll have to set the base URL to your own production site and change the title.

That just configures it. We still have to publish and deploy it. When publishing, Hugo takes the entirety of your site stored through the `/public` directory. Publishing is a very simple command:

```cmd
hugo
```

[Hosting Hugo Using Cloudflare]({{< ref "Hosting Hugo Using Cloudflare" >}})

## Basic Usage

As most command line interfaces (CLI) have, you can use `hugo help` to get more directed information.

The next section describes front matter and how it's used (Obsidian Properties) so I stopped for a bit and did some research. Properties/front matter is just the meta data of the page; the important information necessary (according to the author). 

The most important properties for me right now seem to be aliases since they make searching easier and faster apparently, as well as moving the tags into there, and using `draft` with Hugo. This page is the first to have that applied. 


### Draft, future, and expired content

There are a few instances in which Hugo won't publish your content:

- `draft` is `true`
- `date` is some future date
- `publishDate` is some future date
- `expiryDate` is some past date

You can override the first three with the following commands when running `hugo`:

```cmd
hugo --buildDrafts  # or -D
hugo --buildExpired  # or -E
hugo --buildFuture  # or -F
```

It is common practice to manually clear the contents of your public directory before each build to remove draft, expired, and future content.


## Directory Structure

Let's go over the directory/subdirectory structure.

### Site Skeleton

When you make a project using `hugo new site quicksite` will make this structure:

```
my-site/ 
├── archetypes/ 
│ └── default.md 
├── assets/ 
├── content/ 
├── data/ 
├── i18n/ 
├── layouts/ 
├── static/
├── themes/
└── hugo.toml <-- site configuration
```

You could also make a subdirectory for it which they bring up:

```
my-site/ 
├── archetypes/ 
│ └── default.md 
├── assets/ 
├── config/           <-- site configuration
│ └── _default/
|     └── hugo.toml
├── content/ 
├── data/ 
├── i18n/ 
├── layouts/ 
├── static/
├── themes/
```

Then, once built, it'll add a `public/` and `resources/` directory.

### Directories

- `archetypes/`: templates for new content.
- `assets/`: has global resources passed through some asset pipeline. Images, CSS, JavaScript, and TypeScript.
- `config/`: contains site configuration. For projects that need minimal configuration or don't need to behave differently in different environments, subdirectories likely aren't necessary.
- `content/`: contains the markup/markdown files and page resources.
- `data/`: contains data files (JSON, TOML, YAML, or XML) that modify the content or configuration of the site.
- `i18n/`: contains translation tables for multilingual sites.
- `layouts/`: contains templates to transform content, data, and resources into one website.
- `public/`: contains the published website
- `resources/`: contains cached output from Hugo's asset pipelines, which are generated whenever you run the `hugo` or `hugo server` commands.
- `static/`: contains the files that will be copied to the public directory when the site is built. 
- `themes/`: contains one or more themes


### Union File System

I read this like three times but I don't really understand? It's a way to break up and have multiple directories in your content directory.

Let's say you have the following structure:

```
home/ 
└── user/
  ├── my-site/
  │ ├── content/ 
  │ │ ├── books/ 
  │ │ │ ├── _index.md 
  │ │ │ ├── book-1.md
  │ │ │ └── book-2.md
  │ │ └── _index.md
  │ ├── themes/
  │ │ └── my-theme/
  │ └── hugo.toml
  └── shared-content/
  └── films/
   ├── _index.md 
   ├── film-1.md 
   └── film-2.md
```

You can use the following `yaml` configuration to mount the `films` directory into `content`:

```yaml
module:
  mounts:
   - source: content
     target: content
   - source: /home/user/shared-content
     target: content
```

Once mounted, it will become:

```
home/ 
└── user/
  └──  my-site/
   ├── content/ 
   │ ├── books/ 
   │ │ ├── _index.md 
   │ │ ├── book-1.md
   │ │ └── book-2.md
   | └── films/
   | | ├── _index.md 
   | | ├── film-1.md 
   | | └── film-2.md
   │ └── _index.md
   │ ├── themes/
   │ │ └── my-theme/
   │ └── hugo.toml

```