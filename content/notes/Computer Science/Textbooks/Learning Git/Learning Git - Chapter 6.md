---
aliases: 
draft: false
tags:
  - computerscience
  - git
  - textbook
title: Learning Git - Chapter 6
date: 2024-10-01
updated: 2024-10-22T11:22
---

-------------------------------------------------------------------------------


# Hosting Services and Authentication

Everything we've done up until this point has been local. Even though some of the things we've looked at incentive's working in a group, if your repository is local no one else will have access to it. This is where public repositories come into play.

There are three main players in the repository game; GitHub, GitLab, and Bitbucket. I personally only have experience with GitHub, so we'll be focusing on that going forward. 

We connect to GitHub via HTTPS or SSH, and we're going to learn to make that connection now. 

## Setting Up a Hosting Service Account

Setting up an account is pretty easy. Go to [GitHub](https://github.com) and make an account. Since we're just learning, using your Loughlin account is fine. 

Now that we have an account, we have two ways of making changes to our repository;

1. Using GitHub's website and make changes there
2. Connecting the local repository to a remote repository and upload changes there

The second way is our preferred method, and within that decision lies that choice to use HTTPS or SSH. We're going to use HTTPS for this class, so we can look past SSH for now. 

### HTTPS

The *authentication* process, or identifying yourself to the service, is through a username/email address and password combination. This is made through your GitHub account, and the password is called a *Personal Access Token*.

Thankfully, the author of this book (she rocks btw) has a really thorough [tutorial](https://github.com/annaskoulikari/learninggit) on how to install Git and get started with GitHub. Follow the link and get started so we can move on to bigger and better things (Like chapter 7).



---
Next: 
[Chapter 7]({{< ref "Learning Git - Chapter 7" >}}) 
