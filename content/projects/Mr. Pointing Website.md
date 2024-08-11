---
aliases:
  - website
draft: false
tags:
  - computerscience
  - website
  - project
title: Mr. Pointing Website
date: 2024-08-02
updated: 2024-08-11T16:18
---

-------------------------------------------------------------------------------

So, I want to make my website using Obsidian to write Markdown files, have Hugo collect and display them, then use Cloudflare to host it. I have a few things I know I need to get done:

- [x] Get pages formatted to look good on Hugo
- [x] Add `date` property to all pages 
- [ ] Get Excalidraw images linked
- [ ] Cloudflare Hugo Note Title Needs fixing
- [ ] Need to create something to format for Hugo's scientific notation
	- [ ] Intro to Algorithms
	- [ ] Khan Academy
- [x] Ignore Templates, re-route Excalidraw
- [x] Get mr.pointing domain name
- [ ] Create README
- [ ] Create Now Page
	- [ ] Reading/Listening/Watching
	- [ ] Web scraper to get info from Discogs
- [x] Update/Connect GitHub
- [x] Start [Hosting Hugo Using Cloudflare]({{< ref "Hosting Hugo Using Cloudflare" >}})

So some updates before I go to bed:

- There's an issue where the images need to be told explicitly, when turned into Hugo Markdown files, that the Excalidraw files are actually markdown files. So those have to be edited manually.
- All attachments need to be rewritten to not point to a markdown file like obsidian uses, but using Hugo's image reference `{{ $image := resources.Get "images/sunset.jpg" }}`

Find date and repalce with:


```
< image src="/images/DateFormatting.png" alt="Hello Friend" position="center" style="border-radius: 8px;" >
```

Dates have to be in this format:

```
YYYY-MM-DD
```

Replace Text Script:

```python
import os  
import re  
from pathlib import Path  
  
def read_file(file_path):  
    with open(file_path, 'r', encoding='utf-8') as file:  
        return file.read()  
  
def write_file(file_path, content):  
    with open(file_path, 'w', encoding='utf-8') as file:  
        file.write(content)  
  
def replace_text_in_content(content, search_text, replacement_text):  
    return re.sub(search_text, replacement_text, content)  
  
def process_directory(directory_path, search_text, replacement_text):  
    pathlist = Path(directory_path).glob('**/*.md')  
    for path in pathlist:  
        path_in_str = str(path)  
        print(f'Processing file: {path_in_str}')  
  
        content = read_file(path_in_str)  
        new_content = replace_text_in_content(content, search_text, replacement_text)  
        write_file(path_in_str, new_content)  
  
  
def main():  
    directory_path = input("Enter the directory path: ")  
    search_text = input("Enter the text to search for: ")  
    replacement_text = input("Enter the text to replace with: ")  
  
    process_directory(directory_path, search_text, replacement_text)  
    print("Text replacement completed.")  
  
if __name__ == '__main__':  
    main()
```

Obsidian to Hugo Script:

```python
from obsidian_to_hugo import ObsidianToHugo  
  
def filter_file(file_contents: str, file_path: str) -> bool:  
    if 'draft: false' in file_contents:  
        return True  
    else:  
        return False  
  
obsidian_to_hugo = ObsidianToHugo(  
    obsidian_vault_dir="C:/Users/rpoin/Documents/Main Brain",  
    hugo_content_dir="C:/Users/rpoin/quicksite/content",  
    filters=[filter_file],  
)  
  
obsidian_to_hugo.run()
```

My first initial `.toml` file:

```
baseURL = 'https://example.org/'
languageCode = 'en-us'
title = 'mr.pointing'
theme = 'hello-friend-ng'

paginate     = 10

[params]
  dateform        = "Jan 2, 2006"
  dateformShort   = "Jan 2"
  dateformNum     = "2006-01-02"
  dateformNumTime = "2006-01-02 15:04"

  # Subtitle for home
  homeSubtitle = "Python Teacher"

  # Set disableReadOtherPosts to true in order to hide the links to other posts.
  disableReadOtherPosts = false

  # Enable sharing buttons, if you like
  enableSharingButtons = false
  
  # Show a global language switcher in the navigation bar
  enableGlobalLanguageMenu = false

  # Metadata mostly used in document's head
  description = "My new homepage or blog"
  keywords = "homepage, blog"
  images = [""]

[taxonomies]
    category = "blog"
    tag      = "tags"
    series   = "series"

[languages]
  [languages.en]
    title = "Mr. Pointing"
    keywords = ""
    copyright = '<a href="https://creativecommons.org/licenses/by-nc/4.0/" target="_blank" rel="noopener">CC BY-NC 4.0</a>'
    

  [languages.en.params]
    subtitle  = "Python Teacher"

    [languages.en.params.logo]
      logoText = "mr. pointing"
      logoHomeLink = "/"
    # or
    #
    # path = "/img/your-example-logo.svg"
    # alt = "Your example logo alt text"

  # And you can even create generic menu
  [menu.main]
    identifier = "blog"
    name       = "Posts"
    url        = "/posts"
	
  [menu.main]
    identifier = "about"
    name       = "About"
    url        = "/about"
```

Ask ChatGPT with a picture of the website to give it a color scheme in hex based off red instead of hex # fe5186.

Images I think go in the metadata of the file?

I downloaded [an embed pdf shortcut](https://github.com/anvithks/hugo-embed-pdf-shortcode) to help out, you can use it like this:



The PDF embed didn’t work, I think it might be a linking issue.

Need to fix the projects pages, need a date fix.

Date issued fixed!

Next issue is to get all the images working. Files that need it:
- Fix Cloudflare Hugo Title!
- Intro to Algo Chapter 1
- Khan Academy



