---
aliases: 
draft: false
tags:
  - computerscience
  - git
  - textbook
title: Learning Git - Chapter 7
date: 2024-10-22
updated: 2024-11-05T10:37
---

-------------------------------------------------------------------------------

# Creating and Pushing to a Remote Repository

Currently, we have three commits, `red`, `orange`, and `yellow`. We have two branches, both of them (`head` and `feature`) pointing at our `yellow` commit, and `HEAD` is attached to `main`.

Now that we're beginning to talk about remote repositories, it's important to understand how these projects are started. We've been working on our Rainbow project, which we know is a *local* repository. 

That's our first way; to start from a local repository. We already looked at how to start a local repository, so there are only two more steps: Create a remote repository using your service of choice, then *push* your local repository to your remote repository. We can use the `git push` command to make this happen.

The other way is to start from a remote repository. If you want to work on someone else's project, or you created an empty remote repository, you would need to *clone* the repository to your local machine to start working. 

Even if we have our local repository pushed into a remote repository, and changes made to either won't reflect in the other unless explicitly told to do so. That means when you make a commit in your local repository, it won't have any changes to the remote repository until you push them. 

Remote repositories utility cannot be understated; having access to all of your projects wherever you go, as well as being able to have collaborators and contribute to other people's projects, really makes this a worthwhile feature. 

> [!Example Book Project]
> Once again we're back to working on our book project. If I never decided to upload my work into remote repository, and my laptop got stolen or damaged, all of my work is lost. It would also be nice to have two workstations, and I can easily transfer my work from machine to machine without losing anything in the process.

To create our Rainbow project remote repository, we're going to have to create it, connect it, and push our directory into it. 

## Creating the Remote Repository

The creation and configuration is a split process between the local repository and the website of your hosting provider. GitHub will need a remote repository name, and will provide you with a URL (provided in both SSH and HTTPS).

To ensure as little confusion as possible, we're going to name our remote repository differently than our local. We'll call it `remote-repository`. You'll also be option to give the remote repository the option to be public or private. Private means that only you have access to it, while Public will leave it open for anyone on the internet to get access to it. 

Some remote repository providers will ask for additional files (Either a `README` or a `.gitignore`) but we'll ignore that for now, since we want to upload our entire local directory as is. The default branch name should also be `main`.

{{< image src="/images/remote_directory.png" alt="remote_directory" position="center" style="border-radius: 8px;" >}}

You should now have an empty remote repository. 